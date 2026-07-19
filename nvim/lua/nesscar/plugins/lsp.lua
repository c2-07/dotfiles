return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      local on_attach = function(client, bufnr)
        -- Allow LSPs to format
      end

      -- handled by noice
      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      --   border = "rounded",
      -- })

      local function get_tsdk(root_dir)
        local local_tsdk = root_dir .. "/node_modules/typescript/lib"

        if vim.uv.fs_stat(local_tsdk .. "/typescript.js") then
          return local_tsdk
        end

        return vim.fn.system("npm root -g"):gsub("%s+$", "") .. "/typescript/lib"
      end

      vim.lsp.config.vtsls = {
        on_attach = on_attach,
        capabilities = capabilities,

        before_init = function(_, config)
          config.init_options = config.init_options or {}
          config.init_options.typescript = {
            tsdk = get_tsdk(config.root_dir),
          }
        end,
      }

      vim.lsp.config.lua_ls = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      }
      vim.lsp.config.clangd = {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "clangd", "--clang-tidy" },
      }
      vim.lsp.config.cssls = { on_attach = on_attach, capabilities = capabilities }
      vim.lsp.config.astro = { on_attach = on_attach, capabilities = capabilities }
      vim.lsp.config.ruff = {
        on_attach = on_attach,
        capabilities = capabilities,
      }
      vim.lsp.config.ty = {
        on_attach = on_attach,
        capabilities = capabilities,
      }
      vim.lsp.config.biome = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      vim.lsp.enable({
        "ruff",
        "vtsls",
        "lua_ls",
        "clangd",
        "ty",
        "cssls",
        "astro",
        "biome",
      })
    end,
  },
}
