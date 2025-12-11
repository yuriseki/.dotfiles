# GEMINI.md: Neovim Configuration

## Project Overview

This directory contains a personal Neovim configuration. It is built upon the **LazyVim** framework and is highly customized for web development, with a particular focus on **PHP/Drupal** and **Python**. The configuration is written in **Lua**.

The structure is modular, using `lazy.nvim` for plugin management. Custom plugins, themes, and project-specific settings are organized into subdirectories within `lua/plugins/`. The configuration aims to replicate several features and keybindings from IntelliJ IDEA for a familiar editing experience.

### Key Technologies & Features

*   **Framework:** [LazyVim](https://www.lazyvim.org/)
*   **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
*   **Primary Language:** Lua
*   **Key Plugins:**
    *   `telescope.nvim`: For fuzzy finding files, buffers, and more.
    *   `nvim-dap`: For debugging, with specific configurations for Python and PHP.
    *   `conform.nvim`: For code formatting.
    *   `oil.nvim`: For file system navigation.
*   **Customizations:**
    *   Extensive custom keymaps to emulate IntelliJ IDEA's workflow (`lua/config/keymaps.lua`).
    *   Project-specific settings for Drupal development (`lua/plugins/project/drupal/`).
    *   Custom formatting scripts for Drupal (`lua/utils/drupal-formatter.lua`).
    *   Custom color scheme (`bluloco`).

## Building and Running

This is a Neovim configuration, so there is no "build" step.

1.  **Installation:**
    *   Ensure you have Neovim (v0.8.0+ recommended) installed.
    *   Clone this repository to the correct location (typically `~/.config/nvim`).
    *   The first time you launch Neovim (`nvim`), the `lazy.nvim` plugin manager will automatically install all the configured plugins.

2.  **Running:**
    *   Simply run `nvim` in your terminal to start the editor.

3.  **Updating Plugins:**
    *   You can check for plugin updates from within Neovim by running the `:Lazy` command. This will open an interface to manage your plugins, including updating them.

## Development Conventions

*   **Structure:** The configuration is highly modular.
    *   General editor options are in `lua/config/options.lua`.
    *   Global keymaps are in `lua/config/keymaps.lua`.
    *   Plugin configurations are located in `lua/plugins/`. Each plugin should have its own file.
*   **Code Style:**
    *   Lua code is formatted using `stylua`. The configuration is in `stylua.toml`.
    *   **Indent Type:** Spaces
    *   **Indent Width:** 2
    *   **Column Width:** 120
*   **Keymaps:** Keymaps are defined in `lua/config/keymaps.lua` and are intended to be silent and non-recursive (`{ noremap = true, silent = true }`) where possible. Descriptions are added to keymaps to integrate with plugins like `which-key`.
*   **Plugin Specification:** Plugins are added by creating a new Lua file in the `lua/plugins/` directory. The file should return a table that follows the `lazy.nvim` spec. For example:
    ```lua
    return {
      "user/repo",
      -- lazy-load on a specific event
      event = "VeryLazy",
      -- override default configuration
      opts = {
        -- your options here
      }
    }
    ```
    * **Plugin Configuration:** Configurations are added by creating a new Lua file in `lua/plugins/config` directory. The file should apply
    the specific plugin configuration. For example:
    ```lua
    local config = require("plugin_name")
    config.setup({
      key = value,
    })
    ```
