return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        -- LuaSnip
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets', -- Adds a number of user-friendly snippets
    },
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup {}

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = {
                -- autocomplete = false,
                completeopt = 'menu,menuone,noinsert',
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-y>'] = cmp.mapping.confirm { select = true },
                ['<C-Space>'] = cmp.mapping.complete {},
                -- ['<C-l>'] = cmp.mapping(function()
                --     if luasnip.expand_or_locally_jumpable() then
                --         luasnip.expand_or_jump()
                --     end
                -- end, { 'i', 's' }),
                -- ['<C-h>'] = cmp.mapping(function()
                --     if luasnip.locally_jumpable(-1) then
                --         luasnip.jump(-1)
                --     end
                -- end, { 'i', 's' }),

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            },
            sources = cmp.config.sources {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'luasnip' },
                { name = 'path' },
                { name = 'friendly-snippets' }
            }
        }
    end
}
