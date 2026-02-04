return {
    'nvim-tree/nvim-tree.lua',
    opts = {
        sort_by = "case_sensitive",
        view = {
            adaptive_size = true,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        }
    },
    lazy = false,
    cmd = {
        "NvimTreeToggle"
    },
    -- keys = {
    --     { "<c-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Nvim Tree" },
    -- },
    init = function ()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- set termguicolors to enable highlight groups
        vim.opt.termguicolors = true
    end,
    dependencies = {'nvim-tree/nvim-web-devicons'},
}

