-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
    signs = {
        add = {text = '+'},
        change = {text = '~'},
        delete = {text = '-'},
        topdelete = {text = '^'},
        changedelete = {text = '<'},
        untracked = {text = ''}
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {interval = 1000, follow_files = true},
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false
    },
    current_line_blame_formatter = ' <author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return '<Ignore>'
        end, {expr = true})

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return '<Ignore>'
        end, {expr = true})

        -- Actions
        map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>')
        map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>gj', function()
            gs.next_hunk()
            vim.cmd('norm! zz')
        end)
        map('n', '<leader>gk', function()
            gs.prev_hunk()
            vim.cmd('norm! zz')
        end)
        map('n', '<leader>gS', gs.stage_buffer)
        map('n', '<leader>gu', gs.undo_stage_hunk)
        map('n', '<leader>gR', gs.reset_buffer)
        map('n', '<leader>gp', gs.preview_hunk)
        map('n', '<leader>gb', function()
            gs.blame_line {full = true}
        end)
        map('n', '<leader>gd', gs.diffthis)
        map('n', '<leader>gD', function()
            gs.diffthis('~')
        end)

        map('n', '<leader>gtn', gs.toggle_numhl)
        map('n', '<leader>gtl', gs.toggle_linehl)
        map('n', '<leader>gtb', gs.toggle_current_line_blame)
        map('n', '<leader>gts', gs.toggle_signs)
        map('n', '<leader>gtd', gs.toggle_deleted)
        map('n', '<leader>gtw', gs.toggle_word_diff)
        -- toggle both linehl and deleted
        map('n', '<leader>gtt', function()
            gs.toggle_linehl()
            gs.toggle_deleted()
        end)

        -- Text object (in hunk)
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}
