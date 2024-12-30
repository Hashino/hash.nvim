return {
  "rcarriga/nvim-dap-ui",

  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",           -- displays values while debugging
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- for codelldb

    -- add .nvim/nvim-dap.lua file to project rooot to override
    -- adapter and configurations
    "ldelossa/nvim-dap-projects",
  },

  config = function()
    vim.fn.sign_define("DapStopped",
      { text = "", texthl = "String", })

    vim.fn.sign_define("DapBreakpoint",
      { text = "", texthl = "ErrorMsg", })

    vim.fn.sign_define("DapBreakpointCondition",
      { text = "", texthl = "ErrorMsg", })

    vim.fn.sign_define("DapBreakpointRejected",
      { text = "", texthl = "ErrorMsg", })

    vim.fn.sign_define("DapLogPoint",
      { text = "", texthl = "Type", })

    require("hash.plugins.debugging.adapters.gdb")

    local dap = require("dap")
    local dap_ui = require("dapui")
    local dap_projects = require("nvim-dap-projects")
    local dap_virtual_text = require("nvim-dap-virtual-text")

    local open_dapui = function()
      dap_virtual_text.enable()
      dap_ui.open()
    end

    local close_dapui = function()
      dap_virtual_text.disable()
      dap_ui.close()
    end

    local function continue_debug()
      local status = dap.status()
      if status == "" or status == "All threads stopped" then
        dap_projects.search_project_config()
      end

      dap.continue()
    end

    local function stop_debugging()
      pcall(dap.terminate)
      -- when the debugger crashes, it doesn't call the event_terminated listener
      -- so we need to manually close the dapui
      close_dapui()
    end

    dap.listeners.before.event_initialized.dapui_config = open_dapui
    dap.listeners.before.event_terminated.dapui_config = close_dapui
    dap.listeners.before.event_exited.dapui_config = close_dapui

    vim.keymap.set("n", "<F5>", continue_debug,
      { desc = "[F5] (debugging) Start/Continue", })

    vim.keymap.set("n", "<C-F5>", stop_debugging,
      { desc = "[Ctrl+F5] (debugging) Stop", })

    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint,
      { desc = "[F9] (debugging) Toggle breakpoint", })

    vim.keymap.set("n", "<F10>", dap.step_over,
      { desc = "[F10] (debugging) Step over", })

    vim.keymap.set("n", "<F11>", dap.step_into,
      { desc = "[F11] (debugging) Step into", })

    vim.keymap.set("n", "<F12>", dap.step_out,
      { desc = "[F12] (debugging) Step out", })

    require("nvim-dap-virtual-text").setup({})
    require("dapui").setup({
      layouts = {
        {
          elements = {
            { id = "scopes",  size = 0.5, },
            { id = "watches", size = 0.5, },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "console", },
          },
          position = "bottom",
          size = 15,
        },
      },
      mappings = {
        edit = "e",
        expand = " ",
        open = "o",
        remove = "d",
        toggle = "t",
      },
    })
  end,
}
