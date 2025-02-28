return {
    'neovim/nvim-lspconfig',
    dependencies = {
	{ 'williamboman/mason.nvim', opts = {} },
	'williamboman/mason-lspconfig.nvim',
	'WhoIsSethDaniel/mason-tool-installer.nvim',

	-- Useful status updates
	{ 'j-hui/fidget.nvim', opts = {} },

	-- Allows to use nvim-cmp stuff
	'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
	local servers = { 
	    lua_ls = {
		settings = {
		    Lua = {
			completion = {
			    callSnippet = 'Replace',
			},
		    },
		},
	    },
	}

	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, {
	    'stylua',
	})
	require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    end,
}
