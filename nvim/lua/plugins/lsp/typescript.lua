local M = {}
M.setup = function()
    local lspconfig = require('lspconfig')
    lspconfig.tsserver.setup {}
end
return M
