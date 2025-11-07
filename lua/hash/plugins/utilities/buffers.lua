vim.pack.add({
  "https://github.com/j-morano/buffer_manager.nvim",
  "https://github.com/b0o/incline.nvim",
}, { confirm = false, })


require("buffer_manager").setup({
  order_buffers = "lastused",
})

local bui = require("buffer_manager.ui")

vim.keymap.set("n", "<leader>b", bui.toggle_quick_menu,
  { noremap = true, desc = "Open [B]uffer Manager", })

local keys = "123456789"

for i = 1, #keys do
  local key = keys:sub(i, i)
  vim.keymap.set("n", string.format("<A-%s>", key), function()
    bui.nav_file(i)
  end, { noremap = true, })
end

require("incline").setup({
  hide = {
    focused_win = true,
    only_win = true,
  },
  window = {
    margin = {
      horizontal = 0,
      vertical = 0,
    },
    placement = {
      horizontal = "right",
      vertical = "bottom",
    },
  },
  render = function(props)
    local filename =
       vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    return filename ~= vim.api.nvim_buf_get_name(0)
       and { " ", filename, " ", }
  end,
})
