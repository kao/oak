-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

-- Escape in insert mode with jk
vim.keymap.set("i", "jk", "<Esc>")
