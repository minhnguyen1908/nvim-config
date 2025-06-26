-- PLUGIN 7: Optional Colorscheme.
-- This changes the visual theme of Neovim. Choose one that you find aesthetically pleasing!
return { 'catppuccin/nvim', name = 'catppuccin', priority = 1000,
    config = function()
        vim.cmd.colorscheme 'catppuccin-macchiato' -- You can try 'catppuccin-mocha', 'catppuccin-latte', 'catppuccin-frappe'
    end
}
