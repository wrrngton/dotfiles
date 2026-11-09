vim.opt.expandtab = true
vim.cmd("syntax enable")
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 8
vim.opt.wrap = true
vim.opt.mouse = "a"
vim.opt.updatetime = 250
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>fc", "zc", { desc = "Fold code block" })
vim.keymap.set("n", "<leader>fo", "zo", { desc = "Open code fold" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

local trim_group = vim.api.nvim_create_augroup("trim_trailing_whitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = trim_group,
  callback = function()
    -- Markdown uses trailing spaces for hard line breaks.
    if vim.bo.filetype == "markdown" then
      return
    end
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Code folding with treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99  -- Start with all folds open
vim.opt.foldlevelstart = 99
