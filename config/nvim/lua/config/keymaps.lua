--- prevent record functionality
vim.keymap.set('n', 'q', '<nop>')
vim.keymap.set('n', 'qq', 'q')

--- avoid x and s to override the clipboard
-- vim.keymap.set('n', "x", '"_x')
-- vim.keymap.set('n', "s", '"_s')
-- vim.keymap.set('n', "X", '"_X')

vim.keymap.set('n', '<Leader>yf', function()
  local filename = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg('+', filename)
  print('copied ' .. filename)
end, { desc = 'copy file name to clipboard' })
