return {
  "hashino/nvim-dap-ui-405",
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

    dap.listeners.before.attach.dapui_config = require("no-neck-pain").disable

    dap.listeners.before.launch.dapui_config = function()
      dap_virtual_text.enable()
      dap_ui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
      require("no-neck-pain").enable()
      dap_ui.close()
      dap_virtual_text.disable()
    end

    -- editor icons
    vim.fn.sign_define("DapStopped", { text = "", texthl = "String", })
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg", })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "ErrorMsg", })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "ErrorMsg", })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "Type", })

    local function continue_debug()
      dap_projects.search_project_config()
      dap.continue()
    end

    -- debugging keymaps
    vim.keymap.set("n", "<F5>", continue_debug, { desc = "[F5] Start/Continue debuging", })
    vim.keymap.set("n", "<C-F5>", dap.terminate, { desc = "[Ctrl+F5] Stop debuging", })
    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "[F9] Toggle breakpoint", })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "[F10] Step over", })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "[F11] Step into", })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "[F12] Step out", })

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
