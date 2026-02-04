return {
    'simnalamburt/vim-mundo',
    name = 'vim-mundo',
    init = function ()
        vim.cmd [[
            let g:mundo_auto_preview_delay=0
            let g:mundo_inline_undo=1
            nnoremap <F5> :MundoToggle<CR>
        ]]
    end,
}
