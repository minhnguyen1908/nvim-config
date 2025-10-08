return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	config = function()
		local notify = vim.notify

		require("neo-tree").setup({
			window = {
				mappings = {
					["Y"] = function(state)
						local focused_node = state.tree:get_node()
						if not focused_node or focused_node.type == "directory" then
							return
						end

						local filepath = focused_node.id
						local filename = focused_node.name
						local modify = vim.fn.fnamemodify

						local results = {
							filepath,
							modify(filepath, ":."),
							modify(filepath, ":~"),
							filename,
							modify(filename, ":r"),
							modify(filename, ":e"),
						}
						local choice_names = {
							"1. Absolute path: " .. results[1],
							"2. Path relative to CWD: " .. results[2],
							"3. Path relative to HOME: " .. results[3],
							"4. Filename: " .. results[4],
							"5. Filename without extension: " .. results[5],
							"6. Extension of the filename: " .. results[6],
						}

						local choice = vim.fn.input(table.concat(choice_names, "\n") .. "\nChoose: ")
						local choice_index = tonumber(choice)

						if choice_index and choice_index >= 1 and choice_index <= #results then
							local result = results[choice_index]
							vim.fn.setreg('"', result)
							notify("Copied: " .. result, vim.log.levels.INFO)
						else
							notify("Invalid choice: " .. choice, vim.log.levels.ERROR)
						end
					end,
				},
			},
		})
	end,
}
