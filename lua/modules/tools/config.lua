local config = {}

function config.telescope()
    require('telescope.builtin')
end

function config.trouble()
    require("trouble").setup {
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        action_keys = { -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
            open_split = {"<c-x>"}, -- open buffer in new split
            open_vsplit = {"<c-v>"}, -- open buffer in new vsplit
            open_tab = {"<c-t>"}, -- open buffer in new tab
            jump_close = {"o"}, -- jump to the diagnostic and close the list
            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "P", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = "p", -- preview the diagnostic location
            close_folds = {"zM", "zm"}, -- close all folds
            open_folds = {"zR", "zr"}, -- open all folds
            toggle_fold = {"zA", "za"}, -- toggle fold of current file
            previous = "k", -- preview item
            next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        signs = {
            -- icons / text used for a diagnostic
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "﫠"
        },
        use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    }
end

function config.sniprun()
    require'sniprun'.setup({
        selected_interpreters = {}, -- " use those instead of the default for the current filetype
        repl_enable = {}, -- " enable REPL-like behavior for the given interpreters
        repl_disable = {}, -- " disable REPL-like behavior for the given interpreters

        interpreter_options = {}, -- " intepreter-specific options, consult docs / :SnipInfo <name>

        -- " you can combo different display modes as desired
        display = {
            "Classic", -- "display results in the command-line  area
            "VirtualTextOk", -- "display ok results as virtual text (multiline is shortened)

            "VirtualTextErr", -- "display error results as virtual text
            -- "TempFloatingWindow",      -- "display results in a floating window
            "LongTempFloatingWindow" -- "same as above, but only long results. To use with VirtualText__
            -- "Terminal"                 -- "display results in a vertical split
        },

        -- " miscellaneous compatibility/adjustement settings
        inline_messages = 0, -- " inline_message (0/1) is a one-line way to display messages
        -- " to workaround sniprun not being able to display anything

        borders = 'shadow' -- " display borders around floating windows
        -- " possible values are 'none', 'single', 'double', or 'shadow'
    })
end

function config.wilder()
	local wilder = require("wilder")

	wilder.set_option("use_python_remote_plugin", 0)
    wilder.setup({modes = {':', '/', '?'}})
	wilder.set_option("pipeline", {
		wilder.branch(
			wilder.cmdline_pipeline({ use_python = 0, fuzzy = 1, fuzzy_filter = wilder.lua_fzy_filter() }),
			wilder.vim_search_pipeline(),
			{
				wilder.check(function(_, x)
					return x == ""
				end),
				wilder.history(),
			}
		),
	})
end

return config
