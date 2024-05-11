return { -- auto save in normal mode
  'Pocco81/auto-save.nvim',
  config = function()
    require('auto-save').setup {
      -- your config goes here
      -- or just leave it empty :)
      trigger_events = { 'InsertLeave' },
    }
  end,
}
