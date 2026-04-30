local ok, lualine = pcall(require, "lualine")
if ok then
  local srcery = require('lualine_themes.srcery')
  lualine.setup {
    options = {
      icons_enabled = false,
      theme = srcery,
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'fileformat', 'encoding', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
  }
end
