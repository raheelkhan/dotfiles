return {
  -- Mason: ensure extra tools are installed
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "bash-language-server",
      },
    },
  },

  -- Disable venv-selector (replaced by venv-lsp for auto-detection)
  { "linux-cultist/venv-selector.nvim", enabled = false },

  -- Auto-detect pyenv virtualenvs for Python LSP
  {
    "jglasovic/venv-lsp.nvim",
    event = "BufReadPre",
    config = function()
      require("venv-lsp").setup()
    end,
  },

  -- LSP: add bashls, configure ruby_lsp via rbenv
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
      },
    },
    init = function()
      -- Ruby LSP: Use rbenv shim (not Mason) so it respects .ruby-version
      vim.lsp.config.ruby_lsp = {
        cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
        filetypes = { "ruby", "eruby" },
        root_markers = { "Gemfile", ".git", ".ruby-version" },
      }
      vim.lsp.enable("ruby_lsp")
    end,
  },
}
