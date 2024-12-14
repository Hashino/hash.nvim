return {
  { -- preview of lsp actions
    "aznhe21/actions-preview.nvim",
    config = function()
      vim.keymap.set({ "v", "n", }, "<leader>q", require("actions-preview").code_actions,
        { desc = "Apply [Q]uickfix", })
    end,
  },
}
