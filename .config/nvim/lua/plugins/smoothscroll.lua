return {
	"gen740/SmoothCursor.nvim",
	event = "VeryLazy",
	config = function()
		require("smoothcursor").setup({
			type = "default", -- or 'exp'/'matrix'/'sonic'
			fancy = {
				enable = true, -- enables head + body + tail
			},
		})
	end,
}
