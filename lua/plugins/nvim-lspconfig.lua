local function list_lsp_servers()
    local servers = {}
    local lsp_dir = vim.fn.stdpath('config') .. '/lsp'

    if vim.fn.isdirectory(lsp_dir) ~= 1 then
        return servers
    end

    for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
        if file:match('%.lua$') and file ~= 'init.lua' and file ~= 'packer_compiled.lua' then
            servers[#servers + 1] = file:gsub('%.lua$', '')
        end
    end

    table.sort(servers)
    return servers
end

return {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'ray-x/lsp_signature.nvim',
        'Hoffs/omnisharp-extended-lsp.nvim',
    },
    config = function()
        vim.diagnostic.config({ virtual_text = true })

        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        vim.lsp.config('*', { capabilities = capabilities })

        local group = vim.api.nvim_create_augroup('my.lsp', { clear = true })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = group,
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if not client then
                    return
                end

                local bufnr = ev.buf

                vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

                local function map(mode, lhs, rhs)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true })
                end

                map('n', 'K', vim.lsp.buf.hover)
                map('n', 'gD', vim.lsp.buf.declaration)
                map('n', 'gd', vim.lsp.buf.definition)
                map('n', 'gr', vim.lsp.buf.references)

                if client:supports_method('textDocument/implementation') then
                    map('n', 'gi', vim.lsp.buf.implementation)
                end

                map('n', '<space>lf', function()
                    local efm_clients = vim.lsp.get_clients({ bufnr = bufnr, name = 'efm' })
                    if #efm_clients > 0 then
                        vim.lsp.buf.format({
                            bufnr = bufnr,
                            timeout_ms = 1000,
                            filter = function(c)
                                return c.name == 'efm'
                            end,
                        })
                        return
                    end

                    local formatting_clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/formatting' })
                    if #formatting_clients == 0 then
                        vim.notify('No LSP client attached supports formatting', vim.log.levels.WARN)
                        return
                    end

                    vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 1000 })
                end)
                map('n', '<space>lk', vim.lsp.buf.signature_help)
                map('n', '<space>lwa', vim.lsp.buf.add_workspace_folder)
                map('n', '<space>lwr', vim.lsp.buf.remove_workspace_folder)
                map('n', '<space>lwl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end)
                map('n', '<space>ld', vim.lsp.buf.type_definition)
                map('n', '<space>lr', vim.lsp.buf.rename)
                map('n', '<space>lgk', function()
                    vim.diagnostic.jump({ count = -1, float = true })
                end)
                map('n', '<space>lgj', function()
                    vim.diagnostic.jump({ count = 1, float = true })
                end)
                map('n', '<space>lq', vim.diagnostic.setloclist)
                map('n', '<space>lE', function()
                    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
                end)
                map('n', '<space>le', function()
                    vim.diagnostic.open_float({ scope = 'line' })
                end)

                if client.server_capabilities.documentHighlightProvider then
                    local highlight_group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        group = highlight_group,
                        buffer = bufnr,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd('CursorMoved', {
                        group = highlight_group,
                        buffer = bufnr,
                        callback = vim.lsp.buf.clear_references,
                    })
                end

                -- Only EFM should format
                if client.name ~= 'efm' then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end

                if client.name == 'efm' and client:supports_method('textDocument/formatting') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = group,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                bufnr = bufnr,
                                timeout_ms = 1000,
                                filter = function(c)
                                    return c.id == client.id
                                end,
                            })
                        end,
                    })
                end

                if client.name == 'omnisharp' then
                    map('n', 'gd', function()
                        require('omnisharp_extended').lsp_definition()
                    end)
                    map('n', 'gD', function()
                        require('omnisharp_extended').lsp_type_definition()
                    end)
                    map('n', 'gr', function()
                        require('omnisharp_extended').lsp_references()
                    end)
                    map('n', 'gi', function()
                        require('omnisharp_extended').lsp_implementation()
                    end)
                end

                if client.name == 'pyright' then
                    client.server_capabilities.signatureHelpProvider = nil
                end

                if client.name == 'ruff_lsp' then
                    client.server_capabilities.hoverProvider = false
                end

                if client.name == 'pylsp' then
                    client.server_capabilities.renameProvider = false
                    client.server_capabilities.hoverProvider = false
                end

                local ok, lsp_signature = pcall(require, 'lsp_signature')
                if ok then
                    lsp_signature.on_attach()
                end
            end,
        })

        vim.lsp.enable(list_lsp_servers())
    end,
}
