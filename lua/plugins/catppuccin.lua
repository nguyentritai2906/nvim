return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    enabled = true,
    opts = {
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        transparent_background = true,
        term_colors = false,
        dim_inactive = {
            enabled = true,
            shade = "dark",
            percentage = 1
        },
        styles = {
            comments = {"italic"},
            conditionals = {"italic"},
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {}
        },
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            treesitter = true
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
        color_overrides = {},
    },
    config = function(_, opts)
        require('catppuccin').setup(opts)

        -- Highlight
        vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
        vim.cmd('highlight link Searchlight IncSearch')

        -- Add DONE to TODO highlighting group
        -- https://stackoverflow.com/questions/4162664/vim-highlight-a-list-of-words
        vim.cmd('match Todo /DONE\\|NOTE\\|TODO\\|IMPORTANCE/')

        -- If machine is macOS, use the following
        if vim.fn.has('mac') == 1 then
            local dn = require('dark_notify')
            dn.run({
                schemes = { dark = 'catppuccin', light = 'catppuccin' },
                before = function(mode)
                    if mode == 'dark' then
                        vim.g.catppuccin_flavour = 'macchiato' -- latte, frappe, macchiato, mocha
                    else
                        vim.g.catppuccin_flavour = 'latte'
                    end
                end,
                after = function(_)
                    vim.cmd([[colorscheme catppuccin]])
                end,
            })
            dn.update()
        else
            vim.g.catppuccin_flavour = 'macchiato'
            vim.cmd([[colorscheme catppuccin]])
            vim.cmd([[hi Normal guibg=#22273E ctermbg=NONE]])
        end
    end,
    dependencies = { "nguyentritai2906/dark-notify" },
}
