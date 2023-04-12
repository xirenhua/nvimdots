local M = {}

local options = require("core.options")
local mappings = require("core.mappings")

M.indent_blankline = function()
    require("indent_blankline").setup({ show_current_context = true })
end

M.gitsigns = function()
    require("gitsigns").setup({
        numhl = true,
        sign_priority = 1000,
        preview_config = { border = "rounded" },
        on_attach = mappings.gitsigns,
    })
end

M.illuminate = function()
end

M.autopairs = function()
    require("nvim-autopairs").setup()
end

M.targets = function()
end

M.surround = function()
    require("nvim-surround").setup(vim.tbl_deep_extend("error", {}, mappings.surround_inner()))
end

M.comment = function()
    require("Comment").setup(vim.tbl_deep_extend("error", {}, mappings.comment_inner()))
end

M.hop = function()
    require("hop").setup()
    mappings.hop()
end

M.ufo = function()
    require("ufo").setup(vim.tbl_deep_extend("error", {
        open_fold_hl_timeout = 0,
        preview = {
            win_config = { winblend = 0 },
        },
    }, mappings.ufo_inner()))
    mappings.ufo()
    options.ufo()
end

M.noice = function()
    require("noice").setup({
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            lsp_doc_border = true,
        },
    })
    mappings.noice()
end

return M
