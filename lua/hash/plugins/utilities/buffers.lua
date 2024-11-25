return {
  "Hashino/buffer_manager.nvim-40",
  dependecies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("buffer_manager").setup({
      select_menu_item_commands = {
        v = { key = "<C-v>", command = "vsplit", },
        h = { key = "<C-h>", command = "split", },
      },
      focus_alternate_buffer = false,
      short_file_names = "all",
      short_term_names = true,
      loop_nav = false,
      order_buffers = "lastused",
    })

    local bmui = require("buffer_manager.ui")

    -- Just the menu
    vim.keymap.set({ "n", }, "<tab>", bmui.toggle_quick_menu, { noremap = true, })

    -- Navigate buffers by index
    local keys = "123456789"
    for i = 1, #keys do
      local key = keys:sub(i, i)
      vim.keymap.set("n", string.format("<A-%s>", key), function()
        bmui.nav_file(i)
      end, { noremap = true, }
      )
    end
  end,
}
