-- ===========================
-- NEOVIM VSCODE-LIKE SETUP
-- Custom config by Raheel
-- ===========================

-- Set leader key before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ===========================
-- BASIC OPTIONS
-- ===========================
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 8
-- Use system clipboard (works on macOS, Linux, WSL)
vim.opt.clipboard = "unnamedplus"
-- For macOS, also sync with unnamed register
vim.opt.clipboard:append("unnamed")
vim.opt.undofile = true
vim.opt.wrap = false

-- ===========================
-- FORMAT ON SAVE
-- ===========================
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- ===========================
-- SMART QUIT (close file, keep nvim open)
-- ===========================
-- Close buffer without closing window
vim.api.nvim_create_user_command("Q", function()
  local ft = vim.bo.filetype
  if ft == "NvimTree" or ft == "toggleterm" then return end

  local current = vim.fn.bufnr("%")

  -- Switch to next buffer first, then delete current
  vim.cmd("bnext")

  -- If we're still on the same buffer (only one buffer), create empty
  if vim.fn.bufnr("%") == current then
    vim.cmd("enew")
  end

  -- Now delete the original buffer
  vim.cmd("bdelete " .. current)
end, {})

-- ===========================
-- BOOTSTRAP LAZY.NVIM
-- ===========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ===========================
-- PLUGINS
-- ===========================
require("lazy").setup({
  -- VSCode Dark Theme
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      require("vscode").setup({
        style = "dark",
        transparent = false,
      })
      vim.cmd.colorscheme("vscode")
    end,
  },

  -- File icons
  { "nvim-tree/nvim-web-devicons" },

  -- File Explorer (always visible like VSCode)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = {
          width = 35,
          side = "left",
        },
        renderer = {
          group_empty = true,
          root_folder_label = function(path)
            return string.upper(vim.fn.fnamemodify(path, ":t"))
          end,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = false,
            window_picker = {
              enable = false,  -- Open in the last focused window
            },
          },
        },
        tab = {
          sync = {
            open = true,
            close = true,
          },
        },
      })

    end,
  },

  -- Bufferline (tabs like VSCode)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "thin",
          always_show_bufferline = true,
          show_buffer_close_icons = true,
          show_close_icon = false,
          color_icons = true,
          diagnostics = "nvim_lsp",
          -- Hide unnamed/empty buffers and directories from tabline
          custom_filter = function(buf_number)
            local name = vim.fn.bufname(buf_number)
            -- Hide empty buffers
            if name == "" then
              return false
            end
            -- Hide directory buffers
            if vim.fn.isdirectory(name) == 1 then
              return false
            end
            return true
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
        },
        -- Disable italics for buffer names
        highlights = {
          buffer_selected = { italic = false, bold = true },
          buffer_visible = { italic = false },
          buffer = { italic = false },
          diagnostic = { italic = false },
          diagnostic_visible = { italic = false },
          diagnostic_selected = { italic = false },
          hint = { italic = false },
          hint_visible = { italic = false },
          hint_selected = { italic = false },
          info = { italic = false },
          info_visible = { italic = false },
          info_selected = { italic = false },
          warning = { italic = false },
          warning_visible = { italic = false },
          warning_selected = { italic = false },
          error = { italic = false },
          error_visible = { italic = false },
          error_selected = { italic = false },
          duplicate = { italic = false },
          duplicate_selected = { italic = false },
          duplicate_visible = { italic = false },
        },
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "vscode",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
      })
    end,
  },

  -- Fuzzy finder (Ctrl+P like VSCode)
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" },
        },
      })
    end,
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- LSP: Mason auto-installs servers, nvim-lspconfig configures them
  -- To add a new language: add server name to ensure_installed list, restart nvim
  -- Find server names at: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Add/remove servers here as needed:
          "ts_ls",          -- TypeScript/JavaScript
          "pyright",        -- Python
          -- ruby_lsp: installed via rbenv gem, configured below (not Mason)
          "bashls",         -- Bash
          "jsonls",         -- JSON
          "yamlls",         -- YAML
          "lua_ls",         -- Lua
        },
        automatic_installation = true,
        handlers = {
          -- Default: auto-setup all servers
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          -- Custom: lua_ls needs to know about vim global
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              settings = { Lua = { diagnostics = { globals = { "vim" } } } },
            })
          end,
          },
      })

      -- Ruby LSP: Use rbenv shim (not Mason) so it respects .ruby-version
      -- Using native vim.lsp.config (Neovim 0.11+)
      vim.lsp.config.ruby_lsp = {
        cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
        filetypes = { "ruby", "eruby" },
        root_markers = { "Gemfile", ".git", ".ruby-version" },
      }
      vim.lsp.enable("ruby_lsp")
    end,
  },
  { "neovim/nvim-lspconfig" },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Auto-detect indentation (tabs vs spaces) from file
  { "tpope/vim-sleuth" },

  -- Terminal (toggle with Ctrl+`)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<C-`>]],
        direction = "horizontal",
        shade_terminals = true,
        start_in_insert = true,
      })

      -- Space+t to toggle terminal
      vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
    end,
  },

  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = { enabled = true },
      })
    end,
  },

  -- Comment toggle (gcc)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Which key (shows keybindings)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({})
    end,
  },

})


-- ===========================
-- KEYMAPS (Cross-platform)
-- ===========================
-- Leader = Space (works everywhere)
-- Ctrl = works in terminal on all OS
-- Alt = Option on Mac, Alt on Windows/Linux

-- Helper: silent keymaps (won't show command in cmdline)
local function keymap(mode, key, cmd, opts)
  opts = opts or {}
  opts.silent = true
  opts.noremap = true
  vim.keymap.set(mode, key, cmd, opts)
end

-- ===========================
-- FILE EXPLORER
-- ===========================
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle explorer" })
keymap("n", "<leader>o", ":NvimTreeFocus<CR>", { desc = "Focus explorer" })

-- ===========================
-- FIND (Telescope)
-- ===========================
keymap("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Find in files (grep)" })
keymap("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Find help" })
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Find recent files" })
keymap("n", "<leader>fw", ":Telescope grep_string<CR>", { desc = "Find word under cursor" })

-- ===========================
-- BUFFERS (Tabs)
-- ===========================
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>X", ":bdelete!<CR>", { desc = "Force close buffer" })
-- Jump to buffer by number
for i = 1, 9 do
  keymap("n", "<leader>" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Go to buffer " .. i })
end

-- ===========================
-- FILE OPERATIONS
-- ===========================
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>W", ":wa<CR>", { desc = "Save all files" })
keymap("n", "<leader>q", ":Q<CR>", { desc = "Close buffer (smart quit)" })
keymap("n", "<leader>Q", ":qa<CR>", { desc = "Quit all" })
keymap("n", "<leader>n", ":enew<CR>", { desc = "New file" })

-- ===========================
-- EDITING
-- ===========================
-- Undo/Redo (standard vim: u and Ctrl+r)
keymap("n", "U", "<C-r>", { desc = "Redo" })

-- Move lines up/down (Alt+j/k)
keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Duplicate line (Alt+Shift+j/k)
keymap("n", "<A-S-j>", ":t.<CR>", { desc = "Duplicate line down" })
keymap("n", "<A-S-k>", ":t.-1<CR>", { desc = "Duplicate line up" })

-- Comment toggle (gcc for line, gc for selection - from Comment.nvim)
keymap("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
keymap("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Better indenting (stay in visual mode)
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Select all
keymap("n", "<leader>a", "ggVG", { desc = "Select all" })

-- ===========================
-- SEARCH
-- ===========================
keymap("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight" })
keymap("n", "<leader>sr", ":%s/", { desc = "Search and replace" })

-- ===========================
-- WINDOWS
-- ===========================
keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertical" })
keymap("n", "<leader>sh", ":split<CR>", { desc = "Split horizontal" })
keymap("n", "<leader>sc", ":close<CR>", { desc = "Close split" })
keymap("n", "<leader>so", ":only<CR>", { desc = "Close other splits" })

-- Window navigation (Ctrl+hjkl)
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })

-- Resize windows (Ctrl+arrows)
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- ===========================
-- GIT (via gitsigns)
-- ===========================
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
keymap("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Blame line" })
keymap("n", "]g", ":Gitsigns next_hunk<CR>", { desc = "Next git hunk" })
keymap("n", "[g", ":Gitsigns prev_hunk<CR>", { desc = "Previous git hunk" })

-- ===========================
-- LSP
-- ===========================
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover info" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
keymap("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- ===========================
-- QUICKFIX
-- ===========================
keymap("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
keymap("n", "[q", ":cprev<CR>", { desc = "Prev quickfix" })
keymap("n", "<leader>cc", ":cclose<CR>", { desc = "Close quickfix" })

-- ===========================
-- TERMINAL
-- ===========================
keymap("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

