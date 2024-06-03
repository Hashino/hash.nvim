local function doing()
  local view = require('doing').view 'active'

  if view.left ~= '' then
    local res = '' .. view.left -- .. view.middle

    if view.right ~= '' then
      res = res .. '  ' .. view.right
    end

    return res .. ''
  end

  return ''
end

local _ = {
  fg           = '#C8D0E0',
  fg_light     = '#E5E9F0',
  bg           = '#2E3440',
  gray         = '#646A76',
  light_gray   = '#6C7A96',
  cyan         = '#88C0D0',
  blue         = '#81A1C1',
  dark_blue    = '#5E81AC',
  green        = '#A3BE8C',
  light_green  = '#8FBCBB',
  dark_red     = '#BF616A',
  red          = '#D57780',
  light_red    = '#DE878F',
  pink         = '#E85B7A',
  dark_pink    = '#E44675',
  orange       = '#D08F70',
  yellow       = '#EBCB8B',
  purple       = '#B988B0',
  light_purple = '#B48EAD',
  none         = 'NONE',
}

return {
  'b0o/incline.nvim',
  dependencies = { 'rmehri01/onenord.nvim' },
  lazy = false,
  config = function()
    -- local colors = require("onenord.colors").load()
    -- local bg_color = colors.blue

    require('incline').setup {
      window = {
        placement = {
          horizontal = "right",
          vertical = "top"
        },
        width = "fit",
        padding = 0,
        margin = {
          horizontal = 0,
          vertical = 0,
        },
        overlap = {
          winbar = true
        },
      },
      render = function()
        return {
          doing()
          -- { doing(), guifg = '#001122' }, guibg = bg_color,
        }
      end,
    }
  end
}
