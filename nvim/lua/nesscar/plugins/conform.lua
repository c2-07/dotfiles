return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype

      local allowed = {
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        json = true,
        yaml = true,
        html = true,
        css = true,
        markdown = true,
        lua = true,
        astro = true,
        python = true,
      }

      if allowed[ft] then
        return {
          timeout_ms = 500,
          lsp_format = "never",
        }
      end
    end,

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
      python = { "ruff_format" },
    },
  },
}
