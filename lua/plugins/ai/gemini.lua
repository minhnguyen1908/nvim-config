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
		task = {
			enabled = true,
		},
	},
}
