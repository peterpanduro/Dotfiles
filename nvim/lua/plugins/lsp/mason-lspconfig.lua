return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim"
    },
    cmd = {
        "LspInstall",
        "LspUninstall"
    },
    config = function()
        require("mason-lspconfig").setup()
    end
}
