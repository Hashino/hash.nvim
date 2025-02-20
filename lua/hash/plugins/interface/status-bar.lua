return {
  "rebelot/heirline.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
    "Hashino/doing.nvim",
  },

  config = function()
    local conditions = require("heirline.conditions")

    local colors = require("hash.theme").colors
    colors = vim.tbl_extend("keep",
      colors,
      {
        bright_bg = colors.highlight,
        bright_fg = colors.fg,
        diag_error = colors.error,
        diag_warn = colors.warn,
        diag_hint = colors.hint,
        diag_info = colors.info,
        git_add = colors.diff_add,
        git_change = colors.diff_change,
        git_del = colors.diff_remove,
      })

    require("heirline").load_colors(colors)

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
        "ModeChanged",
        "RecordingEnter",
        "RecordingLeave",
      },
    }

    local git = {
      condition = conditions.is_git_repo,

      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0
           or self.status_dict.removed ~= 0
           or self.status_dict.changed ~= 0
      end,

      hl = {
        bg = "bright_bg",
      },

      { provider = " ", },
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
          "InsertLeave",
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
      { provider = " ", },
    }

    local diagnostics = {
      condition = conditions.has_diagnostics,

      init = function(self)
        self.errs = #vim.diagnostic.get(0,
          { severity = vim.diagnostic.severity.ERROR, })
        self.wrns = #vim.diagnostic.get(0,
          { severity = vim.diagnostic.severity.WARN, })
        self.hnts = #vim.diagnostic.get(0,
          { severity = vim.diagnostic.severity.HINT, })
        self.infs = #vim.diagnostic.get(0,
          { severity = vim.diagnostic.severity.INFO, })

        self.err_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text
        self.wrn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text
        self.inf_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text
        self.hnt_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text
      end,

      update = {
        "DiagnosticChanged",
        "BufEnter",
      },

      { provider = " ", },
      {
        provider = function(self)
          -- 0 is just another output, we can decide to print it or not!
          return self.errs > 0 and (self.err_icon .. self.errs .. " ")
        end,
        hl = { fg = "diag_error", },
      },
      {
        provider = function(self)
          return self.wrns > 0 and (self.wrn_icon .. self.wrns .. " ")
        end,
        hl = { fg = "diag_warn", },
      },
      {
        provider = function(self)
          return self.infs > 0 and (self.inf_icon .. self.infs .. " ")
        end,
        hl = { fg = "diag_info", },
      },
      {
        provider = function(self)
          return self.hnts > 0 and (self.hnt_icon .. self.hnts .. " ")
        end,
        hl = { fg = "diag_hint", },
      },
    }

    local doing = {
      {
        condition = function()
          return require("doing").status() ~= ""
        end,
        {
          {
            provider = "󰁕 ",
          },
          {
            provider = function()
              local status = require("doing").status()
              if not conditions.width_percent_below(#status, 0.3) then
                local max_len = vim.api.nvim_win_get_width(0) * 0.3
                status = status:sub(0, max_len) .. "..."
              end
              return status
            end,

            hl = { bold = true, },
          },
        },

        {
          init = function(self)
            self.count = require("doing").tasks_left() - 1
          end,

          condition = function()
            return require("doing").tasks_left() > 1
          end,

          provider = function(self)
            return " +" .. tostring(self.count) .. " more"
          end,

          hl = {
            fg = colors.gray,
            italic = true,
          },
        },
      },

      update = {
        "BufEnter",
        "User",
        pattern = "TaskModified",
      },
    }

    local debugger_status = {
      condition = function()
        local session = require("dap").session()
        return session ~= nil
      end,

      provider = function()
        return require("dap").status()
      end,
      hl = "Debug",
    }

    local file_name = {
      -- let's first set up some attributes needed by this component and its children
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
      {
        provider = function(self)
          -- for other options, see :h filename-modifers
          local filename = vim.fn.fnamemodify(self.filename, ":.")
          if filename == "" then return " [No Name] " end
          -- shortens if filename is bigger than proportion of width
          if not conditions.width_percent_below(#filename, 0.25) then
            local winwidth
            if vim.o.laststatus == 3 then
              winwidth = vim.o.columns
            else
              winwidth = vim.api.nvim_win_get_width(0)
            end

            local max_len
            if conditions.is_active() then
              max_len = (winwidth * 0.25) - 3
            else
              max_len = winwidth
            end

            local ind, _ = filename:find("/", #filename - max_len + 2)
            filename = "..." .. filename:sub(ind or 0, #filename)
          end
          return " " .. filename .. " "
        end,

        update = {
          "BufEnter",
          "BufLeave",
          "BufFilePost",
          "DirChanged",
        },
      },
      { provider = "%<", },
    }

    local lsp = {
      condition = conditions.lsp_attached,

      provider = function()
        local icon = require("nvim-web-devicons").get_icon_by_filetype(vim.bo
          .filetype)
        return " " .. (icon or vim.bo.filetype) .. "  "
      end,

      hl = function()
        return {
          fg = mode_colors[vim.fn.mode(1):sub(1, 1)],
          bg = "bright_bg",
        }
      end,

      update = {
        "ModeChanged",
        "LspAttach",
        "LspDetach",
      },
    }

    local location = {
      provider = function()
        return " %2l:%-2L ┃ %2c:" ..
           string.format("%-2d", vim.fn.col("$") - 1) .. " "
      end,

      hl = function()
        return {
          bg = mode_colors[vim.fn.mode(1):sub(1, 1)],
          fg = colors.bg,
          bold = true,
        }
      end,
      update = {
        "ModeChanged",
        "CursorMoved",
      },
    }

    local nvimtree_statusbar = {
      { provider = "%=", },
      {
        provider = function()
          return vim.fn.getcwd(0):gsub(os.getenv("HOME") or "~", "~")
        end,
      },
      { provider = "%=", },

      update = { "DirChanged", },
    }

    local dapui_statusbar = {
      {
        file_name,
        hl = function()
          return {
            bg = mode_colors[vim.fn.mode(1):sub(1, 1)],
            fg = colors.bg,
            bold = true,
          }
        end,
      },
      { provider = "%=", },
      debugger_status,
      { provider = "%=", },

      update = {
        "ModeChanged",
        "BufEnter",
      },
    }

    vim.g.status_bar_enabled = true

    vim.keymap.set("n", "<leader>S", function()
      vim.g.status_bar_enabled = not vim.g.status_bar_enabled
      if vim.g.status_bar_enabled then
        vim.opt.laststatus = 3
      else
        vim.opt.laststatus = 0
      end
    end, { desc = "Toggle [S]tatusbar", })

    require("heirline").setup({
      statusline = {
        {
          condition = function()
            return vim.g.status_bar_enabled
          end,

          { -- default status line
            condition = function()
              return not conditions.buffer_matches({
                filetype = {
                  "no-neck-pain",
                  "alpha",
                  "NvimTree",
                  "buffer_manager",
                  "trouble",
                  "Telescope*",
                  "toggleterm",
                  "dapui*",
                  "doing_tasks",
                  "lazy",
                },
                buftype = {
                  "nofile",
                },
              }) and conditions.is_active()
            end,
            macro,
            git,
            diagnostics,
            { provider = "%=", },
            doing,
            { provider = "%=", },
            file_name,
            lsp,
            location,
          },

          { -- default status line (unfocused)
            condition = function()
              return not conditions.buffer_matches({
                filetype = {
                  "no-neck-pain",
                  "alpha",
                  "NvimTree",
                  "buffer_manager",
                  "trouble",
                  "Telescope*",
                  "toggleterm",
                  "dapui*",
                  "doing_tasks",
                  "lazy",
                },
                buftype = {
                  "nofile",
                },
              }) and not conditions.is_active()
            end,
            { provider = "%=", },
            file_name,
            { provider = "%=", },
          },

          { -- status line for alpha
            condition = function()
              return conditions.buffer_matches({
                filetype = { "alpha", },
              })
            end,
            { provider = "%=", },
            doing,
            { provider = "%=", },
          },

          { -- status line for nvimtree
            condition = function()
              return conditions.buffer_matches({
                filetype = { "NvimTree", },
              })
            end,
            nvimtree_statusbar,
          },

          { -- status line for dapui
            condition = function()
              return conditions.buffer_matches({
                filetype = { "dapui*", },
              })
            end,
            dapui_statusbar,
          },
        },
      },
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.opt.laststatus = 3
      end,
    })
  end,
}
