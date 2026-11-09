return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")
    local languages = {
      "go",
      "html",
      "javascript",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
    }

    treesitter.install(languages)

    local group = vim.api.nvim_create_augroup("treesitter_config", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(event)
        local language = vim.treesitter.language.get_lang(event.match)
        if language and vim.list_contains(treesitter.get_installed(), language) then
          vim.treesitter.start(event.buf, language)
        end
      end,
    })
  end,
}
