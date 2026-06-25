return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "ts_ls",
      "html",
      "clangd",
      "rust_analyzer",
      "ruff",
      "lua_ls",
      "ty",
      "cssls",
      "astro",
    },
  },
}
