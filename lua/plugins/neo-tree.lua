return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
      'nvim-mini/mini.icons',
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
    },
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      { "<c-n>", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree (root dir)" },
    },
    opts = {
      window = {
        auto_expand_width = true,
        mappings = {
          ["/"] = "noop",
        },
      },
    },
  }
}

