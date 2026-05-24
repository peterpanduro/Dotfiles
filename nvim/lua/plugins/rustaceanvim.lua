return {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    ft = { 'rust' },
    config = function()
        vim.g.rustaceanvim = {
            tools = {},
            server = {
                on_attach = function(_, bufnr)
                    local nmap = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'Rust: ' .. desc })
                    end
                    nmap('<leader>ca', function() vim.cmd.RustLsp('codeAction') end, '[C]ode [A]ction')
                    nmap('K', function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, 'Hover actions')
                    nmap('<leader>rd', function() vim.cmd.RustLsp('debuggables') end, '[R]ust [D]ebug')
                    nmap('<leader>rr', function() vim.cmd.RustLsp('runnables') end, '[R]ust [R]un')
                end,
                default_settings = {
                    ['rust-analyzer'] = {
                        cargo = { allFeatures = true },
                        checkOnSave = true,
                        check = { command = 'clippy' },
                    },
                },
            },
            dap = {},
        }
    end,
}
