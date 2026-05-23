vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main", },
  "https://github.com/Yggdroot/hiPairs",
}, { confirm = false, })

require("nvim-treesitter").setup()

require("nvim-treesitter").install({
  "lua",
  "c",
  "rust",
  "bash",
  "html",
  "regex",
  "markdown",
  "markdown_inline",
  "vim",
  "vimdoc",
  "latex",
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    local parsers = require("nvim-treesitter.parsers")
    local lang = vim.treesitter.language.get_lang(args.match)

    -- checks if the parser is available and not installed, then install it
    if lang and parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
      vim.schedule(function()
        vim.cmd("TSInstall " .. lang)
      end)
    end
  end,
})

vim.g.hiPairs_hl_matchPair = { term = "bold", gui = "bold", }
vim.g.hiPairs_hl_unmatchPair = { term = "NONE", gui = "NONE", }
