let g:slime_target = "tmux"
let g:slime_paste_file = "/tmp/slime_paste"
let g:slime_default_config = {
            \ 'socket_name': get(split($TMUX, ','), 0),
            \ 'target_pane': '{top-right}' }
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1
let g:slime_no_mappings = 1
