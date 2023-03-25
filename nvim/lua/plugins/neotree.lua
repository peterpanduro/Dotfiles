return {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {"nvim-tree/nvim-web-devicons", name = "neotree-web-devicons"}, -- Optional
    },
    keys = {
        { "<leader>nt", "<cmd>Neotree toggle<cr>", desc = "Neotree" },
    },
    config = function ()
        require("neo-tree").setup({
            close_if_last_window = true, -- close neo-tree if it is the last window left in the tab
        })
    end
  }
