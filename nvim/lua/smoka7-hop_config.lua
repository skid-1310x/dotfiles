local hop = require('hop')
hop.setup {}

vim.keymap.set('', 's', function()
  hop.hint_char2({multi_windows = true})
end, {remap=true})
