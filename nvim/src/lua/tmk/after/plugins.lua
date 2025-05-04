local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local UserGroup = augroup('UserGenGroup', {})

local yank_group = augroup('HLYank', {})

--function R(name)
--    require("plenary.reload").reload_module(name)
--end

vim.filetype.add({
  extension = {
    templ = 'templ',
  }
})


autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})


local lspconf = require('lspconfig')
lspconf.denols.setup {
  root_dir = lspconf.util.root_pattern("deno.json", "deno.jsonc"),
}
lspconf.ts_ls.setup {
  root_dir = lspconf.util.root_pattern("package.json"),
  single_file_support = false
}


--autocmd({"BufWritePre"}, {
--   group = UserGroup,
--   pattern = "*",
--  command = [[%s/\s\+$//e]],
--})

--[[
autocmd('BufEnter', {
    group = UserGroup,
    callback = function()
        if vim.bo.filetype == "zig" then
            vim.cmd.colorscheme("tokyonight-night")
        else
            vim.cmd.colorscheme("rose-pine-moon")
        end
    end
})
--]]



autocmd('LspAttach', {
  group = UserGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set({ "n", "i" }, "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  end
})


--vim.g.netrw_browse_split = 0
--vim.g.netrw_banner = 0
--vim.g.netrw_winsize = 25

local colorMyPencils = function(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
  --vim.cmd("colorscheme rose-pine")

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

colorMyPencils('tokyonight-storm')
