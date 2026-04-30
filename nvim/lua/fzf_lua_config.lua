local ok, fzflua = pcall(require, "fzf-lua")
if ok then
  local actions = fzflua.actions

  fzflua.setup(
    {
      'fzf-vim',
      grep = {
        actions = {
          ["ctrl-g"] = false,
        },
      },
      buffers = {
        actions = {
          ["ctrl-x"] = actions.file_split,
          ["ctrl-g"] = { fn = actions.buf_del, reload = true },
        },
      },
      git = {
        status = {
          actions = {
            ["right"] = false,
            ["left"] = false,
            ["ctrl-x"] = actions.file_split,
          },
        },
      },
      winopts = {
        treesitter = {
          enabled = false,
        },
      },
      lsp = {
        winopts = {
          preview = {
            hidden= false,
            layout = 'vertical',
            vertical = 'down:45%',
          },
        },
      },
    }
  )

  vim.keymap.set('n', 'gd', fzflua.lsp_definitions)
  vim.keymap.set('n', 'gr', function()
    fzflua.lsp_references({
      includeDeclaration = false,
      -- winopts = {
      --   preview = {
      --     hidden= false,
      --     layout = 'vertical',
      --     vertical = 'down:45%',
      --   }
      -- }
    })
  end)
  vim.keymap.set('n', 'ga', fzflua.lsp_code_actions)
  vim.keymap.set('n', 'gi', fzflua.lsp_implementations)
  vim.keymap.set('n', 'gt', fzflua.lsp_typedefs)
  vim.keymap.set('n', 'gs', fzflua.lsp_document_symbols)
  vim.keymap.set('n', 'gS', fzflua.lsp_workspace_symbols)

  vim.keymap.set("n", "<leader>b", fzflua.buffers)
  vim.keymap.set("n", "<leader>f", fzflua.files)
  vim.keymap.set("n", "<leader>gs", fzflua.git_status)
  vim.keymap.set("n", "<leader>h", fzflua.history)
  vim.keymap.set("n", "<leader>a", fzflua.grep_project)

  vim.keymap.set('n', '<leader>*', function()
    local word = vim.fn.expand("<cword>")
    fzflua.grep({ search = word })
  end)
end
