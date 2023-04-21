return {
    "jiaoshijie/undotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = { "UndotreeToggle" },
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Undotree" },
    },
    config = function()
        require('undotree').setup()
    end,
}
