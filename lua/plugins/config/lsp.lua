local M = {}

local settings = require("core.settings").plugins.lsp
local mappings = require("core.mappings")

M.mason = function()
    require("mason").setup()
end

M.lspconfig = function()
    mappings.lspconfig()
end

M.null_ls = function()
    require("null-ls").setup()
end

M.mason_lspconfig = function()
    local lspconfig = require("lspconfig")

    local capabilities = lspconfig.util.default_config.capabilities
    if pcall(require, "cmp_nvim_lsp") then
        local extra = require("cmp_nvim_lsp").default_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, extra)
    end
    if pcall(require, "ufo") then
        local extra = {
            textDocument = {
                foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
            },
        }
        capabilities = vim.tbl_deep_extend("force", capabilities, extra)
    end

    require("mason-lspconfig").setup({ ensure_installed = settings.ensure_installed_lsp })
    require("mason-lspconfig").setup_handlers({
        function(server_name)
            lspconfig[server_name].setup({ capabilities = capabilities })
        end,
    })
end

M.mason_null_ls = function()
    local null_ls = require("null-ls")

    require("mason-null-ls").setup({
        ensure_installed = settings.ensure_installed_null_ls,
        handlers = {
            prettier = function()
                null_ls.register(null_ls.builtins.formatting.prettier.with({
                    filetypes = { "html", "css", "json", "yaml", "markdown" },
                }))
            end,
        },
    })
end

M.neodev = function()
    require("neodev").setup()
end

return M
