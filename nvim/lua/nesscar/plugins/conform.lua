return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "biome" },
      javascriptreact = { "biome" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
      json = { "biome" },
      yaml = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      astro = { "prettier" },
      python = { "ruff_organize_imports", "ruff_format" },
      swift = { "swiftformat" },
    },
  },
}
