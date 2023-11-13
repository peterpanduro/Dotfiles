return {
    "Lilja/zellij.nvim",
    cmd = { "ZellijNavigateLeft", "ZellijNavigateRight", "ZellijNavigateUp", "ZellijNavigateDown", "ZellijNewPane",
        "ZellijNewTab", "ZellijRenamePane", "ZellijRenameTab" },
    keys = {
        -- { "<Alt-j>", "<Cmd>ZellijNavigateDown<CR>",  desc = "Navigate down" },
        -- { "<Alt-k>", "<Cmd>ZellijNavigateUp<CR>",    desc = "Navigate up" },
        { "<Alt-h>", "<Cmd>ZellijNavigateLeft<CR>",  desc = "Navigate left" },
        { "<Alt-l>", "<Cmd>ZellijNavigateRight<CR>", desc = "Navigate right" },
    },
    config = function()
        require('zellij').setup()
    end
}
