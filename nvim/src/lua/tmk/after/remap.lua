--vim.keymap.set("n", "<leader>d", vim.cmd.Ex)
vim.keymap.set("n", "<leader>d", "<CMD>Oil<CR>")

-- --- Custom ---

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Same as regular J but keep cursor at same place" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down but keep cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up but keep cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Nav search terms, but keep cursor at the middle" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Nav search terms, but keep cursor at the middle" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Delete highlighted world without copying and paster to the place" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>e", "\"_d", { desc = "Delete to void register (without copy)" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable orig dinding" })

vim.keymap.set("n", "<leader>,", function()
  --vim.lsp.buf.format()
  require("conform").format({ bufnr = 0 })
end, { desc = "Format buffer" })

vim.keymap.set("n", "<leader>rr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Quick replace" })

vim.keymap.set("n", "<leader>[", function() vim.cmd("bprev") end, { desc = "Go to the prev buffer" })
vim.keymap.set("n", "<leader>]", function() vim.cmd("bnext") end, { desc = "Go to the next buffer" })

-- fix quick fix navigation
--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }, { desc = "Make file executable" })

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Navigate projects with tmux" })

-- --- Telesckope ---
local telebuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telebuiltin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>s', telebuiltin.git_files, { desc = 'Telescope find in git files' })
vim.keymap.set('n', '<leader>fh', telebuiltin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>b', telebuiltin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fr', telebuiltin.lsp_references, { desc = 'Telescope lsp_references' })

vim.keymap.set('n', '<leader>fg',
  function()
    telebuiltin.grep_string({ search = vim.fn.input("Grep > ") })
  end
  , { desc = 'Telescope grep search' }
)
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })


local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>n", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon menu' })
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = 'Harpoon add to list' })
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>-", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>=", function() harpoon:list():next() end)
--vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
--vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
--vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
--vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- ---UndoTree--- --
vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle)

-- ---Neogit--- --
vim.keymap.set('n', '<leader>gs', vim.cmd.Neogit)



-- --- Trouble ---
vim.keymap.set("n", "<leader>tt", function()
  require("trouble").toggle()
end)

vim.keymap.set("n", "[t", function()
  require("trouble").next({ skip_groups = true, jump = true });
end)

vim.keymap.set("n", "]t", function()
  require("trouble").previous({ skip_groups = true, jump = true });
end)


-- ---Autosession ---
vim.keymap.set("n", "<leader>fp", function() vim.cmd("SessionSearch") end)
vim.keymap.set("n", "<leader>ps", function() vim.cmd("SessionSave") end)
