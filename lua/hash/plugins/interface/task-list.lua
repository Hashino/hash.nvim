local function doing()
  local view = require('doing').view 'active'
  if view.left ~= '' then
    local res = '' .. view.left -- .. view.middle
    if view.right ~= '' then
      res = res .. '   ' .. view.right
    end
    return res .. ''
  end
  return ''
end

return { -- incline and doing
  {
    'b0o/incline.nvim',
    dependencies = {
      {
        'hashino/doing.nvim',
        branch = 'idk',
        opts = {},
        config = function()
          require('doing').setup {
            message_timeout = 2000,
            doing_prefix = 'Doing: ',

            winbar = {
              enabled = false,
              ignored_buffers = { 'NvimTree', 'trouble' },
            },

            store = {
              auto_create_file = false,
              file_name = '.tasks',
            },
          }
          vim.keymap.set('n', '<leader>de', require('doing.core').edit,
            { desc = '[E]dit what tasks you`re [D]oing' })
          vim.keymap.set('n', '<leader>dn', require('doing.core').done,
            { desc = '[D]o[n]e with current task' })
        end,
      }
    },
    config = function()
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
          }
        end,
      }
    end
  }
}
