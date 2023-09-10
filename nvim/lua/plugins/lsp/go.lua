local M = {}
M.setup = function()
    local lspconfig = require('lspconfig')
    lspconfig.gopls.setup {}
end
return M
