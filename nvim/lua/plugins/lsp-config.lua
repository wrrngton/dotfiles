return {
  {
  "williamboman/mason.nvim",
  config = function() 
    require("mason").setup()
  end
  },
  {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pylsp", "ts_ls", "cssls", "intelephense", "jsonls", "tailwindcss" }
      })
  end
  },
  {
  "jay-babu/mason-null-ls.nvim",
  dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = {
        "stylua", "black", "isort", "prettier",
        "pylint", "stylelint", "staticcheck", "djlint",
      },
      automatic_installation = false,
    })
  end
  },
  {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
  },
  config = function()
    local lspconfig = require("lspconfig")

    -- Add nvim-cmp capabilities
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- List your language servers
    local servers = {
      lua_ls = {},
      pylsp = {
        settings = { pylsp = { plugins = { jedi = {} } } },
        on_new_config = function(config, root_dir)
          for _, venv_dir in ipairs({ ".venv", "venv" }) do
            local python = root_dir .. "/" .. venv_dir .. "/bin/python"
            if vim.fn.executable(python) == 1 then
              config.settings.pylsp.plugins.jedi.environment = python
              return
            end
          end
        end,
      },
      ts_ls = {}, gopls = {}, cssls = {}, intelephense = {}, jsonls = {},
    }

    for name, config in pairs(servers) do
      config.capabilities = capabilities
      lspconfig[name].setup(config)
    end

    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      filetypes = {
        'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html', 'htmldjango',
        'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars',
        'hbs', 'html', 'htmlangular', 'html-eex', 'heex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx',
        'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', 'css', 'less', 'postcss', 'sass',
        'scss', 'stylus', 'sugarss', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript',
        'typescriptreact', 'vue', 'svelte', 'templ', 'jinja.html',
      },
      settings = {
        tailwindCSS = {
          includeLanguages = { ['jinja.html'] = 'html' },
        },
      },
    })

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    vim.o.updatetime = 250
    vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]
  end
  },
}

