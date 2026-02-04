-- Waiting for Missing Legacy config is resolved
-- https://github.com/neovim/nvim-lspconfig/issues/3705

local flake8 = {
    LintCommand = "flake8 --config ~/.config/flake8/flake8 --max-line-length 120 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    formatStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
}
local isort = { formatCommand = "isort --quiet -", formatStdin = true }
local yapf = { formatCommand = "yapf --quiet", formatStdin = true } -- really slow
local autopep8 = { formatCommand = "autopep8 -", formatStdin = true }
local autoflake = {
    formatCommand = "autoflake --remove-unused-variables --remove-all-unused-imports --stdin-display-name ${INPUT} -",
    formatStdin = true,
}
local black = { formatCommand = "black --quiet -", formatStdin = true }
local luaFormat
if vim.fn.executable("stylua") == 1 then
    luaFormat = {
        formatCommand = "stylua --search-parent-directories --indent-type Spaces --stdin-filepath ${INPUT} -",
        formatStdin = true,
    }
else
    luaFormat = {
        formatCommand = "lua-format --no-keep-simple-function-one-line --column-limit=120",
        formatStdin = true,
    }
end
local prettier = { formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true }
local prettier_yaml = { formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true }
local eslint = {
    lintCommand = "eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
    formatCommand = "./node_modules..bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true,
}
local shellcheck = {
    LintCommand = "shellcheck -f gcc -x",
    lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
}
local shfmt = { formatCommand = "shfmt -ci -s -bn", formatStdin = true }
local rustfmt = { formatCommand = "rustfmt", formatStdin = true }
local ruff = { formatCommand = "ruff format --stdin-filename ${INPUT}", formatStdin = true }
local clang_format = { formatCommand = "clang-format", formatStdin = true }
local jq = { formatCommand = "jq .", formatStdin = true }

return {
    root_markers = {
        ".git",
        "init.lua",
        ".luarc.json",
        ".luarc.jsonc",
        ".stylua.toml",
        "stylua.toml",
        ".zshrc",
    },
    init_options = {
        documentFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true,
    },
    filetypes = { "lua", "python", "javascriptreact", "javascript", "sh", "html", "css", "json", "yaml", "rust", "go" },
    settings = {
        rootMarkers = {
            ".git",
            "init.lua",
            ".luarc.json",
            ".luarc.jsonc",
            ".stylua.toml",
            "stylua.toml",
            ".zshrc",
        },
        languages = {
            lua = { luaFormat },
            -- python = {autoflake, isort, flake8, black, ruff},
            python = { autoflake, isort, ruff },
            javascriptreact = { prettier, eslint },
            javascript = { prettier, eslint },
            sh = { shfmt, shellcheck },
            html = { prettier },
            css = { prettier },
            json = { prettier, jq },
            yaml = { prettier_yaml },
            rust = { rustfmt },
            go = {},
        },
    },
}
-- vim.lsp.enable("efm")
