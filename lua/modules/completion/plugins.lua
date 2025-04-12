local completion = {}
local conf = require('modules.completion.config')

-- A collection of common configurations for Neovim's built-in language server client.
completion['neovim/nvim-lspconfig'] = {
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    config = conf.nvim_lsp,
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "SmiteshP/nvim-navic" }
    }
}

-- 炫酷的代码重构，悬浮窗显示
completion['nvimdev/lspsaga.nvim'] = {
	lazy = true,
	event = "LspAttach",
	dependencies = 'nvim-lspconfig',
	config = conf.saga
}
completion['hrsh7th/nvim-cmp'] = {
	event = {'InsertEnter', 'CmdlineEnter'},
	config = conf.cmp,
	dependencies = {
		{ 'neovim/nvim-lspconfig'},
		{ "saadparwaiz1/cmp_luasnip", dependencies = "L3MON4D3/LuaSnip" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-buffer"},
		{ "hrsh7th/cmp-path"}, -- 路径补全
		{ "hrsh7th/cmp-cmdline"},
		{ "hrsh7th/cmp-nvim-lsp"},
		{ "hrsh7th/cmp-nvim-lua"},
		{ "f3fora/cmp-spell" },
		{ "kdheepak/cmp-latex-symbols" },
	}
}
-- Show function signature when you type
completion['ray-x/lsp_signature.nvim'] = {
    lazy = true,
    dependencies = 'nvim-lspconfig',
    event = "InsertEnter",
    config = conf.lsp_signature
}
return completion
