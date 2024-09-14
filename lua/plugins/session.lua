return {
	{
		"okuuva/auto-save.nvim",
		event = "BufEnter",
		keys = {
			{
				"<leader>Wa",
				"<cmd>ASToggle<CR>",
				desc = "Toggle autosave",
				mode = "n",
			},
		},
		opts = {
			enabled = true,
			execution_message = {
				message = function()
					return "Saved at " .. os.date("%H:%M:%S")
				end,
				-- message = nil, -- this if you dont want msg
				dim = 0.18, -- dim the color of `message`
				cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
			},
			trigger_events = { -- See :h events
				immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
				defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
				cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
			},
			write_all_buffers = false, -- write all buffers when the current one meets `condition`
			debounce_delay = 10000, -- saves the file at most every `debounce_delay` milliseconds
			debug = false,
		},
	},
}
