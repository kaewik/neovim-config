require("nvim-treesitter.install").prefer_git = true
local configs = require'nvim-treesitter.configs'

local disable_predicate = function (lang, bufnr)
    local is_disabled = {
        ["yaml"] = true,
        ["json"] = true,
    }
    return is_disabled[lang] and vim.api.nvim_buf_line_count(bufnr) > 2000
end

configs.setup {
    ensure_installed = { 
        "c", 
        "cmake",
        "cpp";
        "css",
        "haskell",
        "html",
        "java",
        "javascript",
        "lua", 
        "make",
        "nix",
        "python",
        "rust",
        "typescript",
        "vim", 
        "help" },
    highlight = {
        enable = true,
        disable = disable_predicate,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = disable_predicate,
    },
}
