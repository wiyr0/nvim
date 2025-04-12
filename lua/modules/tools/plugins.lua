local tools = {}
local conf = require('modules.tools.config')

tools['nvim-telescope/telescope.nvim'] = {
    lazy = true,
    cmd = 'Telescope',
    config = conf.telescope,
    dependencies = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'}
    }
}

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions
tools['nvim-telescope/telescope-fzf-native.nvim'] = {
    lazy = true,
    run = 'make',
    dependencies = 'telescope.nvim'
}

tools['nvim-telescope/telescope-project.nvim'] = {
    lazy = true,
    dependencies = 'telescope.nvim'
}
-- 需要装下sqlite
tools['nvim-telescope/telescope-frecency.nvim'] = {
    lazy = true,
    dependencies = 'telescope.nvim',
    requires = {{'tami5/sql.nvim', lazy = true}}
}
-- tools['thinca/vim-quickrun'] = {lazy = true, cmd = {'QuickRun', 'Q'}}
-- tools['michaelb/sniprun'] = {
    -- lazy = true,
    -- run = 'bash ./install.sh',
    -- cmd = {"SnipRun", "'<,'>SnipRun"}
-- }
-- tools['folke/which-key.nvim'] = {
    -- lazy = true,
    -- keys = ",",
    -- config = function() require("which-key").setup {} end
-- }
-- tools['folke/trouble.nvim'] = {
    -- lazy = true,
    -- cmd = {"Trouble", "TroubleToggle", "TroubleRefresh"},
    -- config = conf.trouble
-- }
tools['dstein64/vim-startuptime'] = {lazy = false, cmd = "StartupTime"}
tools['gelguy/wilder.nvim'] = {
    lazy = true,
    event = "CmdlineEnter",
    config = conf.wilder,
    dependencies = { "romgrk/fzy-lua-native" }
}
tools["mfussenegger/nvim-dap"] = {
	lazy = true,
	cmd = {
		"DapSetLogLevel",
		"DapShowLog",
		"DapContinue",
		"DapToggleBreakpoint",
		"DapToggleRepl",
		"DapStepOver",
		"DapStepInto",
		"DapStepOut",
		"DapTerminate",
	},
	config = conf.dap,
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = conf.dapui,
			dependencies = {
				"nvim-neotest/nvim-nio",
			},
		},
		{ "jay-babu/mason-nvim-dap.nvim" },
	},
}
return tools
