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
    'mason-org/mason-lspconfig.nvim',
    lazy = false,
    dependencies = { 'mason-org/mason.nvim' },
    opts = function()
        return { ensure_installed = list_lsp_servers() }
    end,
}

