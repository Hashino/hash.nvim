return { -- Auto-saves on exit insert mode
  "Pocco81/auto-save.nvim",
  dependencies = { "j-hui/fidget.nvim", },
  config = function()
    local fidget = require("fidget")

    fidget.notification.set_config("autosave", { name = "", icon = "", }, false)

    require("auto-save").setup({
      -- your config goes here
      -- or just leave it empty :)
      trigger_events = { "InsertLeave", },
      condition = function(buf)
        local utils = require("auto-save.utils.data")

        return vim.fn.getbufvar(buf, "&modifiable") == 1
           and vim.fn.getbufvar(buf, "&filetype") ~= "octo"
           and not string.find(vim.fn.expand("%"), ".git/COMMIT_EDITMSG")
      end,
      execution_message = {
        message = function() -- message to print on save
          fidget.notify(
            "Autosaved",
            nil,
            { key = "autosave", group = "autosave", skip_history = true, }
          )

          return ""
        end,
        dim = 0.18,
        cleaning_interval = 1250,
      },
    })
  end,
}
