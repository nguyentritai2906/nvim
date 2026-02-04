return {
    'hanschen/vim-ipython-cell',
    config = function()
        vim.g.ipython_cell_tag = {'# %%', '#%%', '# <codecell>', '##', '# +'}
        vim.g.slime_target = "tmux"
        vim.g.slime_paste_file = "/tmp/slime_paste"
        vim.g.slime_default_config = {
            socket_name = vim.split(vim.env.TMUX, ',')[1],
            target_pane = '{top-right}'
        }
        vim.g.slime_dont_ask_default = 1
        vim.g.slime_python_ipython = 1
        vim.g.slime_no_mappings = 1
    end,
    keys = {
        { '<Leader>is', ":SlimeSend1 ipython --matplotlib<CR>", desc = 'Start IPython' },
        { '<Leader>ir', ":IPythonCellRun<CR>", desc = 'Run Script' },
        { '<Leader>it', ":IPythonCellRunTime<CR>", desc = 'Run Script and Time the Execution' },
        { '<Leader>ic', ":IPythonCellExecuteCell<CR>", desc = 'Execute Current Cell' },
        { '<Leader>iC', ":IPythonCellExecuteCellJump<CR>", desc = 'Execute Current Cell and Jump to Next Cell' },
        { '<Leader>il', ":IPythonCellClear<CR>", desc = 'Clear IPython Screen' },
        { '<Leader>ix', ":IPythonCellClose<CR>", desc = 'Close All Matplotlib Figure Windows' },
        { '<Leader>ij', ":IPythonCellNextCell<CR>", desc = 'Jump to Next Cell' },
        { '<Leader>ik', ":IPythonCellPrevCell<CR>", desc = 'Jump to Previous Cell' },
        { '<Leader>iR', ":IPythonCellRestart<CR>", desc = 'Restart IPython' },
        { '<Leader>ih', "<Plug>SlimeLineSend", mode = 'n', desc = 'Send Current Line to IPython' },
        { '<Leader>ih', "<Plug>SlimeRegionSend", mode = 'x', desc = 'Send Selection to IPython' },
    },
    dependencies = {
        {
            'jpalardy/vim-slime',
        }
    },
}
