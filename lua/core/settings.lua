local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

local lang_settings = {
    settings = {
        {
            lang = "python",
            lsp = "pyright",
            null_ls = "black",
        },
        {
            lang = "lua",
            lsp = "lua_ls",
            null_ls = "stylua",
        },
        {
            lang = "markdown",
            null_ls = "prettier",
        },
    },
    gather_fileds = function(self, field_name)
        local fields = {}

        for _, setting in ipairs(self.settings) do
            if setting[field_name] then
                table.insert(fields, setting[field_name])
            end
        end

        return fields
    end,
}

return {
    mapleader = " ",
    kind_icons = kind_icons,
    project_dirs = { "~/Codes", "~/tmp", "~/Downloads" },
    plugins = {
        dir = "plugins",
        theme = { name = "tokyonight-night", transparent = false },
        lsp = {
            enabled = true,
            ensure_installed_lsp = lang_settings:gather_fileds("lsp"),
            ensure_installed_null_ls = lang_settings:gather_fileds("null_ls"),
        },
        cmp = { enabled = true },
        treesitter = {
            enabled = true,
            ensure_installed = vim.list_extend(
                lang_settings:gather_fileds("lang"),
                { "regex", "bash", "markdown_inline" }
            ),
        },
        components = {
            enabled = function(name)
                local enabled_list = {
                    "telescope",
                    "neo_tree",
                    "toggleterm",
                    "diffview",
                    "trouble",
                    "lualine",
                    "alpha",
                }

                return vim.tbl_contains(enabled_list, name)
            end,
        },
        tools = {
            enabled = function(name)
                local enabled_list = {
                    "indent_blankline",
                    "gitsigns",
                    "illuminate",
                    "autopairs",
                    "targets",
                    "surround",
                    "comment",
                    "hop",
                    "ufo",
                    -- "noice",
                }

                return vim.tbl_contains(enabled_list, name)
            end,
        },
    },
}
