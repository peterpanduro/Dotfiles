local M = {}
M.setup = function()
    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }
            }
        }

    }
end
return M
