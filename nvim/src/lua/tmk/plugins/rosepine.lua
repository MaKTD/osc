return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      variant = "auto", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = fasle,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
      },

      styles = {
        bold = true,
        italic = true,
        transparency = false,
      }, 
    })

    local colorMyPencils = function(color)
      color = color or "rose-pine"
      vim.cmd.colorscheme(color)
      --vim.cmd("colorscheme rose-pine")

      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end

    colorMyPencils();
    
  end
}
