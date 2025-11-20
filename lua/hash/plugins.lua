require("hash.plugins.theme")

-- INFO: library dependencies
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
}, { confirm = false, })

require("hash.plugins.editing.completion")
require("hash.plugins.editing.highlight")
require("hash.plugins.editing.tooling")
require("hash.plugins.editing.documentation")
require("hash.plugins.editing.misc")

require("hash.plugins.utilities.git")
require("hash.plugins.utilities.buffers")
require("hash.plugins.utilities.auto-save")
require("hash.plugins.utilities.sessions")
require("hash.plugins.utilities.docgen")
require("hash.plugins.utilities.plugin-dev")

require("hash.plugins.interface.ui")
require("hash.plugins.interface.start-screen")
require("hash.plugins.interface.task-list")
require("hash.plugins.interface.status-bar")
require("hash.plugins.interface.file-explorer")
require("hash.plugins.interface.picker")
require("hash.plugins.interface.terminal")
require("hash.plugins.interface.which-key")

require("hash.plugins.debugging.dap")
