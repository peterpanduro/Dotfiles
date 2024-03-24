return {
    "github/copilot.vim",
    event = "VeryLazy",
    cmd = "Copilot",
    config = function()
        vim.keymap.set("i", "<C-Y>", 'copilot#Accept("\\<CR>")', {
            expr = true,
            replace_keycodes = false,
        })
        vim.g.copilot_no_tab_map = true
        vim.keymap.del('i', '<Tab>')
    end
}
