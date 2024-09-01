return {
  'Bekaboo/dropbar.nvim',
  config = function()
    require 'dropbar'.setup {
      sources = {
        path = {
          relative_to = function()
            return vim.api.nvim_buf_get_name(0)
          end
        }
      }
    }
  end
}
