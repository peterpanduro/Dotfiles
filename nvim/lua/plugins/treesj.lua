return {
  'Wansmer/treesj',
  keys = {
        { "<leader>ct", "<cmd>TSJToggle<cr>", desc = "[C]ode Fold [T]oggle " },
        { "<leader>cs", "<cmd>TSJSplit<cr>", desc = "[C]ode Fold [S]plit" },
        { "<leader>cj", "<cmd>TSJJoin<cr>", desc = "[C]ode Fold [J]oin" },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({})
  end,
}
