----------------------------------------------------------------------- 
-- Package Manager (packer.nvim)
------------------------------------------------------------------------ 

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer...')
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
  print('Done.')
  
  vim.cmd('packadd packer.nvim')
  install_plugins = true
end

require('packer').startup(function(use)

  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Themes
  use 'joshdick/onedark.vim'
  use {"adisen99/apprentice.nvim", requires = {"rktjmp/lush.nvim"}}
  use 'EdenEast/nightfox.nvim'
  use 'folke/tokyonight.nvim'
  use "lunarvim/darkplus.nvim"

  -- Web Icons
  use "nvim-tree/nvim-web-devicons"

  -- Status Line
  use 'nvim-lualine/lualine.nvim'

  -- Buffer Tabs
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

  -- Indent Blankline
  use "lukas-reineke/indent-blankline.nvim" 

  -- Tree Sitter
  use 'nvim-treesitter/nvim-treesitter'

  -- Tree Sitter Textobjects
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  
  -- surround.vim
  use 'tpope/vim-surround'

  -- telescope.vim
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- findr 
  use 'conweller/findr.vim'

  -- toggleterm
  use { 'akinsho/toggleterm.nvim', tag= '*' }

  -- Coc.nvim
  use { 'neoclide/coc.nvim', branch = 'release' } 

  if install_plugins then
    require('packer').sync()
  end
end)

-- stop execution of script while plugins are being downloaded
-- the first time
if install_plugins then
  return
end

------------------------------------------------------------------------ 
-- vim : module 
-- opt : property with all Neovim options 
--       (:help option-list, :help 'option_name')
-- 
-- syntax : vim.opt.option_name = value
------------------------------------------------------------------------ 

-- show line numbers in gutter
vim.opt.number = true    

-- enable mouse interaction
vim.opt.mouse = 'a'

-- ignore uppercase letters when executing a search
vim.opt.ignorecase = true

-- ignore uppercase letters unless the search term has an uppercase letter
vim.opt.smartcase = true

-- disable highlight search results of the previous search
vim.opt.hlsearch = false

-- enable wrapping
vim.opt.wrap = true

-- preserve indentation of a virtual line (when wrap enabled)
vim.opt.breakindent = true

-- tab characters
vim.opt.tabstop = 2

-- amount of characters Neovim will use to indent a line
vim.opt.shiftwidth = 2

-- transform a Tab character to spaces
vim.opt.expandtab = true

-- always draw sign column
vim.opt.signcolumn = "yes"

-- set width of gutter
vim.opt.numberwidth = 4

-- backup file
vim.opt.backup = true

-- open verticaly splits on right
vim.opt.splitright = true

-- open horizontal splits below
vim.opt.splitbelow = true

----------------------------------------------------------------------
-- Keybindings
-- vim.keymap.set
--
-- Basic usage (save with Space-w):
-- vim.keymap.set('n', '<space>w', '<cmd>write<cr>', {desc = 'Save'})
--
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
----------------------------------------------------------------------

-- The leader key
-- `mapleader` is a global variable that can be a string
--  Default value is '\'
--
-- Can be used as a prefix in our keybindings:
-- vim.g.mapleader = ' '
-- vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')

----------------------------------------------------------------------
-- Mappings
----------------------------------------------------------------------

-- set mapleader to space key
vim.g.mapleader = ' '

-- copy to clipboard
vim.keymap.set({'n', 'x'}, 'cp', '"+y')

-- paste from clipboard
vim.keymap.set({'n', 'x'}, 'cv', '"+p')

-- modify 'x' to delete text without changing the internal registers
vim.keymap.set({'n', 'x'}, 'x', '"_x')

-- select all text in current buffer
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- motion mappings
vim.keymap.set('i', '<c-l>', '<right>')
vim.keymap.set('i', '<c-h>', '<left>')
vim.keymap.set('i', '<c-j>', '<down>')
vim.keymap.set('i', '<c-k>', '<up>')
vim.keymap.set('i', '<c-m>', '<c-c>o') 

-- recursive keybinding that uses F2 
-- (use previous keybindings in {rhs} argument
-- pressing spsce twice opens file explorer
-- vim.keymap.set('n', '<space><space>', '<F2>', {remap = true})

----------------------------------------------------------------------
-- Telescope 
----------------------------------------------------------------------

-- search open files
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
-- search recently opened files
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
-- search files in current working directory
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
-- search for a pattern in all files in current working directory
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
-- search diagnostic messages
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
-- search for a pattern in the current file
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

----------------------------------------------------------------------
-- Findr
----------------------------------------------------------------------

vim.g.findr_highlight_matches = 1
vim.g.findr_floating_window = 0

vim.keymap.set('n', '<leader>d', '<cmd>Findr<cr>')

----------------------------------------------------------------------
-- Theme
----------------------------------------------------------------------

require('nightfox').setup({
  groups = {
    all = {
      LineNr = { fg = "#364353", bg = "#192330" }
    }
  }
})

vim.opt.termguicolors = true
vim.opt.background = 'dark'

-- vim.cmd: use vimscript inside lua
vim.cmd('colorscheme habamax')

----------------------------------------------------------------------
-- Toggleterm
----------------------------------------------------------------------

require('toggleterm').setup({
  open_mapping = '<C-g>',
  direction = 'vertical',
  shade_terminals = true
})

-- Keymaps
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  --vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

----------------------------------------------------------------------
-- Bufferline
----------------------------------------------------------------------

-- Mappings to quickly switch tabs
vim.keymap.set('n', 'tn', '<cmd>bn<cr>')
vim.keymap.set('n', 'tp', '<cmd>bp<cr>')

require('bufferline').setup({
  options = {
    mode = 'buffers',           -- one tab per file ('tabs' for tabpages)
    offsets = {                 -- file types to avoid tab rendering
      {filetype = 'NvimTree'}
    }
  },
  highlights = {                 -- modify tab style
    buffer_selected = {
      italic = false
    },
    indicator_selected = {
      -- use same highlight color as colorscheme uses for functions
      fg = {attribute = 'fg', highlight = 'Function'},  
      italic = false
    }
  }
})

----------------------------------------------------------------------
-- Indent Blankline 
----------------------------------------------------------------------

require('indent_blankline').setup({
  char = '▏' ,                             -- character on screen
  show_trailing_blankline_indent = false,  -- show indent guides in blank lines
  show_first_indent_level = false,         -- show an indent guide on first column
  use_treesitter = true,                   -- use treesitter to determine where indent guide should be
  show_current_context = false             -- highlight indent level where cursor is
})

----------------------------------------------------------------------
-- Treesitter
----------------------------------------------------------------------

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.haskell = {
  install_info = {
    url = "~/.config/nvim/opt/tree-sitter-haskell",
    files = {"src/parser.c", "src/scanner.c"}
  },
  -- filetype = "hs",
}

require('nvim-treesitter.configs').setup({
  
  -- Install language parsers
  ensure_installed = { "lua", "javascript", "typescript", "json", "css", "haskell" },
  
  -- Enable better syntax highlighting
  highlight = {
    enable = true,
  },

  -- Textobjects
  textobjects = {
    select = {
      enable = true,
      lookahead = true,  -- make cursor jump to nearest match
      keymaps = {        -- key bindings for text objects
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    }
  }
})

----------------------------------------------------------------------
-- Lualine
----------------------------------------------------------------------

require('lualine').setup({
  options = {
    theme = 'OceanicNext',
    icons_enabled = false,
    section_separators = '',
    component_separators = ''
  }
})

----------------------------------------------------------------------
-- File explorer
----------------------------------------------------------------------

-- :Lexplore
-- :help netrw
-- change global vimscript variables with vim.g

-- hide help text in banner
vim.g.netrw_banner = 0

-- change size of window
vim.g.netrw_winsize = 20

-- open file explorer
vim.keymap.set('n', '<leader>x', '<cmd>Lexplore<cr>')

----------------------------------------------------------------------
-- User commands
----------------------------------------------------------------------
-- :help nvim_create_user_command()
-- :help user-commands
-- vim.api.nvim_create_user_command({name}, {command}, {opts})

-- function that reloads our configuration
vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

----------------------------------------------------------------------
-- Autocommands
----------------------------------------------------------------------
-- Execute actions when Neovim triggers and event.
-- :help autocmd-intro
-- :help events
-- vim.api.nvim_create_autocmd({event}, {opts})

-- Create a group called user_cmd and add two autocommands to it:
local augroup = vim.api.nvim_create_augroup('user_cmds', {clear = true})

-- Make a keymap 'q' to close the current window, but only if the 
-- filetype is 'help' or 'man'.
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = augroup,
  desc = 'Use q to close the window',
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

-- -- Highlight the text we copy using 'y'.
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  desc = 'Highlight on yank',
  callback = function(event)
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end
})

----------------------------------------------------------------------
-- User modules
----------------------------------------------------------------------
-- :call mkdir(stdpath("config"), "/lua/user", "p")
-- :help lua-require

-- Reload config, empty 'require' cache before using it
-- local load = function(mod)
--   package.loaded(mod) = nil
--   require(mod)
-- end

----------------------------------------------------------------------
-- Coc.nvim
----------------------------------------------------------------------

-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
--keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

vim.api.nvim_create_augroup("CocGroup", {})

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

vim.api.nvim_create_autocmd("User", {
  group = "CocGroup",
  pattern = "CursorHold",
  command = "call CocActionAsync('doHover')",
  desc = "TODO"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply code actions affect whole buffer.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Remap keys for applying codeActions to the current buffer
keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)

-- https://www.reddit.com/r/neovim/comments/k2vprd/can_i_remove_the_orange_warning_underline_more/
-- CocErrorHightlight 
-- CocHintHighlight
-- CocInfoHighlight
-- CocWarningHighlight
-- :hi <group>
-- :hi CocHintHighlight 
-- :hi DiagnosticUnderlineHint
vim.cmd(':hi DiagnosticUnderlineHint guisp=Black')
