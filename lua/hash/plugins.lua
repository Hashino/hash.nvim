local function import(dir)
  local config_dir = vim.fn.stdpath("config") .. "/lua/" .. dir:gsub("%.", "/")
  local handle = vim.uv.fs_opendir(config_dir)

  if handle then
    repeat
      -- iterates to next entry in directory
      local file = vim.uv.fs_readdir(handle)
      -- if file is not nil and is a .lua file, require it
      if file and file[1].name:find(".lua") then
        -- strip .lua extension from filename
        local filename = file[1].name:gsub("%.lua$", "")
        require(dir .. "." .. filename)
      end
    until not file

    vim.uv.fs_closedir(handle)
  end
end

require("hash.plugins.theme")

-- INFO: library dependencies
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
}, { confirm = false, })

import("hash.plugins.editing")
import("hash.plugins.utilities")
import("hash.plugins.interface")
import("hash.plugins.debugging")
