-- Keymaps loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Discover all keymaps: <leader>sk (Telescope keymaps)

-- Exit terminal mode with <Esc> instead of <C-\><C-n>.
-- Required so <Esc> in the Claude Code terminal returns to Neovim
-- normal mode instead of being captured by Claude's TUI.
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })
