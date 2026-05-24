return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { 'j-hui/fidget.nvim',  opts = {} },
        { 'folke/lazydev.nvim', ft = "lua", opts = {} },
    },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
    config = function()
        -- Keymaps on LspAttach
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
            callback = function(event)
                local bufnr = event.buf
                local nmap = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
                end

                nmap('<leader>cf', function() vim.lsp.buf.format({ async = true }) end, '[C]ode [F]ormat')
                nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                nmap('<leader>cd', vim.diagnostic.open_float, '[C]ode [D]iagnostic')
                nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
                nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
                nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                nmap('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, '[W]orkspace [L]ist Folders')

                local ok_telescope, telescope = pcall(require, 'telescope.builtin')
                if ok_telescope then
                    nmap('gr', telescope.lsp_references, '[G]oto [R]eferences')
                    nmap('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
                    nmap('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
                    nmap('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                end

                vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help,
                    { buffer = bufnr, desc = 'LSP: Signature help' })

                -- ts_ls should not format (prettier/eslint handles that)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.name == 'ts_ls' then
                    client.server_capabilities.documentFormattingProvider = false
                end

                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
            end,
        })

        -- Capabilities: include nvim-cmp's if available
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
        if ok_cmp then
            capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())
        end

        -- Global defaults for all servers (Neovim 0.11+ API)
        vim.lsp.config('*', { capabilities = capabilities })

        -- Per-server overrides
        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        })

        local servers = { 'clangd', 'gopls', 'pyright', 'ts_ls', 'lua_ls' }

        require('mason-lspconfig').setup({
            ensure_installed = servers,
            automatic_installation = true,
        })

        vim.lsp.enable(servers)

        -- rust_analyzer is configured by rustaceanvim.

        -- Diagnostic UI
        vim.diagnostic.config({
            virtual_text = { spacing = 2, prefix = '●' },
            severity_sort = true,
            float = { border = 'rounded', source = true },
        })
    end
}
