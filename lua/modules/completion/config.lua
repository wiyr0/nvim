local config = {}

local function get_binary_path_list(binaries)
	local path_list = {}
	for _, binary in ipairs(binaries) do
		local path = vim.fn.exepath(binary)
		if path ~= "" then
			table.insert(path_list, path)
		end
	end
	return table.concat(path_list, ",")
end

function config.nvim_lsp()
    local nvim_lsp = require("lspconfig")
    require("mason").setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    })
    require("mason-lspconfig").setup({
        -- 确保安装，根据需要填写
        ensure_installed = {
            "lua_ls",
            "clangd",
            "pyright"
        },
    })
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require("mason-lspconfig").setup_handlers {
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
    			capabilities = capabilities
			}
        end,
		['clangd'] = function()
            require("lspconfig").clangd.setup {
              cmd = {
				  "clangd",
				  "-j=12",
				  "--enable-config",
				  "--background-index",
				  "--pch-storage=memory",
				  -- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
				  "--query-driver=" .. get_binary_path_list({ "clang++", "clang", "gcc", "g++" }),
				  "--clang-tidy",
				  "--all-scopes-completion",
				  "--completion-style=detailed",
				  "--header-insertion-decorators",
				  "--header-insertion=iwyu",
				  "--limit-references=3000",
				  "--limit-results=350",
              },
			  capabilities = capabilities
			}
		end

    }
	pcall(vim.cmd.LspStart)
end

function gen_lspkind_icons()
    return {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
    }
end


function config.cmp()
	local cmp = require("cmp")
	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end
    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        -- formatting = {
			-- format = function(entry, vim_item)
				-- local lspkind_icons = gen_lspkind_icons()
				-- -- load lspkind icons
				-- vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)
				-- vim_item.menu = ({
					-- buffer = "[BUF]",
					-- nvim_lsp = "[LSP]",
					-- path = "[PATH]",
                    -- cmp_tabnine = "[TN]",
				-- })[entry.source.name]

				-- return vim_item
			-- end,
		-- },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
            -- { name = 'cmp_tabnine' },
        })
    })
	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})
	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
	})
end

function config.saga()
	require('lspsaga').setup({})
end

function config.lsp_signature()
    cfg = {
        debug = false, -- set to true to enable debug logging
        log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
        -- default is  ~/.cache/nvim/lsp_signature.log
        verbose = false, -- show debug line number

        bind = true, -- This is mandatory, otherwise border config won't get registered.
        -- If you want to hook lspsaga or other signature handler, pls set to false
        doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
        -- set to 0 if you DO NOT want any API comments be shown
        -- This setting only take effect in insert mode, it does not affect signature help in normal
        -- mode, 10 by default

        floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

        floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
        -- will set to true when fully tested, set to false will use whichever side has more space
        -- this setting will be helpful if you do not want the PUM and floating win overlap

        floating_window_off_x = 1, -- adjust float windows x position.
        floating_window_off_y = 1, -- adjust float windows y position.


        fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
        hint_enable = true, -- virtual hint enable
        hint_prefix = "🐼 ",  -- Panda for parameter
        hint_scheme = "String",
        hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
        max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
        -- to view the hiding contents
        max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
        handler_opts = {
            border = "rounded"   -- double, rounded, single, shadow, none
        },

        always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

        auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
        extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
        zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

        padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

        transparency = nil, -- disabled by default, allow floating win transparent value 1~100
        shadow_blend = 36, -- if you using shadow as border use this set the opacity
        shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
        timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
        toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    }

    require'lsp_signature'.setup(cfg)
end

-- function config.autopairs()
    -- require('nvim-autopairs').setup({
        -- disable_filetype = {"TelescopePrompt"},
        -- ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        -- enable_moveright = true,
        -- -- add bracket pairs after quote
        -- enable_afterquote = true,
        -- -- check bracket in same line
        -- enable_check_bracket_line = true,
        -- check_ts = true
    -- })

    -- require("nvim-autopairs.completion.compe").setup({
        -- map_cr = true,
        -- map_complete = true
    -- })
-- end

return config
