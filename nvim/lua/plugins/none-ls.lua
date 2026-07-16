return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.djlint.with({
          filetypes = { "htmldjango", "jinja" },
        }),
        null_ls.builtins.diagnostics.pylint.with({
          env = function(params)
            local sp = vim.fn.glob(params.cwd .. "/.venv/lib/python*/site-packages", false, true)
            if #sp > 0 then
              return { PYTHONPATH = sp[1] }
            end
          end,
        }),
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.staticcheck
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

