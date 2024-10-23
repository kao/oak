return {
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {
        mappings = {
          '<C-b>',
          '<C-f>',
          'zt',
          'zz',
          'zb',
        },
      }
    end,
  },
}
