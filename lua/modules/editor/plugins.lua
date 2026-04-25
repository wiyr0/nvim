local editor = {}
local conf = require('modules.editor.config')

editor['junegunn/vim-easy-align'] = {lazy = true, cmd = 'EasyAlign'}
editor['itchyny/vim-cursorword'] = {
    lazy = true,
    event = {'BufReadPre', 'BufNewFile', 'BufNewFile'},
    config = conf.vim_cursorwod
}

editor['tpope/vim-commentary'] = {
    lazy = false,
    config = conf.vim_commentary,
}

-- 根据不同语言解析代码, 提供接口, 比如可以用于显示准确的高亮
editor['nvim-treesitter/nvim-treesitter'] = {
    lazy = true,
    build = function()
		if #vim.api.nvim_list_uis() > 0 then
			vim.api.nvim_command([[TSUpdate]])
		end
	end,
    event = 'BufReadPre',
    dependencies = { 'telescope.nvim' },
    config = conf.nvim_treesitter
}
-- 基于treesitter 的vim textobjects
editor['nvim-treesitter/nvim-treesitter-textobjects'] = {
    lazy = true,
    dependencies = { 'nvim-treesitter' }
}
-- 看超长代码很有用
editor['romgrk/nvim-treesitter-context'] = {
    lazy = true,
    dependencies = { 'nvim-treesitter' },
    event = 'BufReadPre',
    config = conf.treesitter_context
}
-- 基于treesitter的高亮, 括号高亮难看
editor['p00f/nvim-ts-rainbow'] = {
    lazy = true,
    dependencies = { 'nvim-treesitter' },
    event = 'BufRead'
}
-- 高亮查询以及取消
editor['romainl/vim-cool'] = {
    lazy = true,
    event = {'CursorMoved', 'InsertEnter'}
}

-- Git 命令
editor["tpope/vim-fugitive"] = { lazy = true, cmd = {"Git", "G"} }

editor["nvim-tree/nvim-tree.lua"] = {
    lazy = true,
    enabled = false,
    cmd = {
		"NvimTreeToggle",
		"NvimTreeOpen",
		"NvimTreeFindFile",
		"NvimTreeFindFileToggle",
		"NvimTreeRefresh",
	},
    config = conf.nvim_tree,
}

editor['justinmk/vim-dirvish'] = {
    lazy = false,
}

editor['vim-scripts/a.vim'] = {
    lazy = false
}

editor['mg979/vim-visual-multi'] = {
    lazy = false
}

editor['stevearc/conform.nvim'] = {
    event = { "BufReadPre", "BufNewFile" },
    config = conf.conform,
    lazy = false
}
return editor
