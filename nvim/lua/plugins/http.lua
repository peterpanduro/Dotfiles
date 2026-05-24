-- rest.nvim was fully rewritten and now requires luarocks + tree-sitter-http,
-- which breaks plain lazy installs. Pin to the last pre-rewrite commit and use
-- the old API. Set enabled = false if you don't use HTTP files.
return {
    "rest-nvim/rest.nvim",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    commit = "91f86731d6c6ca28b3e6f7372eafd6a36abb71ac",
    ft = "http",
    keys = {
        { "<leader>hr", "<Plug>RestNvim", desc = "[H]ttp [R]un" },
    },
    config = function()
        require("rest-nvim").setup({})
    end,
}
