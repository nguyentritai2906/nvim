local parsers = {
    "angular",
    "bash",
    "c",
    "cpp",
    "css",
    "csv",
    "diff",
    "dockerfile",
    "embedded_template",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "graphql",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "nginx",
    "powershell",
    "python",
    "query",
    "regex",
    "rust",
    "scss",
    "sql",
    "styled",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "yaml",
}

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    config = function(_, opts)
        require("nvim-treesitter").install(parsers)
        require("nvim-treesitter").setup(opts)
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                selection_modes = {
                    ["@function.outer"] = "V", -- linewise
                    ["@class.outer"] = "V", -- linewise
                },
            },
        })

        -- Create a function to map keys to text objects.
        local function map(lhs, obj)
            vim.keymap.set({ "x", "o" }, lhs, function()
                require("nvim-treesitter-textobjects.select").select_textobject(obj, "textobjects")
            end)
        end
        -- Map keys to text objects.
        map("af", "@function.outer")
        map("if", "@function.inner")
        map("ac", "@class.outer")
        map("ic", "@class.inner")
        map("ak", "@block.outer")
        map("ik", "@block.inner")

        -- Start treesitter for all buffers.
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { -- Syntax aware text objects.
            -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
        },
    },
}
