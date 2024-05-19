return {
    "hiasr/vim-zellij-navigator.nvim",
    event = "VeryLazy",
    config = function()
        require('vim-zellij-navigator').setup()
    end
}
