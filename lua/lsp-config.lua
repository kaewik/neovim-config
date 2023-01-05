local lspconfig = require'lspconfig'
local util = require("lspconfig.util")
local mappings = require("mappings")
local ts_utils = require('typescript')

local function default_on_attach(client, bufnr)
    print('Attaching to ' .. client.name)
    mappings.define_lsp_commands()
    mappings.set_local_lsp_mappings(bufnr)
end

local function make_init_options()
    local init_options = require("nvim-lsp-ts-utils").init_options
    init_options.preferences.importModuleSpecifierPreference = "project-relative"

    return init_options
end

local default_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local default_config = {
    on_attach = default_on_attach,
    capabilities = default_capabilities,
}

-- setup language servers here
ts_utils.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
        on_attach = default_on_attach,
        capabilities = default_capabilities,
        root_dir = util.root_pattern("tsconfig.json", "jsconfig.json"),
    },
})
lspconfig.eslint.setup(default_config)
lspconfig.clangd.setup({
    on_attach = default_on_attach,
    capabilities = default_capabilities,
    cmd = { "clangd", "--background-index" },
})
lspconfig.hls.setup({
    on_attach = default_on_attach,
    capabilities = default_capabilities,
    root_dir = function (filepath)
       return (util.root_pattern('hie.yaml', 'stack.yaml', 'cabal.project')(filepath))
    end
})
lspconfig.omnisharp.setup({
    on_attach = default_on_attach,
    capabilities = default_capabilities,
    cmd = { "OmniSharp", "-lsp" },
    root_dir = util.root_pattern("*.csproj", "*.sln", "*.proj"),
})

require('rust-tools').setup({
    server = default_config
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, 
    {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
    }
)
