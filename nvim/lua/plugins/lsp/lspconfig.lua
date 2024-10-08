return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- "gleam-lang/gleam.vim",
        "maurobalbi/glas",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { 'j-hui/fidget.nvim', opts = {} }, -- Useful status updates for LSP
        'folke/neodev.nvim',                -- Additional lua configuration, makes nvim stuff amazing!
        'simrat39/rust-tools.nvim',
    },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
    config = function()
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<space>cf', vim.lsp.buf.format, 'Format')
            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
            nmap('<leader>ca', '<cmd>CodeActionMenu<cr>', '[C]ode [A]ction')
            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<K>', vim.lsp.buf.signature_help, 'Signature Documentation')
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        local servers = {
            clangd = {},
            gopls = {},
            pyright = {},
            rust_analyzer = {},
            ts_ls = {
                on_attach = function(client)
                    -- this is important, otherwise ts_ls will format ts/js
                    -- files which we *really* don't want.
                    client.server_capabilities.documentFormattingProvider = false
                end,
            },
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }

        -- Setup neovim lua configuration
        require('neodev').setup()

        -- Rust-tools
        local rt = require("rust-tools")
        rt.setup({
            server = {
                on_attach = function(_, bufnr)
                    -- Hover actions
                    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                    -- Code action groups
                    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
            },
            tools = {
                inlay_hints = {
                    auto = true,
                },
            }
        })

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- Ensure the servers above are installed
        local mason_lspconfig = require 'mason-lspconfig'
        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }
            end
        }

        -- Gleam
        require('lspconfig').gleam.setup({
            -- cmd = { 'glas', '--stdio' },
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
}
