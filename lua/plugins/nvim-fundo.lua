return {
    'kevinhwang91/nvim-fundo',
    dependencies = {
        'kevinhwang91/promise-async',
    },
    lazy = false,
    build = function ()
        require('fundo').install()
    end,
    init = function ()
        vim.opt.undofile = true
    end,
    opts = {},
}

