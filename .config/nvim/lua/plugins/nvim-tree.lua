return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			filters = {
				dotfiles = false, -- Show hidden files (like .env)
				git_ignored = false, -- Show .gitignored files
			},
			view = {
				width = 30,
				side = "left",
			},
			renderer = {
				group_empty = true,
			},
		})
	end,
}
