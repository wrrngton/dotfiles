return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Use Neovim's filetype commentstring instead of Comment.nvim's Treesitter lookup.
    pre_hook = function()
      return vim.bo.commentstring
    end,
  },
}
