-- Example for ~/.config/nvim/lua/plugins/diffview.lua
-- OR add this table directly into your main lazy.nvim plugin list

return {
  'sindrets/diffview.nvim',
  -- Recommended: Use an event to lazy-load the plugin for faster startup.
  -- 'BufReadPost' loads it after any buffer is read. 'VeryLazy' is also an option.
  event = 'BufReadPost',

  -- Optional: Basic configuration for diffview.
  -- You can customize options within this 'config' function.
  config = function()
    require('diffview').setup({
      -- These are default or common options. You can uncomment or change them.
      -- merged_if_no_diff = false, -- If true, diffview will merge windows for files that have no differences
      -- use_icons = true,          -- Display icons (requires nvim-web-devicons)
      -- diff_binaries = false,     -- Display binary files in diffview
      -- Add more options from :h diffview.nvim-options as you explore
    })
  end,

  -- Recommended: Define keymaps to quickly open Diffview.
  -- These keymaps will automatically load the plugin when pressed.
  -- Place these keymaps either here, or in your main keymaps file (e.g., lua/keymaps.lua)
  keys = {
    -- Opens Diffview to show current Git changes (unstaged, staged, unmerged)
    { '<leader>gd', ':DiffviewOpen<CR>', desc = 'Diffview: Open Git Diff' },

    -- Opens Diffview to show changes for the current file you are editing
    { '<leader>gh', ':DiffviewFile<CR>', desc = 'Diffview: Open Current File Diff' },

    -- Opens Diffview to browse Git commit history with diffs
    { '<leader>gl', ':DiffviewLog<CR>', desc = 'Diffview: Open Git Log Diff' },

    -- To close the Diffview window
    { '<leader>gq', ':DiffviewClose<CR>', desc = 'Diffview: Close Diffview' },

    -- You can add more as you get comfortable!
  }
}
