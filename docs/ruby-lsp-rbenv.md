# Ruby LSP with rbenv

## Problem
Ruby LSP doesn't respect `.ruby-version` when started from Neovim via Mason.

## Solution
Use rbenv shim directly in Neovim 0.11+ native LSP config:

```lua
vim.lsp.config.ruby_lsp = {
  cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
  filetypes = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".git", ".ruby-version" },
}
vim.lsp.enable("ruby_lsp")
```

## Requirements
1. Install ruby-lsp gem for each Ruby version:
   ```bash
   RBENV_VERSION=3.2.0 gem install ruby-lsp
   ```
2. Remove Mason's ruby-lsp:
   ```bash
   rm -rf ~/.local/share/nvim/mason/packages/ruby-lsp
   ```

## Why Mason Doesn't Work
- Mason prepends its bin to PATH
- Mason's ruby-lsp uses Ruby version active at install time
- rbenv shims read `.ruby-version` from project root automatically
