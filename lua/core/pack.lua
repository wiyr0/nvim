local fn, uv, api = vim.fn, vim.loop, vim.api
local vim_path = require('core.global').vim_path
-- ~/.local/share/nvim/site/
local data_dir = require('core.global').data_dir
local modules_dir = vim_path .. '/lua/modules'

local lazypath = data_dir .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("packer plugin is not installed, start installing to " .. data_dir)
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

plugins = {} -- plugin name set

local get_plugins_list = function()
    local list = {}
    -- nvim/lua/modules/xxx/plugins.lua
    local tmp = vim.split(fn.globpath(modules_dir, '*/plugins.lua'), '\n')
    for _, f in ipairs(tmp) do
        -- e.g.   modules/completion/plugins.lua
        list[#list + 1] = f:sub(#modules_dir - 6, -1)
    end
    return list
end

local function pretty_print(tbl, indent)
    indent = indent or 0
    local spacing = string.rep("  ", indent)  -- 缩进空格

    for k, v in pairs(tbl) do
        if type(v) == "table" then
            print(spacing .. tostring(k) .. " = {")
            pretty_print(v, indent + 1)
            print(spacing .. "}")
        else
            print(spacing .. tostring(k) .. " = " .. tostring(v))
        end
    end
end

local plugins_file = get_plugins_list()
-- require plugins
for _, m in ipairs(plugins_file) do
    -- modules/completion/plugins
    local repos = require(m:sub(0, #m - 4))
    -- dict[]
    for repo_name, conf in pairs(repos) do
        -- SirVer/ultisnips  config of plugin
        plugins[#plugins + 1] = vim.tbl_extend('force', {repo_name}, conf)
    end
end

local opts = {}
require("lazy").setup(plugins, opts)
