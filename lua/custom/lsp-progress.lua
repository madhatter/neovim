-- Track active LSP progress tasks for the statusline
local M = {}

local max_message_length = 40
-- Idle time after the last task before a client counts as ready
local quiet_ms = 3000
-- Clients that never report progress and would always show as pending
local ignored = { copilot = true }

-- active[client_id][token] = { title, message, percentage, updated }
local active = {}
-- done[client_id] = { title, at } of the last finished task
local done = {}
-- notified[client_id] = true once the ready notification was shown
local notified = {}

-- Notify once per client when it becomes ready for the first time
local function notify_ready(client_id)
	local last = done[client_id]
	if notified[client_id] or not last or next(active[client_id] or {}) ~= nil then
		return
	end
	if vim.uv.now() - last.at < quiet_ms then
		return
	end
	notified[client_id] = true
	local client = vim.lsp.get_client_by_id(client_id)
	vim.notify(("LSP [%s] ready"):format(client and client.name or client_id))
end

-- Escape '%' so server messages can't break the statusline expression
local function escape(text)
	return (tostring(text):gsub("%%", "%%%%"))
end

function M.setup()
	local group = vim.api.nvim_create_augroup("UserLspProgress", { clear = true })

	vim.api.nvim_create_autocmd("LspProgress", {
		group = group,
		callback = function(ev)
			local client_id = ev.data.client_id
			local params = ev.data.params
			local value = params.value
			if type(value) ~= "table" then
				return
			end

			active[client_id] = active[client_id] or {}
			if value.kind == "end" then
				local task = active[client_id][params.token]
				active[client_id][params.token] = nil
				done[client_id] = { title = task and task.title, at = vim.uv.now() }
				-- Redraw once the quiet period is over to show the ready state
				vim.defer_fn(function()
					vim.cmd.redrawstatus()
					notify_ready(client_id)
				end, quiet_ms + 100)
			else
				active[client_id][params.token] = {
					title = value.title,
					message = value.message,
					percentage = value.percentage,
					updated = vim.uv.now(),
				}
			end
			vim.cmd.redrawstatus()
		end,
	})
end

-- Statusline text for clients attached to the current buffer
function M.status()
	local parts = {}
	local clients = vim.tbl_filter(function(c)
		return not ignored[c.name]
	end, vim.lsp.get_clients({ bufnr = 0 }))
	for _, client in ipairs(clients) do
		local count, latest = 0, nil
		for _, task in pairs(active[client.id] or {}) do
			count = count + 1
			if not latest or task.updated > latest.updated then
				latest = task
			end
		end

		local text
		if latest then
			text = latest.title or "working"
			if latest.message and latest.message ~= "" then
				text = text .. ": " .. tostring(latest.message):sub(1, max_message_length)
			end
			text = escape(text)
			if type(latest.percentage) == "number" then
				text = text .. string.format(" %d%%%%", math.floor(latest.percentage))
			end
			if count > 1 then
				text = text .. string.format(" (+%d)", count - 1)
			end
		elseif done[client.id] and vim.uv.now() - done[client.id].at >= quiet_ms then
			text = "✓"
		elseif done[client.id] then
			text = escape("… " .. (done[client.id].title or "settling"))
		else
			text = "…"
		end
		table.insert(parts, escape(client.name) .. " " .. text)
	end
	return table.concat(parts, " | ")
end

return M
