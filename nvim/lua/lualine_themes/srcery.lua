local colors = {
  base00         = '#666656',
  base01         = '#4e4e43',
  base02         = '#30302c',
  base03         = '#151513',
  base0          = '#808070',
  base1          = '#949484',
  base2          = '#a8a897',
  base3          = '#e8e8d3',
  yellow         = '#fbb829',
  orange         = '#d75f00',
  red            = '#ff3128',
  magenta        = '#e02c6d',
  bright_magenta = '#e35682',
  blue           = '#5573a3',
  bright_blue    = '#8eb2f7',
  cyan           = '#0aaeb3',
  green          = '#519f50',
  bright_green   = '#98bc37',
  white          = '#fce8c3',
}
local location_section = {bg = colors.base1, fg = colors.base02}
return {
  normal = {
    a = {bg = colors.bright_blue, fg = colors.base02, gui = 'bold'},
    b = {bg = colors.base01, fg = colors.base3},
    c = {bg = colors.base02, fg = colors.base0},
    y = {bg = colors.base01, fg = colors.base2},
    z = location_section,
  },
  insert = {
    a = {bg = colors.bright_green, fg = colors.base02, gui = 'bold'},
    z = location_section,
  },
  visual = {
    a = {bg = colors.bright_magenta, fg = colors.base02, gui = 'bold'},
    z = location_section,
  },
  replace = {
    a = {bg = colors.orange, fg = colors.base02, gui = 'bold'},
    z = location_section,
  },
  command = {
    a = {bg = colors.cyan, fg = colors.base02, gui = 'bold'},
    z = location_section,
  },
  -- inactive = {
  -- }
}
