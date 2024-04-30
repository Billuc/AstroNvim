return {
  "L3MON4D3/LuaSnip",
  config = function(plugin, opts)
    -- Default astrnvim config
    require "astronvim.plugins.configs.luasnip"(plugin, opts)
    -- Load custom snippets
    require("luasnip.loaders.from_vscode").lazy_load {
      paths = { vim.fn.stdpath "config" .. "/snippets" },
    }
  end,
}
