-- gotests generate
vim.keymap.set('n', '<leader>tg', function()
  local cword = vim.fn.expand('<cword>')
  local file = vim.fn.expand('%')

  vim.cmd(string.format('!gotests -w -template testify -only %s %s', cword, file))
end, { desc = "Generate Go tests using gotests" })


-- カーソル位置にUUIDを挿入
vim.keymap.set('n', '<leader>uu', function()
    local uuid = vim.fn.system('uuidgen'):gsub('%s+', '')
    vim.api.nvim_put({uuid}, 'c', false, false)
end, { desc = 'Insert UUID from system uuidgen' })
