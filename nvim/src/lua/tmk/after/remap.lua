vim.keymap.set("n", "<leader>d", vim.cmd.Ex)

-- --- Telesckope ---
local telebuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telebuiltin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>s', telebuiltin.git_files, { desc = 'Telescope find in git files' })
vim.keymap.set('n', '<leader>fh', telebuiltin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>b', telebuiltin.buffers, { desc = 'Telescope buffers' })
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

vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle)
