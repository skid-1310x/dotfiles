vim.diagnostic.config({ virtual_lines = true })

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  local map = vim.keymap.set
  local fzflsp = require('fzf_lsp')

  vim.g.fzf_lsp_preview_window={'down,+{3}+1/2'}

    map('n', 'gd',         fzflsp.definition_call,       opts)
    map('n', 'gr',         fzflsp.references_call,       opts)
    map('n', 'gi',         fzflsp.implementation_call,   opts)
    map('n', 'gt',         fzflsp.type_definition_call,  opts)
    map('n', 'ga',         fzflsp.code_action_call,      opts)
    map('n', 'gs',         fzflsp.document_symbol_call,  opts)
    map('n', 'gS',         fzflsp.workspace_symbol_call, opts)
    map('n', 'K',          function()
      vim.lsp.buf.hover({ border = "single" })
    end, opts)
    map('n', 'g[',        function()
      vim.diagnostic.jump({ count = -1, float = false })
    end, opts)
    map('n', 'g]',         function()
      vim.diagnostic.jump({ count = 1, float = false })
    end, opts)
    map('n', '<leader>rn', vim.lsp.buf.rename, opts)
    --

    -- 保存時の自動整形
    if not client:supports_method("textDocument/willSaveWaitUntil")
       and client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 1000 })
        end,
      })
    end

    if client and client:supports_method('textDocument/documentHighlight') then
      local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })

      vim.opt.updatetime = 500

      vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#3e4452' })
      vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#3e4452' })
      vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#3e4452' })
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
    end

    vim.wo.signcolumn = "yes"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.insertTextModeSupport = {
  valueSet = { 1, 2 }
}
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "additionalTextEdits", "insertTextFormat", "insertTextMode", "command" }
}
capabilities.textDocument.completion.completionItem.completionList = {
  itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" }
}
capabilities.textDocument.completion.completionItem.insertTextMode = 1

vim.lsp.config('*', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
   gopls = {
      usePlaceholders = true,
      analyses = {
        fillstruct = true,
      },
   },
  },
})
vim.lsp.enable('gopls')
