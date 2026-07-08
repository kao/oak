-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Terminal mode: usable while inside Claude Code or any terminal buffer
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode (then use leader normally)" })
vim.keymap.set({ "n", "v", "t" }, "<C-e>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
