-- gets the current active lsp client of the buffer
local clients_lsp = function()
  local clients = vim.lsp.get_clients({ bufnr = 0, })
  if next(clients) == nil then
    return ""
  end

  local c = {}
  for _, client in pairs(clients) do
    table.insert(c, client.name)
  end
  return " " .. table.concat(c, "|")
end

-- gets the workspace git repository name and branch
local function git_repo()
  if vim.fn.system("git remote") == "" then
    return "[local repository]"
  end

  local git_repo_name = vim.fn.system("basename $(git remote get-url origin) | tr -d '\n'")
  local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")

  if branch ~= "" then
    return "[" .. git_repo_name .. "/" .. branch .. "]"
  else
    return ""
  end
end

local macro_recording = function()
  if vim.fn.reg_recording() ~= "" then
    return "@" .. vim.fn.reg_recording()
  else
    return ""
  end
end

return { -- Simple status line in lua
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/trouble.nvim", },
  init = function()
    local lualine_sections = {
      lualine_a = { macro_recording, },
      lualine_b = { git_repo, "diff", },
      lualine_c = { "diagnostics", require("doing.api").status, },
      -- right side
      lualine_x = { { "filename", path = 1, }, },
      lualine_y = { clients_lsp, { "filetype", icon_only = true, }, },
      lualine_z = { "location", },
    }

    require("lualine").setup({
      options = {
        component_separators = "",
        section_separators = "",
        disabled_filetypes = { statusline = { "alpha", "help", "trouble", "no-neck-pain", }, },
      },
      sections = lualine_sections,
      inactive_sections = lualine_sections,

      extensions = { "nvim-tree", "nvim-dap-ui", },
    })
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.opt.laststatus = 3
      end,
    })
  end,
}
