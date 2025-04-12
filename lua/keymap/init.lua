local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
--require('keymap.config')

local plug_map = {
    -- Complete
    -- ["i|<C-e>"] = map_cmd([[compe#close('<C-e>')]]):with_expr():with_silent(),
    -- ["i|<C-f>"] = map_cmd([[compe#scroll({ 'delta': +4 })]]):with_expr()
        -- :with_silent(),
    -- ["i|<C-d>"] = map_cmd([[compe#scroll({ 'delta': -4 })]]):with_expr()
        -- :with_silent(),
    -- ["i|<C-Space>"] = map_cmd([[compe#complete()]]):with_expr():with_silent(),
    -- ["i|<Tab>"] = map_cmd("v:lua.tab_complete()"):with_expr():with_silent(),
    -- ["s|<Tab>"] = map_cmd("v:lua.tab_complete()"):with_expr():with_silent(),
    -- ["i|<S-Tab>"] = map_cmd("v:lua.s_tab_complete()"):with_expr():with_silent(),
    -- ["s|<S-Tab>"] = map_cmd("v:lua.s_tab_complete()"):with_expr():with_silent(),
    -- Plugin Telescope
    ["n|<Leader>fp"] = map_cu('Telescope project'):with_noremap():with_silent(),
    ["n|<Leader>o"] = map_cu('Telescope oldfiles'):with_noremap()
        :with_silent(),
    ["n|<Leader>ff"] = map_cu('Telescope frecency'):with_noremap():with_silent(),
    ["n|<Leader>l"] = map_cu('Telescope find_files'):with_noremap():with_silent(),
    ["n|<Leader>sc"] = map_cu('DashboardChangeColorscheme'):with_noremap()
        :with_silent(),
    ["n|<Leader>a"] = map_cu('Telescope live_grep'):with_noremap():with_silent(),
    ["n|<Leader>fn"] = map_cu('DashboardNewFile'):with_noremap():with_silent(),
    -- Plugin ZenMode
    ["n|<leader>z"] = map_cr('ZenMode'):with_noremap():with_silent(),
    -- Plugin SymbolOutline
    ["n|<leader>m"] = map_cr('SymbolsOutline'):with_noremap():with_silent(),
    -- Plugin MarkdownPreview
    ["n|<F12>"] = map_cr('MarkdownPreviewToggle'):with_noremap():with_silent(),
    -- Plugin auto_session
    ["n|<leader>ss"] = map_cu('SaveSession'):with_noremap():with_silent(),
    ["n|<leader>sr"] = map_cu('RestoreSession'):with_noremap():with_silent(),
    ["n|<leader>sd"] = map_cu('DeleteSession'):with_noremap():with_silent(),
    -- Plugin SnipRun
    -- ["v|r"] = map_cr('SnipRun'):with_noremap():with_silent(),
    -- Plugin dap
    ["n|<F6>"] = map_cr("lua require('dap').continue()"):with_noremap()
        :with_silent(),
    ["n|<leader>dr"] = map_cr("lua require('dap').continue()"):with_noremap()
        :with_silent(),
    ["n|<leader>dd"] = map_cr("lua require('dap').disconnect()"):with_noremap()
        :with_silent(),
    ["n|<leader>db"] = map_cr("lua require('dap').toggle_breakpoint()"):with_noremap()
        :with_silent(),
    ["n|<leader>dB"] = map_cr(
        "lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))"):with_noremap()
        :with_silent(),
    ["n|<leader>dbl"] = map_cr("lua require('dap').list_breakpoints()"):with_noremap()
        :with_silent(),
    ["n|<leader>drc"] = map_cr("lua require('dap').run_to_cursor()"):with_noremap()
        :with_silent(),
    ["n|<leader>drl"] = map_cr("lua require('dap').run_last()"):with_noremap()
        :with_silent(),
    ["n|<F9>"] = map_cr("lua require('dap').step_over()"):with_noremap()
        :with_silent(),
    ["n|<leader>dv"] = map_cr("lua require('dap').step_over()"):with_noremap()
        :with_silent(),
    ["n|<F10>"] = map_cr("lua require('dap').step_into()"):with_noremap()
        :with_silent(),
    ["n|<leader>di"] = map_cr("lua require('dap').step_into()"):with_noremap()
        :with_silent(),
    ["n|<F11>"] = map_cr("lua require('dap').step_out()"):with_noremap()
        :with_silent(),
    ["n|<leader>do"] = map_cr("lua require('dap').step_out()"):with_noremap()
        :with_silent(),
    ["n|<leader>dl"] = map_cr("lua require('dap').repl.open()"):with_noremap()
        :with_silent(),
    -- vim commentary: <ctrl-/>
    ["n|<c-_>"] = map_cr("Commentary"):with_noremap()
        :with_silent(),
    ["v|<c-_>"] = map_cr("Commentary"):with_noremap()
        :with_silent(),
    ["x|<c-_>"] = map_cr("Commentary"):with_noremap()
        :with_silent(),
	-- Plugin nvim-tree
	["n|<leader>n"] = map_cr("NvimTreeToggle"):with_noremap():with_silent(),
	["n|<leader>f"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent(),
	["n|<leader>r"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent(),
};

bind.nvim_load_mapping(plug_map)
local map = vim.api.nvim_buf_set_keymap
map(0, "n", "gr", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
map(0, "n", "gx", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
map(0, "x", "gx", ":<c-u>Lspsaga range_code_action<cr>", {silent = true, noremap = true})
map(0, "n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
map(0, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
map(0, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
map(0, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
map(0, "n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<cr>", {silent = true, noremap = true})
