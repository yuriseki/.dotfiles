-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("nvim-treesitter.install").prefer_git = true

-- Plugins configuration needs to be executed after all the plugins are loaded.
require("utils.load-config-dir").load_config_dir("plugins.config")
-- require("utils.load-config-dir").load_config_dir("projects-config.drupal")

-- Define theme.
vim.cmd("colorscheme nordfox")
-- vim.cmd("colorscheme nordfox")

