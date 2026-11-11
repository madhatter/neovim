-- ============================================================================
-- JAR URI HANDLER (for kotlin-lsp jar:// navigation)
-- ============================================================================

local M = {}

-- kotlin-lsp returns jar:// URIs for external dependencies (e.g. library sources).
-- Neovim can't open these directly, so we extract the file from the JAR and cache it locally.
local function extract_jar_uri(uri)
	-- URI format: jar:///path/to/file.jar!/internal/path/File.kt
	local jar_path = uri:match("^jar://(/[^!]+)!/")
	local internal_path = uri:match("^jar://[^!]+!/(.+)")
	if not jar_path or not internal_path then
		return nil
	end

	local cache_dir = vim.fn.stdpath("cache") .. "/kotlin-jar-sources"
	local output_file = cache_dir .. "/" .. internal_path
	vim.fn.mkdir(vim.fn.fnamemodify(output_file, ":h"), "p")

	-- Extract only if not already cached
	if vim.fn.filereadable(output_file) == 0 then
		local content = vim.fn.system({ "unzip", "-p", jar_path, internal_path })
		if vim.v.shell_error == 0 then
			vim.fn.writefile(vim.split(content, "\n", { plain = true }), output_file)
		end
	end

	return vim.fn.filereadable(output_file) == 1 and output_file or nil
end

-- Custom gd for Kotlin: bypasses fzf-lua and Neovim's internal buf.lua handler,
-- both of which don't handle jar:// URIs. Makes the LSP request directly,
-- rewrites jar:// URIs if needed, then navigates manually.
function M.go_to_definition()
	local client = vim.lsp.get_clients({ bufnr = 0, name = "kotlin_lsp" })[1]
	if not client then
		vim.notify("kotlin_lsp not attached", vim.log.levels.WARN)
		return
	end
	local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
	client:request("textDocument/definition", params, function(err, result)
		if err then
			vim.notify("Definition request failed: " .. (err.message or vim.inspect(err)), vim.log.levels.WARN)
			return
		end
		if not result then
			vim.notify("No definition found", vim.log.levels.INFO)
			return
		end

		-- Normalize: single Location or array of Locations
		local locations = (result.uri or result.targetUri) and { result } or result
		if vim.tbl_isempty(locations) then
			vim.notify("No definition found", vim.log.levels.INFO)
			return
		end

		local loc = locations[1]
		local uri = loc.uri or loc.targetUri
		if uri and uri:match("^jar://") then
			local file_path = extract_jar_uri(uri)
			if file_path then
				uri = vim.uri_from_fname(file_path)
			end
		end

		-- Push current position to jump list so ^o navigates back
		vim.cmd("normal! m'")
		vim.cmd("edit " .. vim.fn.fnameescape(vim.uri_to_fname(uri)))
		local range = loc.range or loc.targetSelectionRange or loc.targetRange
		if range then
			vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
		end
	end, 0)
end

return M
