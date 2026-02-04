return {
    'hrsh7th/nvim-cmp',
    lazy = false,
    dependencies = {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'onsails/lspkind-nvim',
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        local luasnip = require('luasnip')

        require('luasnip.loaders.from_snipmate').lazy_load()

        local function has_words_before()
            local unpack_fn = table.unpack or unpack
            local line, col = unpack_fn(vim.api.nvim_win_get_cursor(0))
            if col == 0 then
                return false
            end
            local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
            return current_line:sub(col, col):match('%s') == nil
        end

        cmp.setup({
            preselect = cmp.PreselectMode.None,
            completion = { completeopt = 'menu,menuone,noinsert,noselect,preview' },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = {
                { name = 'luasnip', keyword_length = 1 },
                { name = 'nvim_lsp', keyword_length = 1 },
                { name = 'path', keyword_length = 1, max_item_count = 3 },
                { name = 'buffer', keyword_length = 1, max_item_count = 3 },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.jump(1)
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-d>'] = cmp.mapping.scroll_docs(5),
                ['<C-u>'] = cmp.mapping.scroll_docs(-5),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol',
                    maxwidth = 50,
                    ellipsis_char = '...',
                    show_labelDetails = true,
                }),
            },
        })
    end,
}

