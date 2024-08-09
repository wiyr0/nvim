local lang = {}
local conf = require('modules.lang.config')

lang['fatih/vim-go'] = {
    opt = true,
    ft = 'go',
    run = ':GoInstallBinaries',
    config = conf.lang_go
}
lang["iamcco/markdown-preview.nvim"] = {
	opt = true,
	ft = "markdown",
	run = "cd app && yarn install",
}
return lang
