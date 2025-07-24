return {
  {
    "j-morano/buffer_manager.nvim",
    dependecies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("buffer_manager").setup {
        order_buffers = "lastused",
      }
      local keys = "123456789"

      for i = 1, #keys do
        local key = string.sub(keys, i, i)
        vim.keymap.set("n", string.format("<A-%s>", key), function()
          require("buffer_manager.ui").nav_file(i)
        end, { noremap = true, })
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
