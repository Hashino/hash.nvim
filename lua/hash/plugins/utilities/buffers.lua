return {
  {
    "Hashino/buffer_manager.nvim-40",
    dependecies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("buffer_manager").setup({
        short_file_names = "all",
        short_term_names = true,
        order_buffers = "lastused",
      })

      local bmui = require("buffer_manager.ui")

      -- Just the menu
      vim.keymap.set({ "n", }, "<tab>", bmui.toggle_quick_menu,
        { noremap = true, })

      -- Navigate buffers by index
      local keys = "123456789"
      for i = 1, #keys do
        local key = keys:sub(i, i)
        vim.keymap.set("n", string.format("<A-%s>", key), function()
            bmui.nav_file(i)
          end,
          {
            desc = "switch to " .. i .. "th buffer in history",
            noremap = true,
          }
        )
      end
    end,
  },
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup {
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
          local filename = vim.fn.fnamemodify(
            vim.api.nvim_buf_get_name(props.buf), ":t")
          return filename ~= vim.api.nvim_buf_get_name(0) and
             { " ", filename, " ", }
        end,
      }
    end,
  },
}
