local M = {}

local settings = require("core.settings").plugins.treesitter

M.treesitter = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = settings.ensure_installed,
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
        rainbow = { enable = true },
    })
end

return M
