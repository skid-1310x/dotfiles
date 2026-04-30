local ok, treesitter = pcall(require, "nvim-treesitter")
if ok then
  local support_lang = { 'go', 'comment' }
  treesitter.install(support_lang)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = support_lang,
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match)
      if lang then
        vim.treesitter.start(args.buf, lang)
      end
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

