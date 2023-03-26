return {
    "alexghergh/nvim-tmux-navigation",
    cmd = "NvimTmuxNavigate",
    keys = {
        { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>",  desc = "Navigate down" },
        { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>",    desc = "Navigate up" },
        { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>",  desc = "Navigate left" },
        { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", desc = "Navigate right" },
    },
    config = function()
        require 'nvim-tmux-navigation'.setup()
    end
}
