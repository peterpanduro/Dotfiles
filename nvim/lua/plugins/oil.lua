return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "Oil" },
  keys = {
    { '<leader>-', '<CMD>Oil<CR>', { desc = "Open Oil" } },
  },
  opts = {
    view_options = {
      show_hidden = true,
    }
  },
}
