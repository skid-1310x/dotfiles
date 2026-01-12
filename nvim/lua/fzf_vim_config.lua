vim.g.fzf_preview_window = ''

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>b',  ':Buffers<CR>', opts)
vim.keymap.set('n', '<leader>f',  ':Files<CR>', opts)
vim.keymap.set('n', '<leader>gs', ':GFiles?<CR>', opts)
vim.keymap.set('n', '<leader>h',  ':History<CR>', opts)
vim.keymap.set('n', '<leader>a',  ':Ag<CR>', opts)

-- fzf.vimを実行したときにフローティングウィンドウの下部にステータスラインが表示されてしまう問題の対処
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fzf",
  callback = function()
    -- 処理をスケジュールに登録し、少しだけ実行を遅らせる
    vim.schedule(function()
      vim.wo.statusline = ""
    end)
  end,
})

