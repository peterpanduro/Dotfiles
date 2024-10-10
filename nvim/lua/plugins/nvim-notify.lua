local banned_messages = {
    "-- INSERT --"
}

local function on_open()
    if vim.g.last_notification_id then
        require("notify").dismiss(vim.g.last_notification_id)
    end
end

return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
        require("notify").setup({
            fps = 60,
            minimum_width = 90,
            max_width = 90,
            max_height = 4,
            background_colour = '#000000',
            timeout = 3500,
            top_down = true,
            level = vim.log.levels.INFO,
            render = "default",
            on_open = on_open,
            -- stages = "fade_in_slide_out",
        })

        vim.notify = function(msg, ...)
            for _, banned_msg in ipairs(banned_messages) do
                if string.find(msg, banned_msg) then
                    return
                end
            end
            require("notify")(msg, ...)
        end
    end
}
