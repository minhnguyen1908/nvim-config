-- nvim-config/lua/plugins/neodev.lua

return {
    "folke/neodev.nvim",
    priority = 1000,
    config = function ()
       require('neodev').setup({})
    end,
}
