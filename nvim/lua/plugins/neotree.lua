return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        { "nvim-tree/nvim-web-devicons" }, -- Optional
        "3rd/image.nvim",
    },
    cmd = "Neotree",
    keys = {
        { "<leader>ft", "<cmd>Neotree toggle<cr>",           desc = "[F]ile [T]ree" },
        { "<leader>fn", "<cmd>Neotree position=current<cr>", desc = "[F]iletree [N]avigate" },
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = false, -- close neo-tree if it is the last window left in the tab
            enable_git_status = true,
            enable_diagnostics = true,
            use_libuv_file_watcher = true,
            default_component_configs = {
                git_status = {
                    symbols = {
                        -- Change type
                        added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                        deleted   = "✖", -- this can only be used in the git_status source
                        renamed   = "󰁕", -- this can only be used in the git_status source
                        -- Status type
                        untracked = "",
                        ignored   = "",
                        unstaged  = "󰄱",
                        staged    = "",
                        conflict  = "",
                    }
                },
            }
        })
    end
}
