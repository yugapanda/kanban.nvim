local M = {}

function M.highlight(kanban, task)
	local lines = vim.fn.getbufline(task.buf_nr, 1, "$")
	local hi = vim.api.nvim_buf_add_highlight
	hi(task.buf_nr, 0, "TaskTitle", 0, 0, -1)
	for i = 2, #lines do
		if string.match(lines[i], "^" .. kanban.ops.markdown.due_head .. ".*$") then
			hi(task.buf_nr, 0, "TaskDue", i - 1, 0, -1)
		elseif string.match(lines[i], "^" .. kanban.ops.markdown.tag_head .. ".*$") then
			hi(task.buf_nr, 0, "TaskTag", i - 1, 0, -1)
		end
	end
	vim.api.nvim_win_set_option(task.win_id, 'winhighlight', 'NormalFloat:TaskFloat')
end
return M
