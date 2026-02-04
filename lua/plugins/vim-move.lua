return {
    'matze/vim-move',
    name = 'vim-move',
    init = function ()
        vim.cmd [[
            vmap ∆ <Plug>MoveBlockDown
            vmap ˚ <Plug>MoveBlockUp
            nmap ∆ <Plug>MoveLineDown
            nmap ˚ <Plug>MoveLineUp
        ]]
    end,
}
