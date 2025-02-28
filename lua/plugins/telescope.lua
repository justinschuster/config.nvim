return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
	'nvim-lua/plenary.nvim',
	{
	    'nvim-telescope/telescope-fzf-native.nvim',

	    -- only used at run
	    build = 'make',

	    cond = function()
		return vim.fn.executable 'make' == 1
	    end,
	},
	{ 'nvim-telescope/telescope-ui-select.nvim' },
	{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
	require('telescope').setup {
	    extensions = {
		['ui-select'] = {
		    require('telescope.themes').get_dropdown(),
		},
	    },
	}

	-- Enable Telescope extensions if installed
	pcall(require('telescope').load_extension, 'fzf')
	pcall(require('telescope').load_extension, 'ui-select')

	-- see ':help telescope.builtin'
	local builtin = require 'telescope.builtin'
	vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps]'})
	vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles'})
	vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope'})
    end,
}
