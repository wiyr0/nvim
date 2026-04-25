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
    local navic = require("nvim-navic")
    require("mason-lspconfig").setup_handlers {
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end,
    			capabilities = capabilities
			}
        end,
		['clangd'] = function()
            require("lspconfig").clangd.setup {
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                    -- 添加格式化修改的命令
                    -- vim.keymap.set("n", "fm", function()
                    --     require("lsp-format-modifications").format_modifications(client, bufnr)
                    -- end, { buffer = bufnr, desc = "Format modified lines only" })
                end,
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
	require('lspsaga').setup({
		ui = {
			code_action = "" --会窗口抖动
        }

    })
end

function config.lsp_signature()
    require'lsp_signature'.setup()
end

return config
