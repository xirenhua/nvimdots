local M = {}

local settings = require("core.settings")
local mappings = require("core.mappings")

M.cmp = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
        experimental = { ghost_text = true },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        completion = {
            completeopt = "menuone",
        },
        mapping = mappings.nvim_cmp_inner_insert(),
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                vim_item.kind = settings.kind_icons[vim_item.kind]
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[SNIP]",
                    buffer = "[BUFF]",
                    path = "[PATH]",
                })[entry.source.name]

                return vim_item
            end,
        },
    })

    cmp.setup.cmdline({ "/", "?" }, {
        completion = {
            completeopt = "menuone,noselect",
        },
        mapping = mappings.nvim_cmp_inner_cmd(),
        sources = {
            { name = "buffer" },
        },
    })

    cmp.setup.cmdline(":", {
        completion = {
            completeopt = "menuone,noselect",
        },
        mapping = mappings.nvim_cmp_inner_cmd(),
        sources = {
            { name = "path" },
            { name = "cmdline" },
        },
    })
end

M.luasnip = function()
    require("luasnip").setup()

    require("luasnip.loaders.from_vscode").lazy_load()
end

return M
