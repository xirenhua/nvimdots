local settings = require("core.settings").plugins.lsp
local configs = require("plugins.config.lsp")

return {
    {
        "williamboman/mason.nvim",
        lazy = true,
        config = configs.mason,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        config = configs.lspconfig,
        dependencies = { "folke/neodev.nvim" },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        enabled = settings.enabled,
        config = configs.mason_lspconfig,
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        lazy = true,
        config = configs.null_ls,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        enabled = settings.enabled,
        config = configs.mason_null_ls,
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
    },
    {
        "folke/neodev.nvim",
        lazy = true,
        config = configs.neodev,
    },
}
