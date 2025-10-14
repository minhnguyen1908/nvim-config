return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	-- In lua/plugins/neo-tree.lua
	config = function()
		require("neo-tree").setup({
			window = {
				mappings = {

					-- Remove default filter behavior of "/" key.
					["/"] = "none",

					-- Disable space key to avoid conflicts with other plugins like <leader>e - open/close neo-tree.
					["<space>"] = "none",

					-- Custom mapping to copy file/directory name/path to clipboard with options.
					["Y"] = function(state)
						local node = state.tree:get_node()
						if not node then
							return
						end

						local path = node:get_id()
						local name = node.name
						local modify = vim.fn.fnamemodify
						local results = {}
						local choice_names = {}

						if node.type == "directory" then
							results = { path, modify(path, ":."), modify(path, ":~"), name }
							choice_names = {
								"Choose path to copy:",
								"1. Absolute path: " .. results[1],
								"2. Path relative to CWD: " .. results[2],
								"3. Path relative to HOME: " .. results[3],
								"4. Directory name: " .. results[4],
							}
						else -- It's a file
							results = {
								path,
								modify(path, ":."),
								modify(path, ":~"),
								name,
								modify(name, ":r"),
								modify(name, ":e"),
							}
							choice_names = {
								"Choose to copy to clipboard:",
								"1. Absolute path: " .. results[1],
								"2. Path relative to CWD: " .. results[2],
								"3. Path relative to HOME: " .. results[3],
								"4. Filename: " .. results[4],
								"5. Filename without extension: " .. results[5],
								"6. Extension of the filename: " .. results[6],
							}
						end

						-- This new method builds a single string with newlines and uses vim.fn.input()
						local menu_text = table.concat(choice_names, "\n")
						local choice_str = vim.fn.input(menu_text .. "\n\nChoose a number: ")
						local choice_index = tonumber(choice_str)

						if choice_index and results[choice_index] then
							vim.fn.setreg('"', results[choice_index])
							vim.notify("Copied: " .. results[choice_index])
						elseif choice_str ~= "" and choice_str ~= nil then
							vim.notify("Invalid choice: " .. choice_str, vim.log.levels.WARN)
						end
					end,
				},
			},
		})
	end,
}
