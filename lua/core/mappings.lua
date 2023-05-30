local M = {}

local map = vim.keymap.set
local bufmap = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = opts.buffer or true
    vim.keymap.set(mode, lhs, rhs, opts)
end

M.load = function()
    map({ "n", "x" }, "<C-u>", "5<C-y>")
    map({ "n", "x" }, "<C-d>", "5<C-e>")

    map({ "n", "x", "o" }, "/", "/\\v")
    map({ "n", "x", "o" }, "?", "?\\v")
    map({ "n", "x", "o" }, "'", "`")
    map({ "n", "x", "o" }, "`", "'")

    map("t", "<D-v>", '<C-\\><C-o>"*p')
    map("i", "<D-v>", "<C-r>*")

    map({ "n", "x" }, "<leader>y", '"0y')
    map({ "n", "x" }, "<leader>p", '"0p')
    map("n", "<leader>P", '"0P')

    map("n", "gs", ":%s/\\v")
    map("x", "gs", ":s/\\v")

    map("x", "<", "<gv")
    map("x", ">", ">gv")

    map("n", "zO", "zczO")

    map("n", "gv", "<cmd>vsplit<cr>")
    map("n", "gx", "<cmd>split<cr>")
    map("n", "gw", "<C-w>w")
    map("n", "g=", "<C-w>=")
    map("n", "go", "<C-w>o")
    map("n", "gc", "<C-w>c")
    map("n", "gh", "<C-w>h")
    map("n", "gj", "<C-w>j")
    map("n", "gk", "<C-w>k")
    map("n", "gl", "<C-w>l")

    map("n", "H", "<cmd>bprevious<cr>")
    map("n", "L", "<cmd>bnext<cr>")
    map("n", "[q", "<cmd>cprevious<cr>")
    map("n", "]q", "<cmd>cnext<cr>")
    map("n", "[t", "<cmd>tabprevious<cr>")
    map("n", "]t", "<cmd>tabnext<cr>")

    map("n", "<M-j>", "<cmd>resize -2<cr>")
    map("n", "<M-k>", "<cmd>resize +2<cr>")
    map("n", "<M-h>", "<cmd>vertical resize -2<cr>")
    map("n", "<M-l>", "<cmd>vertical resize +2<cr>")

    map("t", "<C-h>", "<C-\\><C-n>")
end

M.lspconfig = function()
    map("n", "K", vim.lsp.buf.hover)
    map("n", "gd", vim.lsp.buf.definition)
    map("n", "gr", vim.lsp.buf.references)
    map("n", "<leader>lf", vim.lsp.buf.format)
    map("n", "<leader>lr", vim.lsp.buf.rename)
    map("n", "<leader>la", vim.lsp.buf.code_action)

    map("n", "M", vim.diagnostic.open_float)
    map("n", "[d", vim.diagnostic.goto_prev)
    map("n", "]d", vim.diagnostic.goto_next)
    map("n", "<leader>lq", vim.diagnostic.setqflist)
    map("n", "<leader>ll", vim.diagnostic.setloclist)

    if pcall(require, "trouble") then
        map("n", "gd", "<cmd>Trouble lsp_definitions<cr>")
        map("n", "gr", "<cmd>Trouble lsp_references<cr>")
    end
end

M.nvim_cmp_inner_insert = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    return cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-5),
        ["<C-d>"] = cmp.mapping.scroll_docs(5),
        ["<C-f>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-b>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<cr>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
                cmp.confirm()
            else
                fallback()
            end
        end, { "i", "s" }),
    })
end
M.nvim_cmp_inner_cmd = function()
    local cmp = require("cmp")

    return cmp.mapping.preset.cmdline()
end

M.telescope = function()
    local builtin = require("telescope.builtin")
    local extensions = require("telescope").extensions

    map("n", "<C-space>", builtin.find_files)
    map("n", "<leader>ff", builtin.builtin)
    map("n", "<leader>fH", function()
        builtin.find_files({ hidden = true, no_ignore = true })
    end)
    map("n", "<leader>f/", function()
        builtin.live_grep({ additional_args = { "-U" } })
    end)
    map("n", "<leader>fb", builtin.buffers)
    map("n", "<leader>fh", builtin.help_tags)
    map("n", "<leader>fg", builtin.git_status)
    map("n", "<leader>fv", builtin.git_bcommits)
    map("n", "<leader>fd", builtin.diagnostics)
    map("n", "<leader>fs", builtin.lsp_document_symbols)
    map("n", "<leader>fS", builtin.lsp_workspace_symbols)
    map("n", "<leader>ft", builtin.tagstack)
    map("n", "<leader>fj", builtin.jumplist)
    map("n", "<leader>fm", builtin.marks)

    map("n", "<leader>fp", function()
        extensions.project.project({ display_type = "full" })
    end)
end
M.telescope_inner = function()
    local res = {
        defaults = {
            mappings = {
                i = {
                    ["<esc>"] = "close",
                    ["<C-h>"] = { "<esc>", type = "command" },
                },
            },
        },
    }

    if pcall(require, "trouble") then
        local trouble = require("trouble.providers.telescope")
        res = vim.tbl_deep_extend("error", res, {
            defaults = {
                mappings = {
                    i = {
                        ["<C-q>"] = trouble.open_with_trouble,
                        ["<M-q>"] = trouble.open_selected_with_trouble,
                    },
                    n = {
                        ["<C-q>"] = trouble.open_with_trouble,
                        ["<M-q>"] = trouble.open_selected_with_trouble,
                    },
                },
            },
        })
    end

    return res
end
M.telescope_keys = {
    "<C-space>",
    "<leader>ff",
    "<leader>fH",
    "<leader>f/",
    "<leader>fb",
    "<leader>fh",
    "<leader>fg",
    "<leader>fv",
    "<leader>fd",
    "<leader>fs",
    "<leader>fS",
    "<leader>ft",
    "<leader>fj",
    "<leader>fm",
    "<leader>fp",
}
M.telescope_cmds = { "Telescope" }

M.neo_tree = function()
    map("n", "<leader>ef", "<cmd>Neotree float filesystem toggle<cr>")
    map("n", "<leader>eg", "<cmd>Neotree float git_status toggle<cr>")
    map("n", "<leader>es", "<cmd>Neotree float document_symbols toggle<cr>")
end
M.neo_tree_inner = function()
    return {
        window = {
            mappings = {
                ["<space>"] = "none",

                ["o"] = "toggle_node",
                ["z"] = "close_all_nodes",
                ["Z"] = "expand_all_nodes",
                ["q"] = "close_window",
                ["R"] = "refresh",
                ["?"] = "show_help",
                ["<"] = "prev_source",
                [">"] = "next_source",

                ["<cr>"] = "open",
                ["T"] = "open_tabnew",
                ["P"] = { "toggle_preview", config = { use_float = true } },

                ["a"] = "add",
                ["d"] = "delete",
                ["r"] = "rename",
                ["y"] = "copy_to_clipboard",
                ["x"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                ["c"] = "copy",
                ["m"] = "move",
            },
        },
        filesystem = {
            window = {
                mappings = {
                    ["/"] = "fuzzy_finder",
                    ["#"] = "fuzzy_sorter",
                    ["f"] = "filter_on_submit",
                    ["F"] = "clear_filter",
                    ["H"] = "toggle_hidden",
                    ["."] = "set_root",
                    ["<bs>"] = "navigate_up",

                    ["[g"] = "prev_git_modified",
                    ["]g"] = "next_git_modified",
                },
                fuzzy_finder_mappings = {
                    ["<C-n>"] = "move_cursor_down",
                    ["<C-p>"] = "move_cursor_up",
                },
            },
        },
        git_status = {
            window = {
                mappings = {
                    ["ga"] = "git_add_file",
                    ["gA"] = "git_add_all",
                    ["gr"] = "git_unstage_file",
                },
            },
        },
        document_symbols = {
            window = {
                mappings = {
                    ["<cr>"] = "jump_to_symbol",

                    ["a"] = "none",
                    ["d"] = "none",
                    ["r"] = "none",
                    ["y"] = "none",
                    ["x"] = "none",
                    ["p"] = "none",
                    ["c"] = "none",
                    ["m"] = "none",
                },
            },
        },
    }
end
M.neo_tree_keys = { "<leader>ef", "<leader>eg", "<leader>es" }
M.neo_tree_cmds = { "Neotree" }

M.toggleterm_inner = function()
    return { open_mapping = "<C-j>" }
end
M.toggleterm_keys = { "<C-j>" }
M.toggleterm_cmds = { "ToggleTerm" }

M.diffview = function()
    map("n", "<leader>go", "<cmd>DiffviewOpen<cr>")
    map("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>")
end
M.diffview_keys = { "<leader>go", "<leader>gh" }
M.diffview_cmds = { "DiffviewOpen", "DiffviewFileHistory" }

M.trouble = function()
    local trouble = require("trouble")

    map("n", "<leader>qo", "<cmd>Trouble<cr>")
    map("n", "<leader>qc", "<cmd>TroubleClose<cr>")
    map("n", "<leader>qq", "<cmd>Trouble quickfix<cr>")
    map("n", "<leader>ql", "<cmd>Trouble loclist<cr>")
    map("n", "<leader>qd", "<cmd>Trouble document_diagnostics<cr>")
    map("n", "<leader>qD", "<cmd>Trouble workspace_diagnostics<cr>")
    map("n", "[q", function()
        trouble.previous({ skip_groups = true, jump = true })
    end)
    map("n", "]q", function()
        trouble.next({ skip_groups = true, jump = true })
    end)
end
M.trouble_keys = { "<leader>qo", "<leader>qc", "<leader>qq", "<leader>ql", "<leader>qd", "<leader>qD", "gd", "gr" }
M.trouble_cmds = { "Trouble", "TroubleClose" }

M.gitsigns = function()
    local gitsigns = require("gitsigns")

    map("n", "]c", function()
        if vim.wo.diff then
            return "]c"
        end
        gitsigns.next_hunk()
        return "<ignore>"
    end, { expr = true })
    map("n", "[c", function()
        if vim.wo.diff then
            return "[c"
        end
        gitsigns.prev_hunk()
        return "<ignore>"
    end, { expr = true })
    map("n", "<leader>hs", gitsigns.stage_hunk)
    map("n", "<leader>hr", gitsigns.reset_hunk)
    map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)
    map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)
    map("n", "<leader>hS", gitsigns.stage_buffer)
    map("n", "<leader>hR", gitsigns.reset_buffer)
    map("n", "<leader>hu", gitsigns.undo_stage_hunk)
    map("n", "<leader>hp", gitsigns.preview_hunk)
    map("n", "<leader>hb", gitsigns.blame_line)
    map("n", "<leader>hd", gitsigns.diffthis)
    map("n", "<leader>hD", function()
        gitsigns.diffthis("HEAD")
    end)
    map("n", "<leader>hq", gitsigns.setqflist)
end

M.surround_inner = function()
    return {
        keymaps = {
            insert = false,
            insert_line = false,
            normal = "ys",
            normal_cur = "yss",
            normal_line = "yS",
            normal_cur_line = "ySS",
            visual = "s",
            visual_line = "S",
            delete = "ds",
            change = "cs",
        },
    }
end

M.comment_inner = function()
    return {
        opleader = { line = "<leader>c", block = "<leader>b" },
        toggler = { line = "<leader>cc", block = "<leader>bb" },
        extra = { above = "<leader>cO", below = "<leader>co", eol = "<leader>cA" },
    }
end

M.hop = function()
    local hop = require("hop")
    local modes = { "n", "x", "o" }

    map(modes, "<leader>s", function()
        hop.hint_char2({ current_line_only = true })
    end)
    map(modes, "s", function()
        hop.hint_char2()
    end)
    map(modes, "<leader>/", function()
        hop.hint_patterns()
    end)
end

M.ufo = function()
    local ufo = require("ufo")

    map("n", "zR", ufo.openAllFolds)
    map("n", "zM", ufo.closeAllFolds)
    map("n", "zz", ufo.closeFoldsWith)
    map("n", "zp", ufo.peekFoldedLinesUnderCursor)
end
M.ufo_inner = function()
    return {
        preview = {
            mappings = {
                scrollB = "<C-b>",
                scrollF = "<C-f>",
                scrollU = "<C-u>",
                scrollD = "<C-d>",
                scrollE = "<C-e>",
                scrollY = "<C-y>",
                jumpTop = "gg",
                jumpBot = "G",
                close = "q",
                switch = "<tab>",
                trace = "<cr>",
            },
        },
    }
end

M.noice = function()
    local noice_lsp = require("noice.lsp")

    vim.keymap.set("n", "<C-u>", function()
        if not noice_lsp.scroll(-5) then
            return "5<C-y>"
        end
    end, { expr = true })

    vim.keymap.set("n", "<C-d>", function()
        if not noice_lsp.scroll(5) then
            return "5<C-e>"
        end
    end, { expr = true })
end

return M
