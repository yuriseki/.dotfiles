-- It is still not good enough with the current ollama configuration.
if true then return {} end
return {
  "yetone/avante.nvim",
  build = "make BUILD_FROM_SOURCE=true",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- this file can contain specific instructions for your project
    instructions_file = "avante.md",
    -- Enable agentic mode for tool usage
    mode = "agentic",
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
      enable_token_counting = true,
      auto_add_current_file = true,
      -- Tool permissions
      auto_approve_tool_permissions = true, -- Auto-approve tool usage
      -- disable_tools = { "bash", "python" }, -- Uncomment to disable specific tools
    },
    -- for example
    provider = "ollama",
    providers = {
      ollama = {
        __inherited_from = "openai",
        api_key_name = "",
        endpoint = "http://127.0.0.1:11434/v1",
        model = "qwen2.5-coder:7b", -- or your preferred Ollama model
        extra_request_body = {
          max_tokens = 2048,
        },
      },

      -- claude = {
      --   endpoint = "https://api.anthropic.com",
      --   model = "claude-sonnet-4-20250514",
      --   timeout = 30000, -- Timeout in milliseconds
      --   extra_request_body = {
      --     temperature = 0.75,
      --     max_tokens = 20480,
      --   },
      -- },
      -- moonshot = {
      --   endpoint = "https://api.moonshot.ai/v1",
      --   model = "kimi-k2-0711-preview",
      --   timeout = 30000, -- Timeout in milliseconds
      --   extra_request_body = {
      --     temperature = 0.75,
      --     max_tokens = 32768,
      --   },
      -- },
    },
    -- RAG Service configuration
    rag_service = {
      enabled = true, -- Enable the RAG service
      host_mount = os.getenv("HOME") .. "/.dotfiles", -- Mount home directory for codebase access
      runner = "docker", -- Use docker to run the RAG service
      llm = {
        provider = "ollama",
        endpoint = "http://127.0.0.1:11434",
        api_key = "",
        model = "qwen2.5-coder:7b",
        extra = nil,
      },
      embed = {
        provider = "ollama",
        endpoint = "http://127.0.0.1:11434",
        api_key = "",
        model = "nomic-embed-text:latest", -- Common embedding model available in Ollama
        extra = nil,
      },
      docker_extra_args = "",
    },
  },
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "Kaiser-Yang/blink-cmp-avante",
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
