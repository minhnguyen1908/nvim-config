-- ~/.config/nvim/lua/plugins/render-markdown.lua
-- OR add this entry directly into your main plugins list
return {
  'MeanderingProgrammer/render-markdown.nvim',
  -- This tells Lazy.nvim to load it only for markdown files
  ft = 'markdown',
  -- You might need to configure it if you have other markdown plugins
  -- config = function()
  --   -- Set custom commands or keymaps here
  -- end,
}
