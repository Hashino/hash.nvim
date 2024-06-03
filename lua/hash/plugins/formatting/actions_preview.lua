return {
  "aznhe21/actions-preview.nvim",
  config = function()
    vim.keymap.set({ "v", "n" }, "qa", require("actions-preview").code_actions,
      { desc = '[A]pply [Q]uickfix' })
  end,
}
