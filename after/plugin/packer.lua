-- ensure that packer is installed
local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'

packer.init({
    package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- startup and add configure plugins
packer.startup(function()
    local use = use
    -- add you plugins here like:
    use 'wbthomason/packer.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {
        'tpope/vim-vinegar',
        keys = '-',
    }
    use {
        'sainnhe/sonokai'
    }
    --vim.api.nvim_create_user_command('Lsp', '', { nargs = 0 })
    use {
        'neovim/nvim-lspconfig',
        keys = [[<leader>l]],
        config = function () require('lazy/nvim-lspconfig') end
    }
    use {
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        module = 'nvim-lsp-ts-utils'
    }
    use { 
        'jose-elias-alvarez/typescript.nvim',
        module = 'typescript'
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    -- You don't need to install this if you already have fzf installed
    use {
        'junegunn/fzf',
        run = './install --all',
    }
    use { 'ibhagwan/fzf-lua',
        -- optional for icon support
        requires = { 'kyazdani42/nvim-web-devicons' },
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            { 'hrsh7th/cmp-vsnip' },
            { 'hrsh7th/vim-vsnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
        }
    }
    use 'chrisbra/unicode.vim'
    use {
        'simrat39/rust-tools.nvim',
        module = 'rust-tools'
    }
    use { 
        'akinsho/toggleterm.nvim',
        keys = [[<c-\>]],
        config = function () require('lazy/toggleterm') end
    }
    use({
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
        ft = { 'markdown' }
    })
    use 'tpope/vim-sleuth'
    use 'vim-scripts/AutoClose'
end
)

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])
