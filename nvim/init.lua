-- neovim自体の設定
vim.opt.mouse = ''
vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.showtabline = 0
vim.opt.incsearch = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.fixeol = false
-- vim.g.fzf_preview_window = ''
-- vim.diagnostic.config({ virtual_lines = true })

-- ディレクトリ関連の設定
local state_dir = vim.fn.stdpath("state")
vim.opt.directory = state_dir .. "/swap"   -- スワップファイル
vim.opt.backupdir = state_dir .. "/backup" -- バックアップ
vim.opt.undodir   = state_dir .. "/undo"   -- アンドゥ履歴

-- プラグイン
vim.pack.add({
  -- カラースキーマ
  'https://github.com/srcery-colors/srcery-vim',
  -- ステータスライン
  'https://github.com/nvim-lualine/lualine.nvim',
  -- easy-motion
  'https://github.com/smoka7/hop.nvim',
  -- fzf
  'https://github.com/junegunn/fzf',
  'https://github.com/junegunn/fzf.vim',
  -- lsp設定
  'https://github.com/neovim/nvim-lspconfig',
  -- 構文解析
  'https://github.com/nvim-treesitter/nvim-treesitter',
  -- lsp関連
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/nvim-lua/plenary.nvim', -- fzf-lsp.nvim依存
  'https://github.com/DanSM-5/fzf-lsp.nvim',
  -- インデント可視化
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  -- 不要な行末スペースの可視化
  'https://github.com/bronson/vim-trailing-whitespace',
})

-- カラースキーマの設定
vim.g.srcery_bg = {'NONE', 'NONE'}
vim.g.srcery_inverse_matches = 1
vim.g.srcery_inverse_match_paren = 1
vim.cmd.colorscheme("srcery")

-- プラグインごとの設定読み込み
require('lualine_config')
require('smoka7-hop_config')
require('reset_keymap')
require('nvim_treesitter_config')
require('fzf_vim_config')
require('lsp_config')
require('nvim_cmp_config')
require('indent_blankline_config')
require('user_keymap')
require('user_func')

-- 操作中のnvimのソケットパスをファイルに出力
vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
  pattern = "*",
  callback = function()
    local socket = vim.v.servername
    if socket and socket ~= "" then
      local f = io.open("/tmp/nvim-sock", "w")
      if f then
        f:write(socket)
        f:close()
      end
    end
  end,
})

-- カーソル位置保存
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if line > 1 and line <= vim.fn.line "$" then
      vim.cmd 'normal! g`"zv'
    end
  end,
})

