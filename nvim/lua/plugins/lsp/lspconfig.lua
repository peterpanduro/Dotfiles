return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { 'j-hui/fidget.nvim', opts = {} }, -- Useful status updates for LSP
        'folke/lazydev.nvim',               -- Additional lua configuration, makes nvim stuff amazing!
    },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "rust_analyzer" },
            automatic_installation = true,
            automatic_enable = true,
        })
    end
}
