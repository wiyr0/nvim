local config = {}

local utils = {}
local vim = vim

function utils.input_args()
	local argument_string = vim.fn.input("Program arg(s) (enter nothing to leave it null): ")
	return vim.fn.split(argument_string, " ", true)
end

function utils.input_exec_path()
	return vim.fn.input('Path to executable (default to "a.out"): ', vim.fn.expand("%:p:h") .. "/a.out", "file")
end

function utils.input_file_path()
	return vim.fn.input("Path to debuggee (default to the current file): ", vim.fn.expand("%:p"), "file")
end

function utils.get_env()
	local variables = {}
	for k, v in pairs(vim.fn.environ()) do
		table.insert(variables, string.format("%s=%s", k, v))
	end
	return variables
end

function config.telescope()
    local home = os.getenv("HOME")
    require('telescope.builtin')
    local actions = require('telescope.actions')
    require('telescope').setup {
        defaults = {
            prompt_prefix = '🔭 ',
            selection_caret = " ",
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                }
            }
        },
        extensions = {
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            frecency = {
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = {"*.git/*", "*/tmp/*"},
                workspaces = {
                    ["conf"] = home .. "/.config",
                    ["data"] = home .. "/.local/share",
                    ["nvim"] = home .. "/.config/nvim",
                    ["code"] = home .. "/code",
                    ["c"] = home .. "/code/c",
                    ["cpp"] = home .. "/code/cpp",
                    ["go"] = home .. "/go/src",
                    ["rust"] = home .. "/code/rs"
                }
            }
        }
    }
    -- require('telescope').load_extension('fzf')
    -- require('telescope').load_extension('project')
    -- require('telescope').load_extension('frecency')
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

function better_breakpoint_ui()
    local dap_breakpoint_color = {
        breakpoint = {
            ctermbg=0,
            fg='#993939',
            bg='#31353f',
        },
        logpoing = {
            ctermbg=0,
            fg='#61afef',
            bg='#31353f',
        },
        stopped = {
            ctermbg=0,
            fg='#98c379',
            bg='#31353f'
        },
    }

    vim.api.nvim_set_hl(0, 'DapBreakpoint', dap_breakpoint_color.breakpoint)
    vim.api.nvim_set_hl(0, 'DapLogPoint', dap_breakpoint_color.logpoing)
    vim.api.nvim_set_hl(0, 'DapStopped', dap_breakpoint_color.stopped)

    local dap_breakpoint = {
        error = {
            text = "",
            texthl = "DapBreakpoint",
            linehl = "DapBreakpoint",
            numhl = "DapBreakpoint",
        },
        condition = {
            text = 'ﳁ',
            texthl = 'DapBreakpoint',
            linehl = 'DapBreakpoint',
            numhl = 'DapBreakpoint',
        },
        rejected = {
            text = "",
            texthl = "DapBreakpint",
            linehl = "DapBreakpoint",
            numhl = "DapBreakpoint",
        },
        logpoint = {
            text = '',
            texthl = 'DapLogPoint',
            linehl = 'DapLogPoint',
            numhl = 'DapLogPoint',
        },
        stopped = {
            text = '',
            texthl = 'DapStopped',
            linehl = 'DapStopped',
            numhl = 'DapStopped',
        },
    }

    vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
    vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.condition)
    vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
    vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
    vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)
end

function config.dap()
    local dap = require("dap")

	dap.adapters.go = {
		type = "executable",
		command = "node",
		args = {
			require("mason-registry").get_package("go-debug-adapter"):get_install_path()
				.. "/extension/dist/debugAdapter.js",
		},
	}
    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	dap.configurations.go = {
		{
			type = "go",
			name = "Debug (file)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = utils.input_file_path(),
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
		{
			type = "go",
			name = "Debug (file with args)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = utils.input_file_path(),
			args = utils.input_args(),
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
		{
			type = "go",
			name = "Debug (executable)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = utils.input_exec_path(),
			args = utils.input_args(),
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			mode = "exec",
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
		{
			type = "go",
			name = "Debug (test file)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = utils.input_file_path(),
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			mode = "test",
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
		{
			type = "go",
			name = "Debug (using go.mod)",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = "./${relativeFileDirname}",
			console = "integratedTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
			mode = "test",
			showLog = true,
			showRegisters = true,
			stopOnEntry = false,
		},
	}

    dap.adapters.python = {
        type = 'executable',
        command = '/Users/wiyr/.pyenv/shims/python',
        args = {'-m', 'debugpy.adapter'}
    }
    dap.configurations.python = {
        {
            -- The first three options are required by nvim-dap
            type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = 'launch',
            name = "Launch file",

            -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

            program = "${file}", -- This configuration will launch the current file if used.
            pythonPath = function()
                return '/Users/wiyr/.pyenv/shims/python'
            end
        }
    }
    better_breakpoint_ui()
end

function config.dapui()
    local dapui = require("dapui")
    dapui.setup({
        icons = {expanded = "▾", collapsed = "▸"},
        mappings = {
            -- Use a table to apply multiple mappings
            expand = {"<CR>", "<2-LeftMouse>"},
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r"
        },
        sidebar = {
            open_on_start = true,
            elements = {
                -- Provide as ID strings or tables with "id" and "size" keys
                {
                    id = "scopes",
                    size = 0.25 -- Can be float or integer > 1
                }, {id = "breakpoints", size = 0.25},
                {id = "stacks", size = 0.25}, {id = "watches", size = 00.25}
            },
            width = 40,
            position = "left"
        },
        tray = {
            open_on_start = true,
            elements = {"repl"},
            height = 10,
            position = "bottom"
        },
        floating = {
            max_height = nil,
            max_width = nil,
            mappings = {close = {"q", "<Esc>"}}
        },
        windows = {indent = 1}
    })
    local dap = require("dap")
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
        dap.repl.close()
    end


    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
        dap.repl.close()
    end
end


return config
