return
  {
  {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
   dependencies = { 'nvim-lua/plenary.nvim' },
   config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', function()
        builtin.find_files({ case_mode = 'ignore_case' })
      end, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', function()
        builtin.live_grep({
          additional_args = { '--ignore-case' },
          case_mode = 'ignore_case',
        })
      end, { desc = 'Telescope live grep' })
  end
  },
  {
  "nvim-telescope/telescope-ui-select.nvim",
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
     defaults = {
      -- Telescope 0.1.8 uses Treesitter APIs removed on its main branch.
      preview = { treesitter = false },
      mappings = {
        i = {
          ["<ScrollWheelDown>"] = actions.preview_scrolling_down,
          ["<ScrollWheelUp>"] = actions.preview_scrolling_up,
        },
        n = {
          ["<ScrollWheelDown>"] = actions.preview_scrolling_down,
          ["<ScrollWheelUp>"] = actions.preview_scrolling_up,
        },
      },
     },
     extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {}
            }
          } 
        })
      require("telescope").load_extension("ui-select")
  end
  }
}
