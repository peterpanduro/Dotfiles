return {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "j-hui/fidget.nvim" },
    keys = {
        { "<leader>hr", "<cmd>Rest run<cr>",      desc = "[H]ttp [R]un request under cursor" },
        {
            "<leader>hl",
            function()
                -- Workaround: rest.nvim's `Rest last` calls run_request synchronously
                -- but curl's `.wait()` needs to be inside an nio task, so it fails.
                -- Wrap the run_last call in nio.run ourselves.
                local request = require("rest-nvim.request")
                if not request.last_request() then
                    vim.notify("No last request found", vim.log.levels.WARN, { title = "rest.nvim" })
                    return
                end
                require("rest-nvim.ui.result").clear()
                vim.cmd("Rest open")
                require("nio").run(function() request.run_last() end)
            end,
            desc = "[H]ttp run [L]ast",
        },
        { "<leader>hL", "<cmd>Rest logs<cr>",     desc = "[H]ttp [L]ogs" },
    },
    config = function()
        require("rest-nvim").setup({
            client = "curl",
            env = { enable = true, pattern = ".*%.env.*" },
            request = { skip_ssl_verification = false, hooks = { encode_url = true } },
            response = { hooks = { decode_url = true, format = true } },
            result = {
                split = { horizontal = false, in_place = false },
                behavior = {
                    decode_url = true,
                    show_info = {
                        url = true,
                        headers = true,
                        http_info = true,
                        curl_command = false,
                    },
                    formatters = {
                        json = "jq",
                    },
                },
                keybinds = {
                    buffer_local = true,
                    prev = "H",
                    next = "L",
                },
            },
            highlight = { enable = true, timeout = 750 },
        })
    end,
}
