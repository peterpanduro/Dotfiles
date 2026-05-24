return {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "j-hui/fidget.nvim" },
    keys = {
        { "<leader>hr", "<cmd>Rest run<cr>",      desc = "[H]ttp [R]un request under cursor" },
        {
            "<leader>hl",
            function()
                -- Workaround: rest.nvim's `:Rest last` calls run_request
                -- synchronously, but curl's nio future `.wait()` must run inside
                -- an nio task. Without the wrapper, every `:Rest last` errors.
                local request = require("rest-nvim.request")
                local ui = require("rest-nvim.ui.result")
                if not request.last_request() then
                    vim.notify("No last request found", vim.log.levels.WARN, { title = "rest.nvim" })
                    return
                end
                if not ui.is_open() then
                    vim.cmd("Rest open")
                end
                ui.clear()
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
