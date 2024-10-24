-- lua/fzf-lua-file-browser/init.lua
local fzf_lua = require 'fzf-lua'
local Path = require 'plenary.path'
local scan = require 'plenary.scandir'

local file_browser = {}

-- Function to get the list of files and directories in a given path
local function scan_dir(path)
  local entries = scan.scan_dir(path, { hidden = true, add_dirs = true })
  local results = {}
  for _, entry in ipairs(entries) do
    local p = Path:new(entry)
    table.insert(results, {
      name = p:make_relative(path),
      is_dir = p:is_dir(),
    })
  end
  return results
end

-- Function to format the display for fzf-lua
local function format_entries(entries)
  local formatted = {}
  for _, entry in ipairs(entries) do
    if entry.is_dir then
      table.insert(formatted, entry.name .. '/')
    else
      table.insert(formatted, entry.name)
    end
  end
  return formatted
end

-- Main function to browse files using fzf-lua
function file_browser.browse(path)
  path = path or vim.loop.cwd() -- Use current working directory if no path is given

  local entries = scan_dir(path)
  local formatted = format_entries(entries)

  fzf_lua.fzf_exec(formatted, {
    prompt = 'File Browser> ',
    cwd = path,
    actions = {
      -- Define key mappings for opening files and navigating directories
      ['default'] = function(selected)
        local target = Path:new(path):joinpath(selected[1]):absolute()
        local p = Path:new(target)
        if p:is_dir() then
          -- If the selected item is a directory, browse that directory
          file_browser.browse(target)
        else
          -- Otherwise, open the file
          vim.cmd('edit ' .. target)
        end
      end,
      ['ctrl-d'] = function(selected)
        -- Custom action: Delete file (using ctrl-d)
        local target = Path:new(path):joinpath(selected[1]):absolute()
        Path:new(target):rm()
        print('Deleted: ' .. target)
        file_browser.browse(path)
      end,
    },
  })
end

return file_browser
