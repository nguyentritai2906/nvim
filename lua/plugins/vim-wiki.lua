return {
    'vimwiki/vimwiki',
    init = function()
        vim.g.vimwiki_list = {
            {path = vim.fn.expand('~/Documents/notes/'), syntax = 'markdown', ext = '.md', links_space_char = '-'}
        }
        vim.g.vimwiki_auto_header = 1
        -- vim.g.vimwiki_folding = 'custom'
        vim.g.vimwiki_table_mappings = 0
        vim.g.vimwiki_filetypes = {'markdown'}
        vim.g.vimwiki_global_ext = 0
    end,
}
