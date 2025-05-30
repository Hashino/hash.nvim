local Theme = {}

Theme.kinds = {
  Text          = "󰉿 ",
  Method        = "󰆧 ",
  Function      = "󰊕 ",
  Constructor   = " ",
  Field         = "󰜢 ",
  Variable      = "󰀫 ",
  Class         = "󰠱 ",
  Interface     = " ",
  Module        = " ",
  Property      = "󰜢 ",
  Unit          = "󰑭 ",
  Value         = "󰎠 ",
  Enum          = " ",
  Keyword       = "󰌋 ",
  Snippet       = " ",
  Color         = "󰏘 ",
  File          = "󰈙 ",
  Reference     = "󰈇 ",
  Folder        = "󰉋 ",
  EnumMember    = " ",
  Constant      = "󰏿 ",
  Struct        = "󰙅 ",
  Event         = " ",
  Operator      = "󰆕 ",
  TypeParameter = "",
}

Theme.colors = {}

-- updates a highlight group with the given colors
Theme.highlight = function(group, colors)
  require("onenord.util").highlight(group, colors)
end

Theme.plugin = {   -- Theme
  "rmehri01/onenord.nvim",
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    local colors = {
      fg           = "#C8D0E0",
      fg_light     = "#E5E9F0",
      bg           = "#2E3440",
      gray         = "#646A76",
      light_gray   = "#6C7A96",
      cyan         = "#88C0D0",
      blue         = "#81A1C1",
      dark_blue    = "#5E81AC",
      green        = "#A3BE8C",
      light_green  = "#8FBCBB",
      dark_red     = "#BF616A",
      red          = "#D57780",
      light_red    = "#DE878F",
      pink         = "#E85B7A",
      dark_pink    = "#E44675",
      orange       = "#D08F70",
      yellow       = "#EBCB8B",
      purple       = "#B988B0",
      light_purple = "#B48EAD",
      none         = "NONE",
    }

    require("onenord").setup({ custom_colors = colors, borders = false, })
    vim.cmd.colorscheme("onenord") -- Load the colorscheme here.

    Theme.colors = require("onenord.colors").load()
  end,
}

return Theme
