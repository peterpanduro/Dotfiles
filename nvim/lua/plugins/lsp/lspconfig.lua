return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
    keys = {
        { "<leader>cr", vim.lsp.buf.rename,                                                    desc = "Rename" },
        { '<space>cf',  function() vim.lsp.buf.format { async = true, timeout_ms = 1000 } end, desc = "Format" },
        { "<space>ca",  vim.lsp.buf.code_action,                                               desc = "Code Actions" },
        { "[d", vim.diagnostic.goto_prev, desc = "Previous diagnostics" },
        { "]d", vim.diagnostic.goto_next, desc = "Next diagnostics" }
    },
    config = function()
        require("plugins.lsp.lua").setup()
        require("plugins.lsp.go").setup()
        require("plugins.lsp.rust").setup()
        require("plugins.lsp.typescript").setup()
        require("plugins.lsp.svelte").setup()

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            end,
        })
    end
}
