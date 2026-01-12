-- copy viewモード切り替え
local function toggle_view_elements()
  local is_number_enabled = vim.opt.number:get()
  local new_state = not is_number_enabled

  vim.opt.number = new_state

  if new_state then
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    vim.wo.signcolumn = (#clients > 0) and "yes" or "no"
  else
    vim.wo.signcolumn = "no"
  end

  if new_state then
    vim.cmd("IBLEnable")
  else
    vim.cmd("IBLDisable")
  end

  vim.diagnostic.config({
    virtual_lines = new_state,
  })
end

vim.api.nvim_create_user_command("ViewToggle", toggle_view_elements, {
  desc = "Toggle Number, Signcolumn(LSP), IBL, and VirtualLines"
})
