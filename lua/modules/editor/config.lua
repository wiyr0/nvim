local config = {}
local sessions_dir = vim.fn.stdpath("data") .. "/sessions/"

function config.vim_cursorwod()
    vim.api.nvim_command('augroup user_plugin_cursorword')
    vim.api.nvim_command('autocmd!')
    vim.api.nvim_command(
        'autocmd FileType NvimTree,lspsagafinder,dashboard let b:cursorword = 0')
    vim.api.nvim_command(
        'autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif')
    vim.api.nvim_command('autocmd InsertEnter * let b:cursorword = 0')
    vim.api.nvim_command('autocmd InsertLeave * let b:cursorword = 1')
    vim.api.nvim_command('augroup END')
end

function config.nvim_treesitter()
    require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "lua", "python", "bash", "cpp" , "go",
                            "json"},
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- List of parsers to ignore installing (for "all")
        -- ignore_install = { "javascript" },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    }
end

function config.vim_commentary()
    vim.api.nvim_command('autocmd FileType conf commentstring=# %s')
end

function config.treesitter_context()
    require'treesitter-context'.setup()
end

function config.nvim_tree()
    -- disable netrw at the very start of your init.lua
    -- vim.g.loaded_netrw = 1
    -- vim.g.loaded_netrwPlugin = 1

    -- -- optionally enable 24-bit colour
    -- vim.opt.termguicolors = true
    require'nvim-tree'.setup()
end

return config
