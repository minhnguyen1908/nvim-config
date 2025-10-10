return {
	"kiddos/gemini.nvim",
	cmd = {
		"GeminiTask",
		"GeminiApply",
		"GeminiChat",
		"GeminiCodeExplain",
		"GeminiCodeReview",
		"GeminiUnitTest",
	},

	opts = {
		chat_config = {
			enabled = true,
		},

		hints = {
			enabled = true,
			hints_delay = 1000,
		},
	},

	keys = {
		{ "<leader>gg", "<cmd>GeminiChat<CR>", desc = "Gemini: Open chat" },
		{ "<leader>ge", ":<C-u>GeminiCodeExplain<CR>", mode = "v", desc = "Gemini: Explain code" },
		{ "<leader>gr", ":<C-u>GeminiCodeReview<CR>", mode = "v", desc = "Gemini: Code review" },
		{ "<leader>gt", ":<C-u>GeminiUnitTest<CR>", mode = "v", desc = "Gemini: Generate unit tests" },
	},
}
