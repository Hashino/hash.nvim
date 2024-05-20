return { -- Auto-saves on exit insert mode
  'Pocco81/auto-save.nvim',
  dependencies = { 'j-hui/fidget.nvim' },
  config = function()
    local fidget = require 'fidget'

    fidget.notification.set_config('autosave', { name = '', icon = ''--[[ icon = '󱣪 '  ]]}, false)

    require('auto-save').setup {
      -- your config goes here
      -- or just leave it empty :)
      trigger_events = { 'InsertLeave' },
      condition = function(buf)
        local fn = vim.fn
        local utils = require 'auto-save.utils.data'

        if
          fn.getbufvar(buf, '&modifiable') == 1
          and utils.not_in(fn.getbufvar(buf, '&filetype'), {})
          and not string.find(fn.expand '%', '.git/COMMIT_EDITMSG') -- ignore git commit messages
        then
          return true -- met condition(s), can save
        end
        return false -- can't save
      end,
      execution_message = {
        message = function() -- message to print on save
          fidget.notify('Autosaved', nil, { key = 'autosave', group = 'autosave', skip_history = true })

          return ''
        end,
        dim = 0.18, -- dim the color of `message`
        cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      },
    }
  end,
}
