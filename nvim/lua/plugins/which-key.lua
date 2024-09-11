return {
  "folke/which-key.nvim",
  lazy = false,
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup({
      { "", group = "[D]ebug" },
      { "", group = "[R]eame" },
      { "", group = "[F]ind" },
      { "", group = "[W]orkspace" },
      { "", group = "[C]ode" },
      { "", group = "[G]it" },
      { "", desc = "",            hidden = true, mode = { "n", "n", "n", "n", "n", "n" } },
    })

    -- require('which-key').register
  end
}
