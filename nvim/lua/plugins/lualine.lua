return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons', name = "lualine-web-devicons" },
  config = function()
      require('lualine').setup()
  end
}
