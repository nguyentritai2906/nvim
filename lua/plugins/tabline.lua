return {
    'kdheepak/tabline.nvim',
    lazy = false,
    opts = {
        enable = false,
    },
    config = function(_, opts)
        local tabline = require('tabline')
        tabline.setup(opts)

        function tabline.tab_nnew(...)
            local args = {...}
            local unpack_fn = unpack or table.unpack

            if #args > 1 then
                tabline.tab_rename(args[1])
                for _, name in pairs({unpack_fn(args, 2)}) do
                    tabline.tab_new()
                    tabline.tab_rename(name)
                end
                vim.cmd([[redrawtabline]])
            else
                tabline.tab_new()
                tabline.tab_rename(args[1])
            end
        end

        vim.cmd([[command! -nargs=* TablineTabNNew :lua require('tabline').tab_nnew(<f-args>)]])
    end,
}

