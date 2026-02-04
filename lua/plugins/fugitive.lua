return {
    'tpope/vim-fugitive',
    init = function ()
        vim.cmd [[
            nmap <leader>gh :diffget //2<CR>]czz
            nmap <leader>gl :diffget //3<CR>]czz
            nmap <leader>gm :Gvdiffsplit!<CR>
        ]]
    end,
}
