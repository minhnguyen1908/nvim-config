-- This file defines the nvim-autopairs plugin and its configuration.
return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    -- The entire config function goes here directly
    config = function()
        require('nvim-autopairs').setup({})
        -- the cmp integration line is NOT here, it's in cmp.lua
    end
}
