return { -- Auto-saves on exit insert mode
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({
      -- your config goes here
      -- or just leave it empty :)
      trigger_events = { "InsertLeave", },
      condition = function(buf)
        return vim.fn.getbufvar(buf, "&modifiable") == 1
           and vim.fn.getbufvar(buf, "&filetype") ~= "octo"
           and not string.find(vim.fn.expand("%"), ".git/COMMIT_EDITMSG")
      end,

      execution_message = {
        message = function()
          return "󰆓 Autosaved"
        end,
      },
    })
  end,
}
