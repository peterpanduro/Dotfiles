local M = {}
M.setup = function()
    local lspconfig = require('lspconfig')
    lspconfig.rust_analyzer.setup {}
end
return M
