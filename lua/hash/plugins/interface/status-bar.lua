return {
  {
    "rebelot/heirline.nvim",
    dependencies = { "rmehri01/onenord.nvim", },
    -- You can optionally lazy-load heirline on UiEnter
    -- to make sure all required plugins and colorschemes are loaded before setup
    -- event = "UiEnter",
    config = function()
      local colors = require("onenord.colors").load()

      local mode_colors = {
        n = "cyan",
        i = "green",
        v = "purple",
        V = "light_purple",
        ["\22"] = "light_purple",
        c = "orange",
        s = "light_green",
        S = "light_green",
        ["\19"] = "light_green",
        R = "orange",
        r = "orange",
        ["!"] = "red",
        t = "red",
      }

      require("heirline").load_colors(colors)
      local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")

      local macro = {

        condition = function()
          return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
        end,

        provider = function()
          return " @" .. vim.fn.reg_recording() .. " "
        end,

        hl = function()
          return {
            bg = mode_colors[vim.fn.mode(1):sub(1, 1)],
            fg = colors.bg,
            bold = true,
          }
        end,

        update = {
          "RecordingEnter",
          "RecordingLeave",
        },
      }

      local git_status = {
        condition = conditions.is_git_repo,

        init = function(self)
          self.status_dict = vim.b.gitsigns_status_dict
          self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or
             self.status_dict.changed ~= 0
        end,

        hl = {
          bg = utils.get_highlight("illuminatedWord").bg,
        },

        {
          provider = " ",
        },
        { -- git branch name
          provider = function(self)
            return "[" .. self.status_dict.head .. "]"
          end,

          hl = function()
            return {
              fg = mode_colors[vim.fn.mode(1):sub(1, 1)],
            }
          end,

          update = {
            "ModeChanged",
          },
        },
        {
          provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (" +" .. count)
          end,
          hl = { fg = "green", },
        },
        {
          provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (" -" .. count)
          end,
          hl = { fg = "red", },
        },
        {
          provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (" ~" .. count)
          end,
          hl = { fg = "dark_blue", },
        },
        {
          provider = " ",
        },
      }

      local diagnostics = {
        condition = conditions.has_diagnostics,

        init = function(self)
          self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR, })
          self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN, })
          self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT, })
          self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO, })
          self.error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text
          self.warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text
          self.info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text
          self.hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text
        end,

        update = { "DiagnosticChanged", "BufEnter", },

        {
          provider = " ",
        },
        {
          provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
          end,
          hl = { fg = "red", },
        },
        {
          provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
          end,
          hl = { fg = "orange", },
        },
        {
          provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
          end,
          hl = { fg = "green", },
        },
        {
          provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
          end,
          hl = { fg = "purple", },
        },
      }

      local doing = {
        {
          provider = function()
            return " " .. require("doing.api").status() .. " "
          end,
          update = { "BufEnter", "User", pattern = "TaskModified", },
        },
      }

      local file_name = {
        -- let's first set up some attributes needed by this component and its children
        init = function(self)
          self.filename = vim.api.nvim_buf_get_name(0)
        end,
        {
          init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
          end,

          provider = function(self)
            -- first, trim the pattern relative to the current directory. For other
            -- options, see :h filename-modifers
            local filename = vim.fn.fnamemodify(self.filename, ":.")
            if filename == "" then return " [No Name] " end
            -- now, if the filename would occupy more than 1/4th of the available
            -- space, we trim the file path to its initials
            -- See Flexible Components section below for dynamic truncation
            if not conditions.width_percent_below(#filename, 0.4) then
              filename = vim.fn.pathshorten(filename)
            end
            return " " .. filename .. " "
          end,
        },
        { provider = "%<", },
      }

      local lsp = {
        condition = conditions.lsp_attached,

        provider = function()
          local clients = vim.lsp.get_clients({ bufnr = 0, })
          if next(clients) == nil then
            return ""
          end

          local c = {}
          for _, client in pairs(clients) do
            table.insert(c, client.name)
          end
          return " " .. table.concat(c, " | ") .. " "
        end,
        hl = function()
          return {
            fg = mode_colors[vim.fn.mode(1):sub(1, 1)],
            bg = utils.get_highlight("illuminatedWord").bg,
          }
        end,
      }

      local location = {
        provider = function()
          local curr_line = vim.fn.line(".")
          local curr_col = vim.fn.charcol(".")
          local total_line = vim.fn.line("$")
          local total_col = vim.fn.charcol("$") - 1
          return string.format(" %2d:%-2d┃%2d:%-2d ", curr_line, total_line, curr_col, total_col)
        end,
        hl = function()
          return {
            bg = mode_colors[vim.fn.mode(1):sub(1, 1)],
            fg = colors.bg,
            bold = true,
          }
        end,
        update = {
          "ModeChanged", "CursorMoved",
        },
      }

      local middle_fill = { provider = "%=", }

      local status_bar = {
        condition = function()
          return not conditions.buffer_matches({
            filetype = { "no-neck-pain", "alpha", "NvimTree", "trouble", },
          })
        end,
        macro,
        git_status,
        diagnostics,
        doing,
        middle_fill,
        file_name,
        lsp,
        location,
      }

      require("heirline").setup({
        statusline = status_bar,
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.opt.laststatus = 3
        end,
      })
    end,
  },
}
