return {
  -- Snacks: floating terminal (default changed to bottom in newer versions)
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          position = "float",
          border = "rounded",
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
