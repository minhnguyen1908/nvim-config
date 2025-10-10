-- Example for ~/.config/nvim/lua/plugins/diffview.lua
-- OR add this table directly into your main lazy.nvim plugin list

return {
  'sindrets/diffview.nvim',
  -- Keymaps are now defined in lua/keymaps.lua to centralize configuration.
  -- The plugin will be lazy-loaded when one of those keymaps is pressed.
  config = function()
    require('diffview').setup({
      -- These are default or common options. You can uncomment or change them.
      -- merged_if_no_diff = false, -- If true, diffview will merge windows for files that have no differences
      -- use_icons = true,          -- Display icons (requires nvim-web-devicons)
      -- diff_binaries = false,     -- Display binary files in diffview
      -- Add more options from :h diffview.nvim-options as you explore
    })
  end,
}
