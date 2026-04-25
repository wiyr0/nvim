local config = {}

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
    require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "lua", "python", "bash", "cpp", "go",
            "json" },
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
    require 'treesitter-context'.setup()
end

function config.nvim_tree()
    -- disable netrw at the very start of your init.lua
    -- vim.g.loaded_netrw = 1
    -- vim.g.loaded_netrwPlugin = 1

    -- -- optionally enable 24-bit colour
    -- vim.opt.termguicolors = true
    require 'nvim-tree'.setup()
end

local function get_project_root()
    local buf_file = vim.api.nvim_buf_get_name(0)
    if buf_file == "" or buf_file == nil then return nil end

    local current_dir = vim.fn.fnamemodify(buf_file, ":h")
    local dir = current_dir

    while dir ~= "/" and dir ~= "" do
        -- 检查是否有 .git 目录
        if vim.fn.isdirectory(dir .. "/.git") == 1 then
            return dir
        end

        -- 检查是否有 .clang-format 文件
        if vim.fn.filereadable(dir .. "/.clang-format") == 1 then
            return dir
        end

        dir = vim.fn.fnamemodify(dir, ":h")
    end

    return current_dir
end

local indent_cache = {}

local function get_clang_format_indent()
    local project_root = get_project_root()
    if not project_root then return nil end

    -- 检查缓存
    if indent_cache[project_root] ~= nil then
        return indent_cache[project_root]
    end

    local buf_file = vim.api.nvim_buf_get_name(0)
    if buf_file == "" then return nil end

    -- 使用clang-format命令获取配置
    local cmd = "clang-format --style=file --dump-config " .. vim.fn.shellescape(buf_file)
    local handle = io.popen(cmd)
    if not handle then
        indent_cache[project_root] = nil
        return nil
    end

    local output = handle:read("*a")
    handle:close()
    for line in output:gmatch("[^\r\n]+") do
        line = vim.trim(line)
        local indent = line:match("^IndentWidth%s*:%s*(%d+)")
        if indent then
            indent_width = tonumber(indent)
            break
        end
    end
    if indent_width then
        indent_cache[project_root] = indent_width
        return tonumber(indent_width)
    end
    
    return nil
end

function config.conform()
    local conform = require("conform")

    conform.setup({
        -- 你的现有配置...
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            -- ...
        },
        formatters = {
            clang_format = {
                prepend_args = { "--style=file" },
            },
        },
        -- format_on_save = {
        --     timeout_ms = 500,
        --     lsp_fallback = true,
        -- },
    })

    vim.api.nvim_create_autocmd({"BufEnter", "BufReadPost"}, {
        pattern = {"*.c", "*.cpp", "*.h", "*.hpp"},
        callback = function()
            local indent_width = get_clang_format_indent()
            if indent_width then
                vim.bo.shiftwidth = indent_width
                vim.bo.tabstop = indent_width
                vim.bo.softtabstop = indent_width
                vim.bo.expandtab = true
                -- -- 可选：显示提示
                -- vim.notify(string.format("缩进设置为: %d 空格", indent_width),
                -- vim.log.levels.INFO, { timeout = 1000 })
            end
        end
    })

    -- 在这里添加快捷键
    vim.keymap.set({ "n", "v" }, "fm", function()
        conform.format({ async = true, lsp_fallback = true })
    end, { desc = "Format code" })
end

return config
