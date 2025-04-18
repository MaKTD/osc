local telebuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telebuiltin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>s', telebuiltin.git_files, { desc = 'Telescope find in git files' })
vim.keymap.set('n', '<leader>fh', telebuiltin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fg', 
  function()
    telebuiltin.grep_string({ search = vim.fn.input("Grep > ") })
  end
, { desc = 'Telescope help tags' }
)
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
--vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
