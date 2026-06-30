return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "clangd",
      "biome",
      "rust_analyzer",
      "ruff",
      "lua_ls",
      "ty",
      "html",
      "cssls",
      "astro",
      "vtsls",
    },
  },
}
