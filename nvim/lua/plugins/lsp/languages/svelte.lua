local M = {}
M.setup = function()
    local lspconfig = require('lspconfig')
    lspconfig.svelte.setup {}
end
return M
