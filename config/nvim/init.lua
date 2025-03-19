-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

-- TODO: move it elsewhere
-- Beginning/End of line
vim.keymap.set("n", "<C-e>", "<End>", { desc = "Move cursor to end of line in normal mode" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "Move cursor to end of line in insert mode" })
vim.keymap.set("v", "<C-e>", "<End>", { desc = "Move cursor to end of line in visual mode" })
vim.keymap.set("n", "<C-a>", "<Home>", { desc = "Move cursor to beginning of line in normal mode" })
vim.keymap.set("i", "<C-a>", "<Home>", { desc = "Move cursor to beginning of line in insert mode" })
vim.keymap.set("v", "<C-a>", "<Home>", { desc = "Move cursor to beginning of line in visual mode" })

-- Buffers
vim.keymap.set("n", "<C-i>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-u>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

require "lazy_setup"
require "polish"
