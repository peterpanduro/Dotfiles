return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },             -- Required
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },     -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'L3MON4D3/LuaSnip' },     -- Required
    },
    ft = { "lua", "rust" },
    cmd = { "Mason" },
    keys = {
        { "<leader>cm", ":Mason<cr>", desc = "Mason" },
        {
            '<leader>cf',
            function()
                vim.lsp.buf.format({ async = false, timeout_ms = 1000 })
            end,
            desc = "Format"
        },
    },
    config = function()
        local lsp = require('lsp-zero').preset({})
        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({ buffer = bufnr })
        end)
        lsp.ensure_installed({
            'lua_ls',
            'rust_analyzer'
        })
        lsp.format_on_save({
            servers = {
                ['lua_ls'] = { 'lua' },
                ['rust_analyzer'] = { 'rust' },
            }
        })

        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls()) -- (Optional) Configure lua language server for neovim
        lsp.setup()
    end
}
