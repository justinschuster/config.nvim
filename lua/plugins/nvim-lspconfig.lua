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
}
