return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "ldelossa/nvim-dap-projects",                -- dap config per project
    "theHamsta/nvim-dap-virtual-text",           -- displays variable value while debugging
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- for codelldb
  },
  config = function()
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

    dap.listeners.before.launch.dapui_config = open_dapui
    dap.listeners.before.event_terminated.dapui_config = close_dapui

    -- editor icons
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

    local function continue_debug()
      dap_projects.search_project_config()
      dap.continue()
    end

    -- debugging keymaps
    vim.keymap.set("n", "<F5>", continue_debug,
      { desc = "[F5] (debugging) Start/Continue", })

    vim.keymap.set("n", "<C-F5>", function()
        pcall(dap.terminate)
        dap_ui.close()
      end,
      { desc = "[Ctrl+F5] (debugging) Stop", })

    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint,
      { desc = "[F9] (debugging) Toggle breakpoint", })

    vim.keymap.set("n", "<F10>", dap.step_over,
      { desc = "[F10] (debugging) Step over", })

    vim.keymap.set("n", "<F11>", dap.step_into,
      { desc = "[F11] (debugging) Step into", })

    vim.keymap.set("n", "<F12>", dap.step_out,
      { desc = "[F12] (debugging) Step out", })

    -- plugin configs
    require("nvim-dap-virtual-text").setup({})
    require("dapui").setup({
      layouts = {
        {
          elements = {
            { id = "scopes",  size = 0.5, },
            -- { id = "breakpoints", size = 0.25, },
            { id = "watches", size = 0.5, },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "console", },
            -- { id = "repl", },
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
