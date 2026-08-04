return {
  -- Importar el ecosistema oficial de Rust para LazyVim
  { import = "lazyvim.plugins.extras.lang.rust" },

  -- Extender la configuración de rustaceanvim para aplicar clippy
  {
    "mrcjkb/rustaceanvim",
    opts = function()
      return {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      }
    end,
  },
}
