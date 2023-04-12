local settings = require("core.settings").plugins.tools
local configs = require("plugins.config.tools")

return {
    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = settings.enabled("indent_blankline"),
        config = configs.indent_blankline,
    },
    {
        "lewis6991/gitsigns.nvim",
        enabled = settings.enabled("gitsigns"),
        config = configs.gitsigns,
    },
    {
        "RRethy/vim-illuminate",
        enabled = settings.enabled("illuminate"),
        config = configs.illuminate,
    },
    {
        "windwp/nvim-autopairs",
        enabled = settings.enabled("autopairs"),
        config = configs.autopairs,
    },
    {
        "wellle/targets.vim",
        enabled = settings.enabled("targets"),
        config = configs.targets,
    },
    {
        "kylechui/nvim-surround",
        enabled = settings.enabled("surround"),
        config = configs.surround,
    },
    {
        "numToStr/Comment.nvim",
        enabled = settings.enabled("comment"),
        config = configs.comment,
    },
    {
        "phaazon/hop.nvim",
        enabled = settings.enabled("hop"),
        config = configs.hop,
    },
    {
        "kevinhwang91/nvim-ufo",
        enabled = settings.enabled("ufo"),
        config = configs.ufo,
        dependencies = { "kevinhwang91/promise-async" },
    },
    {
        "folke/noice.nvim",
        enabled = settings.enabled("noice"),
        config = configs.noice,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
}
