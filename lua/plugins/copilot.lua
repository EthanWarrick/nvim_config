---@type LazyPluginSpec
local Copilot = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  lazy = true,
  opts = {
    panel = { enabled = false },
    suggestion = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}

---@type LazyPluginSpec
local CopilotCmpSrc = {
  "zbirenbaum/copilot-cmp",
  dependencies = { "zbirenbaum/copilot.lua" },
  opts = {},
  config = function(_, opts)
    local copilot_cmp = require("copilot_cmp")
    copilot_cmp.setup(opts)
    -- attach cmp source whenever copilot attaches
    -- fixes lazy-loading issues with the copilot cmp source
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "copilot" then
          copilot_cmp._on_insert_enter({})
        end
      end,
    })
  end,
}

---@type LazyPluginSpec
local CmpCompletion = {
  "hrsh7th/nvim-cmp",
  optional = true,
  dependencies = { CopilotCmpSrc },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    table.insert(opts.sources, 1, {
      name = "copilot",
      group_index = 1,
      priority = 100,
    })
  end,
}

---@type LazyPluginSpec
local BlinkCompletionSrc = {
  "fang2hou/blink-copilot",
  dependencies = { "zbirenbaum/copilot.lua" },
  opts = function()
    local icon = require("util").icons.kinds.Copilot
    return {
      max_completions = 3,
      max_attempts = 4,
      kind_name = "Copilot", ---@type string | false
      kind_icon = icon, ---@type string | false
      kind_hl = false, ---@type string | false
      debounce = 200, ---@type integer | false
      auto_refresh = {
        backward = true,
        forward = true,
      },
    }
  end,
}

---@type LazyPluginSpec
local BlinkCompletion = {
  "saghen/blink.cmp",
  optional = true,
  dependencies = {
    { BlinkCompletionSrc },
  },
  opts = {
    sources = {
      default = { "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
  },
}

---@type LazyPluginSpec
local CopilotChat = {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  build = "make tiktoken", -- Only on MacOS or Linux
  opts = function()
    local user = vim.env.USER or "User"
    user = user:sub(1, 1):upper() .. user:sub(2)
    local icon = require("util").icons.kinds.Copilot
    return {
      model = "gpt-4", -- GPT model to use, 'gpt-3.5-turbo', 'gpt-4', or 'gpt-4o'
      question_header = " " .. user .. " ", -- Header to use for user questions
      answer_header = icon .. " Copilot ", -- Header to use for AI answers
      show_help = false, -- Shows help message as virtual lines when waiting for user input
      window = {
        width = 0.4,
      },
      selection = function(source)
        local select = require("CopilotChat.select")
        return select.visual(source) or select.buffer(source)
      end,
      mappings = {
        complete = {
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = { -- The default '<C-l>' is already used for window navigation
          normal = "",
          insert = "",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        toggle_sticky = {
          detail = "Makes line under cursor sticky or deletes sticky line.",
          normal = "gr",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        jump_to_diff = {
          normal = "gj",
        },
        quickfix_diffs = {
          normal = "gq",
        },
        yank_diff = {
          normal = "",
          register = "",
        },
        show_diff = {
          normal = "gd",
        },
        show_info = {
          normal = "gi",
        },
        show_context = {
          normal = "gc",
        },
        show_help = {
          normal = "gh",
        },
      },
    }
  end,
  cmd = {
    "CopilotChat",
    "CopilotChatAgents",
    "CopilotChatClose",
    "CopilotChatCommit",
    "CopilotChatCommitStaged",
    "CopilotChatDebugInfo",
    "CopilotChatDocs",
    "CopilotChatExplain",
    "CopilotChatFix",
    "CopilotChatFixDiagnostic",
    "CopilotChatLoad",
    "CopilotChatModels",
    "CopilotChatOpen",
    "CopilotChatOptimize",
    "CopilotChatReset",
    "CopilotChatReview",
    "CopilotChatSave",
    "CopilotChatStop",
    "CopilotChatTests",
    "CopilotChatToggle",
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-chat",
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.opt_local.signcolumn = "no"
      end,
    })

    require("CopilotChat").setup(opts)
  end,
}
Copilot.specs = { CmpCompletion, BlinkCompletion }

return { Copilot, CopilotChat }
