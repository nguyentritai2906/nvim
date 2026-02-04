local function getWords()
  return tostring(vim.fn.wordcount().words)
end


return {
    'nvim-lualine/lualine.nvim',
    main = 'lualine',
    lazy = false,
    opts = function()
        local ok, tabline = pcall(require, 'tabline')
        local tabline_buffers = ok and tabline.tabline_buffers or ''
        local tabline_tabs = ok and tabline.tabline_tabs or ''

        return {
            options = {
                icons_enabled = true,
                theme = 'catppuccin',
                component_separators = {left = '', right = ''},
                section_separators = {left = '', right = ''},
                disabled_filetypes = {}
            },
            -- +-------------------------------------------------+
            -- | A | B | C                             X | Y | Z |
            -- +-------------------------------------------------+
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {getWords, 'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { tabline_buffers },
                lualine_x = { tabline_tabs },
                lualine_y = {},
                lualine_z = {},
            },
        }
    end,
    dependencies = {
        { 'kdheepak/tabline.nvim' },
        { 'nvim-tree/nvim-web-devicons' },
    }
}
