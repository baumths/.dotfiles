-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print("Installing packer close and reopen Neovim...")

  vim.api.nvim_command([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd(
  "BufWritePost",
  {
    group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
    pattern = "plugins.lua",
    command = "source <afile> | PackerSync",
  }
)

local function setup_plugins(use)
  use "wbthomason/packer.nvim"

  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "stevearc/dressing.nvim"

  use {
    "lewis6991/impatient.nvim",
    config = function()
      require("baum.plugins.impatient")
    end
  }

  use {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    event = "InsertCharPre",
    config = function()
      require("baum.plugins.autopairs")
    end,
  }

  use {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("baum.plugins.comment")
    end,
  }


  use {
    "catppuccin/nvim",
    as = "catppuccin",
    run = "CatppuccinCompile",
    config = function()
      require("baum.plugins.colorscheme")
    end,
  }

  use {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end,
  }

  use {
    "nvim-lualine/lualine.nvim",
    after = "catppuccin",
    event = "BufEnter",
    config = function()
      require("baum.plugins.lualine")
    end
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("baum.plugins.indentline")
    end
  }

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    event = "CursorHold",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("baum.plugins.neotree")
    end,
  }

  -- Completion
  use {
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        require("baum.plugins.lsp.nvim-cmp")
      end,
      requires = {
        {
          "L3MON4D3/LuaSnip",
          event = "CursorHold",
          config = function()
            require("baum.plugins.lsp.luasnip")
          end,
          requires = { "rafamadriz/friendly-snippets" },
        }
      },
    },
    { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
    { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
    { "hrsh7th/cmp-path", after = "nvim-cmp" },
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
      require("baum.plugins.lsp.servers")
    end,
    requires = "hrsh7th/cmp-nvim-lsp",
  }

  -- Telescope
  use {
    {
      "nvim-telescope/telescope.nvim",
      event = "CursorHold",
      config = function()
        require("baum.plugins.telescope")
      end,
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("ui-select")
      end
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  }

  -- Treesitter
  use {
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      event = "CursorHold",
      config = function()
        require("baum.plugins.treesitter")
      end,
    },
    { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
    {
      'nvim-treesitter/playground',
      after = { 'nvim-treesitter' },
    }
  }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("baum.plugins.gitsigns")
    end,
  }

  -- Dart & Flutter
  use {
    "dart-lang/dart-vim-plugin",
    ft = "dart",
  }

  use {
    "akinsho/flutter-tools.nvim",
    requires = "nvim-lua/plenary.nvim",
    ft = "dart",
    event = "BufRead",
    config = function()
      require("baum.plugins.flutter")
      require("telescope").load_extension("flutter")
    end,
  }

  -- Testing
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "sidlatau/neotest-dart",
    },
    config = function()
      require("baum.plugins.test")
      require("neotest").setup {
        adapters = {
          require("neotest-dart") {
            command = "flutter",
          },
        },
        icons = {
          passed = "",
          failed = "",
          skipped = "",
          unknown = "",
          running = "◌",
          running_animated = { "", "", "", "" },
        },
        quickfix = {
          enabled = true,
          open = false,
        },
        summary = {
          animated = true,
          open = "botright vsplit | vertical resize 80",
        },
      }
    end,
  }

  -- Other
  use {
    "fladson/vim-kitty",
    ft = "conf",
    event = "BufRead"
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP  then
    require("packer").sync()
  end
end

local packer = require("packer")

packer.init {
  auto_reload_compiled = true,
}

return packer.startup {
  setup_plugins,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }
}
