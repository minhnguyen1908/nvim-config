-- PLUGIN 10: nvim-lualine/lualine.nvim - A fast and highly customizable Neovim statusline.
-- Makes your statusline at the bottom of the screen much more informative and good-looking.
return { 'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- For filetype icons in the statusline
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto', -- 'auto' or try 'onedark', 'material', 'tokyonight', etc.
                component_separators = { left = '?', right = '?'}, -- Aesthetic separators
                section_separators = { left = '?', right = '?'},    -- Aesthetic separators
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_last_status = true,
                padding = 1,
            },
            sections = { -- Customize what goes into each section of the statusline
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = { -- What shows up in inactive window statuslines
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {}, -- You can also configure a tabline
            extensions = {'nvim-tree', 'lazy'} -- Integrate with other plugins
        }
    end
}
