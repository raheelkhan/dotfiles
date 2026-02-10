-- Keymaps loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- ===========================
-- Remove conflicting LazyVim defaults
-- ===========================
-- LazyVim maps <leader>w to <C-w> (window prefix) — we want save
pcall(vim.keymap.del, "n", "<leader>w")
pcall(vim.keymap.del, "n", "<leader>wd")
pcall(vim.keymap.del, "n", "<leader>ww")
pcall(vim.keymap.del, "n", "<leader>w-")
pcall(vim.keymap.del, "n", "<leader>w|")
pcall(vim.keymap.del, "n", "<leader>wm")

-- ===========================
-- FIND (Telescope)
-- ===========================
-- <leader>ff and <leader>fb and <leader>fr already work in LazyVim
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find in files (grep)", silent = true })
map("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor", silent = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help", silent = true })

-- ===========================
-- BUFFERS (Tabs)
-- ===========================
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer", silent = true })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer", silent = true })
map("n", "<leader>X", "<cmd>bdelete!<cr>", { desc = "Force close buffer", silent = true })
-- Jump to buffer by number
for i = 1, 9 do
  map("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<cr>", { desc = "Go to buffer " .. i, silent = true })
end

-- ===========================
-- FILE OPERATIONS
-- ===========================
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file", silent = true })
map("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all files", silent = true })
map("n", "<leader>q", function() Snacks.bufdelete() end, { desc = "Close buffer", silent = true })
map("n", "<leader>wq", function() vim.cmd("w"); Snacks.bufdelete() end, { desc = "Save and close buffer", silent = true })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all", silent = true })
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New file", silent = true })

-- ===========================
-- EDITING
-- ===========================
map("n", "U", "<C-r>", { desc = "Redo", silent = true })

-- Move lines (Alt+j/k) — already provided by LazyVim

-- Duplicate line (Alt+Shift+j/k)
map("n", "<A-S-j>", "<cmd>t.<cr>", { desc = "Duplicate line down", silent = true })
map("n", "<A-S-k>", "<cmd>t.-1<cr>", { desc = "Duplicate line up", silent = true })

-- Comment toggle (supplements LazyVim's gcc/gc)
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Better indenting — already provided by LazyVim

-- Select all
map("n", "<leader>a", "ggVG", { desc = "Select all", silent = true })

-- ===========================
-- SEARCH
-- ===========================
-- <Esc> to clear search — already provided by LazyVim
map("n", "<leader>sr", ":%s/", { desc = "Search and replace" })

-- ===========================
-- WINDOWS
-- ===========================
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical", silent = true })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal", silent = true })
map("n", "<leader>sc", "<cmd>close<cr>", { desc = "Close split", silent = true })
map("n", "<leader>so", "<cmd>only<cr>", { desc = "Close other splits", silent = true })

-- Window navigation (Ctrl+hjkl) — already provided by LazyVim
-- Window resize (Ctrl+arrows) — already provided by LazyVim

-- ===========================
-- GIT (via gitsigns)
-- ===========================
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk", silent = true })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk", silent = true })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line", silent = true })
map("n", "]g", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next git hunk", silent = true })
map("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous git hunk", silent = true })

-- ===========================
-- LSP
-- ===========================
-- gd, gr, K, <leader>ca — already provided by LazyVim
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol", silent = true })
map("n", "<leader>d", function() vim.diagnostic.open_float({ border = "rounded" }) end, { desc = "Show diagnostic", silent = true })
map("i", "<C-k>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, { desc = "Signature help", silent = true })

-- ===========================
-- QUICKFIX
-- ===========================
-- ]q / [q — already provided by LazyVim
map("n", "<leader>cc", "<cmd>cclose<cr>", { desc = "Close quickfix", silent = true })

-- Terminal: LazyVim defaults only
