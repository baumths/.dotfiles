return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
  },
  config = function()
    local icons = {
      Text = "",
      Method = "m",
      Function = "",
      Constructor = "",
      Field = "",
      Variable = "",
      Class = "",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }

    local luasnip = require("luasnip")
    local cmp = require("cmp")

    cmp.setup({
      experimental = { ghost_text = true },
      confirm_opts = { select = true, behavior = cmp.ConfirmBehavior.Replace },
      mapping = cmp.mapping.preset.insert({
        ["<c-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<c-u>"] = cmp.mapping(cmp.mapping.scroll_docs( -4), { "i", "c" }),
        ["<c-x>"] = cmp.mapping.complete(),
        ["<cr>"] = cmp.mapping.confirm(),
        ["<tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            cmp.select_next_item()
            fallback()
          end
        end, { "i", "s" }),
        ["<s-tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable( -1) then
            luasnip.jump( -1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, item)
          item.kind = string.format("%s", icons[item.kind])
          return item
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").filetype_extend("dart", { "flutter" })
  end,
}
