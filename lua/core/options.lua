local global = require('core.global')
vim.g.mapleader = ","

local dashboard_config = function()
    vim.g.dashboard_footer_icon = '🐬 '
    vim.g.dashboard_default_executive = 'telescope'

    vim.g.dashboard_custom_header = {
        [[              ...  .......          ]],
        [[         ....................       ]],
        [[    ..'........................     ]],
        [[ ...,'.......'.., .........'....    ]],
        [[  .'......,. ;'., '..'.......'.'.   ]],
        [[ .'.,'.''.;..,'.. .  ...'....','..  ]],
        [[..''.'.''''.....        .,'....;'.. ]],
        [[..',.......'. .        ..';'..','...]],
        [[ ....''..  ..        .....;,..','...]],
        [[  . .....           ......,..';,....]],
        [[      .'.         ....  ... ,,'.....]],
        [[      .,..             .....,'..... ]],
        [[     .'''.             ...'......   ]],
        [[     ..'..'.          ... ......    ]],
        [[       . '.'..             ..       ]],
        [[         ......           .         ]],
        [[            ....                    ]]
    }

    vim.g.dashboard_custom_section = {
        change_colorscheme = {
            description = {' Scheme change              comma s c '},
            command = 'DashboardChangeColorscheme'
        },
        find_frecency = {
            description = {' File frecency              comma f r '},
            command = 'Telescope frecency'
        },
        find_history = {
            description = {' File history               comma f e '},
            command = 'DashboardFindHistory'
        },
        find_project = {
            description = {' Project find               comma f p '},
            command = 'Telescope project'
        },
        find_file = {
            description = {' File find                  comma f f '},
            command = 'DashboardFindFile'
        },
        file_new = {
            description = {' File new                   comma f n '},
            command = 'DashboardNewFile'
        },
        find_word = {
            description = {' Word find                  comma f w '},
            command = 'DashboardFindWord'
        }
    }
end

dashboard_config()

local function bind_option(options)
    for k, v in pairs(options) do
        if v == true or v == false then
            vim.cmd('set ' .. k)
        else
            vim.cmd('set ' .. k .. '=' .. v)
        end
    end
end

local function load_options()
    local global_local = {
        termguicolors = true,
        mouse = "a",
        errorbells = true,
        visualbell = true,
        -- hidden = true, -- false: save changes when switch to another file
        fileformats = "unix,mac,dos",
        magic = true, -- 搜索特殊字符时，部分可不转义
        virtualedit = "block", -- virtual模式，可使用块选中
        encoding = "utf-8",
        -- clipboard = "unnamedplus",
        wildignorecase = true,
        wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**", -- auto complete ignore these files
        backup = false,
        writebackup = false,
        swapfile = false,
        directory = global.cache_dir .. "swap/", -- ???
        undodir = global.cache_dir .. "undo/", -- ???
        backupdir = global.cache_dir .. "backup/", --- ???
        viewdir = global.cache_dir .. "view/", --- ???
        spellfile = global.cache_dir .. "spell/en.uft-8.add", -- word set
        history = 2000,
        -- shada = "!,'300,<50,@100,s10,h",
        smarttab = true,
        shiftround = true, -- round indent to multiple of shiftwidth by > or <
        -- timeout = true,
        -- ttimeout = true,
        -- timeoutlen = 500,
        -- ttimeoutlen = 0,
        -- updatetime = 100,
        -- redrawtime = 1500,
        -- ignorecase = true,
        -- smartcase = true,
        -- infercase = true,
        -- incsearch = true,
        -- wrapscan = true,
        -- complete = ".,w,b,k",
        -- inccommand = "nosplit",
        -- grepformat = "%f:%l:%c:%m",
        -- grepprg = 'rg --hidden --vimgrep --smart-case --',
        -- breakat = [[\ \	;:,!?]],
        -- startofline = false,
        -- whichwrap = "h,l,<,>,[,],~",
        -- splitbelow = true,
        -- splitright = true,
        -- switchbuf = "useopen",
        -- backspace = "indent,eol,start",
        -- diffopt = "filler,iwhite,internal,algorithm:patience",
        -- completeopt = "menuone,noselect",
        -- jumpoptions = "stack",
        -- showmode = false,
        -- shortmess = "aoOTIcF",
        -- scrolloff = 2,
        -- sidescrolloff = 5,
        -- foldlevelstart = 99,
        -- ruler = true,
        cursorline = true,
        -- cursorcolumn = true,
        -- list = true,
        -- showtabline = 2,
        -- winwidth = 30,
        -- winminwidth = 10,
        -- pumheight = 15,
        -- helpheight = 12,
        -- previewheight = 12,
        -- showcmd = false,
        cmdheight = 2,
        -- cmdwinheight = 5,
        -- equalalways = false,
        -- laststatus = 2,
        -- display = "lastline",
        -- showbreak = "↳  ",
        -- listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
        -- pumblend = 10,
        -- winblend = 10,
        -- autoread = true,
        -- autowrite = true
    }

    local bw_local = {
        -- undofile = true,
        -- formatoptions = "1jcroql",
        -- textwidth = 80,
        expandtab = true,
        autoindent = true,
        tabstop = 4,
        shiftwidth = 4,
        so = 7,  -- Set 7 lines to the cursor - when moving vertically using j/k
        -- softtabstop = -1,
        -- breakindentopt = "shift:2,min:20",
        -- wrap = false,
        -- linebreak = true,
        number = true,
        -- relativenumber = true,
        -- foldenable = true,
        -- signcolumn = "yes",
        conceallevel = 0,
        concealcursor = "niv",
        foldmethod = 'marker'
    }

    if global.is_mac then
        vim.g.clipboard = {
            name = "macOS-clipboard",
            copy = {["+"] = "pbcopy", ["*"] = "pbcopy"},
            paste = {["+"] = "pbpaste", ["*"] = "pbpaste"},
            cache_enabled = 0
        }
        vim.g.python_host_prog = '/usr/bin/python'
        vim.g.python3_host_prog = '/Users/wiyr/.pyenv/versions/3.7.5/bin/python3'
    end
    for name, value in pairs(global_local) do vim.o[name] = value end
    bind_option(bw_local)
end

load_options()
