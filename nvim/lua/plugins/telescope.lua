return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Find file" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Find buffer" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Find grep" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Find help" },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    }
    require('telescope').load_extension('fzf')
  end
}
