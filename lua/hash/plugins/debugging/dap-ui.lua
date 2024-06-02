return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local dap_projects = require 'nvim-dap-projects'

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end

    vim.fn.sign_define('DapStopped', { text = '', texthl = 'String', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })

    vim.keymap.set('n', '<F5>', function()
      require('nvim-tree.api').tree.close()
      dap_projects.search_project_config()
      -- dap.continue()
    end, { desc = '[F5] Start/Continue running' })

    vim.keymap.set('n', '<C-F5>', function()
      dap.close()
      dapui.close()
    end, { desc = '[F5] Stop debuging' })

    vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = '[F9] Toggle breakpoint' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = '[F10] Step over' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = '[F11] Step into' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = '[F12] Step out' })

    require('dapui').setup {
      controls = {
        element = 'repl',
        enabled = true,
        icons = {
          disconnect = '',
          pause = '',
          play = '',
          run_last = '',
          step_back = '',
          step_into = '',
          step_out = '',
          step_over = '',
          terminate = '',
        },
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      force_buffers = true,
      icons = {
        collapsed = '',
        current_frame = '',
        expanded = '',
      },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.25,
            },
            {
              id = 'breakpoints',
              size = 0.25,
            },
            {
              id = 'stacks',
              size = 0.25,
            },
            {
              id = 'watches',
              size = 0.25,
            },
          },
          position = 'left',
          size = 40,
        },
        {
          elements = { {
            id = 'repl',
            size = 0.5,
          }, {
            id = 'console',
            size = 0.5,
          } },
          position = 'bottom',
          size = 10,
        },
      },
      mappings = {
        edit = 'e',
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        repl = 'r',
        toggle = 't',
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    }
  end,
}
