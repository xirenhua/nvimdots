local M = {}

local settings = require("core.settings")

local set_opts = function(opts)
    for name, value in pairs(opts) do
        vim.opt[name] = value
    end
end

M.basic_options = function()
    local opts = {
        mouse = "a",
        termguicolors = true,
        number = true,
        signcolumn = "yes",
        foldcolumn = "1",
        cursorline = true,
        laststatus = 3,
        wrap = false,
        scrolloff = 8,
        sidescrolloff = 8,
        fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" },
        ignorecase = true,
        smartcase = true,
        tabstop = 4,
        expandtab = true,
        shiftwidth = 4,
        smartindent = true,
        pumheight = 10,
        completeopt = { "menuone", "noselect" },
        swapfile = false,
        undofile = true,
        splitbelow = true,
        splitright = true,
    }

    set_opts(opts)
    vim.g.mapleader = settings.mapleader
end

M.neovide_options = function()
    -- local alpha = function(trans)
    --     return string.format("%x", math.floor(255 * trans))
    -- end

    vim.opt.guifont = "Monaco Nerd Font Mono:h12"
    -- vim.g.neovide_transparency = 0
    -- vim.g.neovide_background_color = "#1a1b26" .. alpha(0.9)
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_input_macos_alt_is_meta = true
    vim.g.neovide_remember_window_size = true
end

M.load = function()
    M.basic_options()
    if vim.g.neovide then
        M.neovide_options()
    end
end

M.ufo = function()
    local opts = {
        foldlevel = 99,
        foldlevelstart = 99,
    }

    set_opts(opts)
end

return M
