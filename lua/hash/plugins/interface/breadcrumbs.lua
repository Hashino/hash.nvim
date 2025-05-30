return {
  {
    "Bekaboo/dropbar.nvim",
    config = function()
      vim.g.dropbar_enabled = false

      require("dropbar").setup({
        bar = {
          enable = function(buf, win, _)
            if
               not vim.g.dropbar_enabled
               or not vim.api.nvim_buf_is_valid(buf)
               or not vim.api.nvim_win_is_valid(win)
               or vim.fn.win_gettype(win) ~= ""
               or vim.wo[win].winbar ~= ""
               or vim.bo[buf].ft == "help"
            then
              return false
            end

            local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
            if stat and stat.size > 1024 * 1024 then
              return false
            end

            return vim.bo[buf].ft == "markdown"
               or pcall(vim.treesitter.get_parser, buf)
               or not vim.tbl_isempty(vim.lsp.get_clients({
                 bufnr = buf,
                 method = "textDocument/documentSymbol",
               }))
          end,

          sources = function(buf, _)
            local sources = require("dropbar.sources")
            local utils = require("dropbar.utils")
            if vim.bo[buf].ft == "markdown" then
              return { sources.markdown, }
            end
            return {
              utils.source.fallback({
                sources.lsp,
                sources.treesitter,
              }),
            }
          end,
        },

        icons = {
          kinds = {
            symbols = require("hash.theme").kinds,
          },
          ui = {
            bar = {
              separator = " ",
              extends = "…",
            },
          },
        },
      })

      vim.keymap.set("n", "<Leader>B", function()
        vim.g.dropbar_enabled = not vim.g.dropbar_enabled
        if not vim.g.dropbar_enabled then
          vim.o.winbar = ""
        end
        vim.cmd [[ edit ]]
      end, { desc = "Toggle [B]readcrumbs", })
    end,
  },
}
