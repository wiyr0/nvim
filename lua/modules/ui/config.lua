local config = {}

function config.galaxyline()
    require('modules.ui.eviline')
end

function config.gitsigns()
    require('gitsigns').setup {
        -- signs = {
            -- add = {hl = 'GitGutterAdd', text = '▋'},
            -- change = {hl = 'GitGutterChange', text = '▋'},
            -- delete = {hl = 'GitGutterDelete', text = '▋'},
            -- topdelete = {hl = 'GitGutterDeleteChange', text = '▔'},
            -- changedelete = {hl = 'GitGutterChange', text = '▎'}
        -- },
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        }
    }
end

function config.indent_blankline()
    require("ibl").setup()
end

function config.dashboard_nvim()
    require("dashboard").setup({
    })
end

function config.zen_mode() require('zen-mode').setup {} end

function config.nvim_bufferline()
	require("bufferline").setup({
		options = {
			number = "none",
			modified_icon = "✥",
			buffer_close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			max_name_length = 14,
			max_prefix_length = 13,
			tab_size = 20,
			show_buffer_close_icons = true,
			show_buffer_icons = true,
			show_tab_indicators = true,
			diagnostics = "nvim_lsp",
			always_show_bufferline = true,
			separator_style = "thin",
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					padding = 1,
				},
			},
		},
	})
end

function config.nvim_gps()
    require("nvim-gps").setup()
end

function config.lualine()
    -- require('modules.ui.evil_lualine')
    require('lualine').setup({
        options = {theme = 'tokyonight' }
    })
end

return config
