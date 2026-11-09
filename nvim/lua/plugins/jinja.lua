return {
  'Glench/Vim-Jinja2-Syntax',
  ft = {'html', 'htmldjango', 'jinja'},
  config = function()
    vim.filetype.add({
      extension = {
        jinja = 'htmldjango',
        jinja2 = 'htmldjango',
        j2 = 'htmldjango',
      },
    })
    vim.treesitter.language.register('html', 'htmldjango')
  end,
}
