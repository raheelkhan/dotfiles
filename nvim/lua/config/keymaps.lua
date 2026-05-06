-- Keymaps loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Discover all keymaps: <leader>sk (Telescope keymaps)

-- Exit terminal mode with <Esc> instead of <C-\><C-n>.
-- Required so <Esc> in the Claude Code terminal returns to Neovim
-- normal mode instead of being captured by Claude's TUI.
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })

-- Open any file system-wide. Prompts for a starting directory (Tab-complete);
-- press <CR> on the default to scan from $HOME, or type "/tmp", "/etc", etc.
vim.keymap.set("n", "<leader>fo", function()
  vim.ui.input(
    { prompt = "Find files in: ", default = vim.fn.expand("~") .. "/", completion = "dir" },
    function(input)
      if not input or input == "" then
        return
      end
      Snacks.picker.files({ cwd = vim.fn.expand(input), hidden = true })
    end
  )
end, { desc = "Find Files (Anywhere)" })
