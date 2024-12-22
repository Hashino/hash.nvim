-- helper function to simplify section declaration
local function section(type, val, hl, spacing)
  return { type = type, val = val, opts = { position = "center", hl = hl, spacing = spacing, }, }
end

--- @param keybind string the keybind of the button
--- @param keybind_opts table? optional
--- @param txt string the text of the button
--- @param action function function to be executed when button pressed
local function button(keybind, txt, action, keybind_opts)
  return {
    type = "button",
    val = "  " .. txt,
    on_press = action,
    opts = {
      hl = "Normal",
      position = "center",
      width = 50,
      cursor = 1,

      keymap = {
        "n",
        keybind,
        action,
        keybind_opts or { noremap = true, silent = true, nowait = true, },
      },
      shortcut = "[" .. keybind .. "]",
      align_shortcut = "left",
      hl_shortcut = "@symbol",
    },
  }
end

vim.g.get_sessions = function()
  local session_files = io.popen(
    "ls -pa --sort=time " ..
    require("persisted.config").save_dir .. " | grep -v /"
  ):lines()

  local sessions = {}

  for s in session_files do
    local full_path = s:gsub("%%", "/"):gsub("%.vim", "")
    local short_path = full_path:gsub(vim.fn.expand("$HOME"), "~")
    table.insert(sessions,
      { short_path = short_path, full_path = full_path, name = s, })
  end

  return sessions
end

-- gets buttons for previous sessions from persisted
local function sessions_section()
  local sections = {}

  for i, s in ipairs(vim.g.get_sessions()) do
    local shortcut = tostring(i)

    if i == 10 then
      table.insert(sections, section("padding", 1))
    end

    if i == 20 then
      break
    end

    if i > 9 then
      shortcut = "-"
    end

    local load = function()
      vim.fn.chdir(s.full_path)
      require("persisted").load()
    end

    table.insert(sections, button(shortcut, s.short_path, load))
  end

  if sections == {} then
    sections = { section("text", "No previous session found"), }
  end

  return sections
end

local function new_file()
  vim.cmd("ene")
end

local function search_sessions()
  vim.cmd("Telescope persisted")
end

local function clear_sessions()
  for _, s in pairs(vim.g.get_sessions()) do
    if vim.fn.isdirectory(s.full_path) == 0 then
      require("persisted").delete({ session = require("persisted.config")
      .save_dir .. s.name, })
      vim.notify("deleted session: " .. s.short_path)
    end
  end
end

return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- deletes old sessions
    clear_sessions()
    require("alpha").setup({
      layout = {
        section("padding", 7),
        section("text", {
          [[  _               _                  _            ]],
          [[ | |             | |                (_)           ]],
          [[ | |__   __ _ ___| |__    _ ____   ___ _ __ ___   ]],
          [[ | '_ \ / _` / __| '_ \  | '_ \ \ / / | '_ ` _ \  ]],
          [[ | | | | (_| \__ \ | | |_| | | \ V /| | | | | | | ]],
          [[ |_| |_|\__,_|___/_| |_(_)_| |_|\_/ |_|_| |_| |_| ]],
        }, "@function"),
        section("padding", 2),
        section("text", { "Previous Sessions", }, "Type"),
        section("padding", 1),
        section("group", sessions_section(), nil, 0),
        section("padding", 1),
        section("text", { "Commands", }, "Type"),
        section("padding", 1),
        button("n", "  New File", new_file),
        button("s", "󰩉  Search Sessions", search_sessions),
        section("padding", 2),
      },
      opts = {
        margin = 5,
      },
    })
  end,
}
