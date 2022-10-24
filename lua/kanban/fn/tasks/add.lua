local M = {}
-- Absolute path
function M.add(kanban, list_num, task, add_position, open_bool)
	local target_list
	if list_num == nil then	
		local focus = kanban.fn.tasks.utils.get_focus(kanban)
		target_list = kanban.items.lists[focus.list_num]
	else
		target_list = kanban.items.lists[list_num]
	end

	local tasks = target_list.tasks
	task.buf_conf = {
		relative = "editor",
		row = 10,
		col = 10,
		width = target_list.buf_conf.width - 4,
		height = kanban.ops.layout.task_height,
		border = "rounded",
		style = "minimal",
		zindex = 50,
	}

	task.buf_nr = nil
	task.win_id = nil

	if add_position == "top" then
		table.insert(tasks, 1, task)
	elseif add_position == "bottom" then
		table.insert(tasks, #tasks+1, task)
	else
		assert(false)
	end

	if not open_bool then
		return
	end
	kanban.fn.tasks.open(kanban, task)
	kanban.fn.tasks.move.bottom(kanban)


end
return M
