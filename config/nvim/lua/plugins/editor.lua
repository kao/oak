return {
  { 'nvim-lua/plenary.nvim' },

  -- {
  --   'karb94/neoscroll.nvim',
  --   config = function()
  --     require('neoscroll').setup {
  --       mappings = {
  --         '<C-b>',
  --         '<C-f>',
  --         'zt',
  --         'zz',
  --         'zb',
  --       },
  --     }
  --   end,
  -- },
  --
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require('lualine').setup {
        options = {
          theme = "catppuccin"
        }
      }
    end
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('fzf-lua').setup {
        'fzf-native',
        fzf_colors = true,
        winopts = {
          preview = {
            default = 'bat',
            layout = 'vertical',
            vertical = 'down:85%',
          },
        },
        keymap = {
          fzf = {
            ['ctrl-f'] = 'preview-page-down',
            ['ctrl-b'] = 'preview-page-up',
          },
        },
      }

      local maps = vim.keymap
      if vim.fn.executable 'git' == 1 then
        maps.set('n', '<Leader>gb', function()
          require('fzf-lua').git_branches()
        end, { desc = 'Git branches' })
        maps.set('n', '<Leader>gc', function()
          require('fzf-lua').git_commits()
        end, { desc = 'Git commits (repository)' })
        maps.set('n', '<Leader>gC', function()
          require('fzf-lua').git_bcommits()
        end, { desc = 'Git commits (current file)' })
        maps.set('n', '<Leader>gt', function()
          require('fzf-lua').git_status()
        end, { desc = 'Git status' })
      end
      maps.set('n', '<Leader>f<CR>', function()
        require('fzf-lua').resume()
      end, { desc = 'Resume previous search' })
      maps.set('n', "<Leader>f'", function()
        require('fzf-lua').marks()
      end, { desc = 'Find marks' })
      maps.set('n', '<Leader>f/', function()
        require('fzf-lua').lgrep_curbuf()
      end, { desc = 'Find words in current buffer' })
      maps.set('n', '<Leader>fb', function()
        require('fzf-lua').buffers()
      end, { desc = 'Find buffers' })
      maps.set('n', '<Leader>fc', function()
        require('fzf-lua').grep_cword()
      end, { desc = 'Find word under cursor' })
      maps.set('n', '<Leader>fC', function()
        require('fzf-lua').commands()
      end, { desc = 'Find commands' })
      maps.set('n', '<Leader>ff', function()
        require('fzf-lua').files()
      end, { desc = 'Find files' })
      maps.set('n', '<Leader>fh', function()
        require('fzf-lua').helptags()
      end, { desc = 'Find help' })
      maps.set('n', '<Leader>fk', function()
        require('fzf-lua').keymaps()
      end, { desc = 'Find keymaps' })
      maps.set('n', '<Leader>fm', function()
        require('fzf-lua').manpages()
      end, { desc = 'Find man' })
      maps.set('n', '<Leader>fo', function()
        require('fzf-lua').oldfiles()
      end, { desc = 'Find history' })
      maps.set('n', '<Leader>fr', function()
        require('fzf-lua').registers()
      end, { desc = 'Find registers' })
      maps.set('n', '<Leader>ft', function()
        require('fzf-lua').colorschemes()
      end, { desc = 'Find themes' })
      if vim.fn.executable 'rg' == 1 or vim.fn.executable 'grep' == 1 then
        maps.set('n', '<Leader>fw', function()
          require('fzf-lua').live_grep_native()
        end, { desc = 'Find words' })
      end
      -- maps.n["<Leader>ls"] = { function() require("fzf-lua").lsp_document_symbols() end, desc = "Search symbols" }

      function GrepInDirectory(default_word)
        local input_dir = vim.fn.input('Directory to search: ', vim.fn.getcwd(), 'dir')
        if input_dir == '' then
          return
        end

        local word = default_word or vim.fn.input 'Search for: '
        if word == '' then
          return
        end

        require('fzf-lua').grep {
          search = word,
          cwd = input_dir,
          prompt = 'Grep (' .. input_dir .. '): ',
        }
      end
      maps.set('n', '<leader>fd', ':lua GrepInDirectory()<CR>', { desc = 'Find in directory' })
      maps.set('n', '<leader>fW', ":lua GrepInDirectory(vim.fn.expand('<cword>'))<CR>", { desc = 'Find current word in directory' })

      -- Load the custom file browser plugin
      -- local file_browser = require("fzf-lua-file-browser")

      -- Add a key mapping to browse files
      vim.api.nvim_set_keymap('n', '<leader>ed', ":lua require('fzf-lua-file-browser').browse()<CR>", { noremap = true, silent = true })
    end,
  },
}
