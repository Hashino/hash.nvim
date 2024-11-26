local dap = require("dap")

local codelldb = vim.fn.expand("$HOME/.local/share/nvim/mason/bin/codelldb")

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb,
    args = { "--port", "${port}", },
  },
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input({
        prompt = "Path to Debuggable Executable: ",
        default = vim.fn.getcwd() .. "/",
        completion = "file",
      })
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    runInTerminal = true,
    args = {},
  },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
