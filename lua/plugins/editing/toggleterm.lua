-- PLUGIN 2: akinsho/toggleterm.nvim for integrated terminal management.
-- Allows you to easily toggle a floating or split terminal inside Neovim.
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20, -- Default size for split (lines for horizontal, columns for vertical).
			-- You can adjust this if you switch to a split direction.
			hide_numbers = true, -- Hide line numbers in the terminal
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2, -- default: 1 for dark, 0 for light, This adjust dimming.
			start_in_insert = true,
			insert_mappings = true, -- Important if you want to use vim mappings in terminal
			persist_size = true,
			--direction = 'float',
			--float_opts = {
			--border = 'curved', -- 'single' | 'double' | 'rounded' | 'curved' | 'solid'
			--winblend = 3, -- transparency
			--height = 30, -- Set the height for the floating window (e.g., 30 lines)
			--width = 120, -- Set the width for the floating window (e.g., 120 columns)
			--row = nil, -- Center vertically
			--col = nil, -- Center hirizontally
			--},
			-- You can still use you existing <leader>tt mapping for convenience
			-- but you set the options in the setup function.
		})
	end,
} -- `config = true` means it uses its default setup.
