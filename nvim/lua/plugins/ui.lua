return {
  -- Snacks: floating terminal + show hidden dotfiles in picker
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          position = "float",
          border = "rounded",
        },
      },
      picker = {
        sources = {
          files = { hidden = true },
        },
      },
    },
  },

  -- Bufferline customization
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
      },
      highlights = {
        buffer_selected = { italic = false },
      },
    },
  },

  -- Lualine with vscode theme
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "vscode",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    },
  },
}
