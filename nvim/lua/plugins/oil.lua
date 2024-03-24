return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "Oil" },
  keys = {
    { '<leader>fo', '<CMD>Oil<CR>', { desc = "Open Oil" } },
  },
  opts = {},
}
