return { -- Auto-saves on exit insert mode
  'Pocco81/auto-save.nvim',
  config = function()
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
    }
  end,
}
