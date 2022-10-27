local M = {}
M.utils = {}

function M.get_focus(kanban)
	for i in pairs(kanban.items.lists) do
		local list = kanban.items.lists[i]
		for j in pairs(list.tasks) do
			local task = list.tasks[j]
			if vim.fn.win_getid() == task.win_id then
				return { list_num = i, task_num = j }
			end
		end
	end
	assert(false)
end

function M.create_blank_task(kanban)
	local blank_task = {
		title = "NoTitle",
		due = {},
		tag = {},
	}
	return blank_task
end

function M.create_window_text(task)
	local contents = { task.title }
	for i in pairs(task.due) do
		table.insert(contents, task.due[i])
	end
	for i in pairs(task.tag) do
		table.insert(contents, task.tag[i])
	end
	return contents
end

function M.get_max_task_show_int(kanban)
	local list_heihgt = kanban.items.lists[1].buf_conf.height
	local task_area_height = list_heihgt - 4 - 2
	local task_height = kanban.ops.layout.task_height + kanban.ops.layout.task_y_margin
	local show_task_height = task_area_height / task_height
	return show_task_height + 1
end

return M
