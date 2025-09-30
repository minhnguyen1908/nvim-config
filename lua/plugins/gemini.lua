return {
	"kiddos/gemini.nvim",
	-- The plugin will lazy-load when its commands are used for the first time
	cmd = {
		"GeminiCode",
		"GeminiCodeExplain",
		"GeminiCodeReview",
		"GeminiUnitTest",
		"GeminiChat",
	},

	-- The 'opts' table below contains all the configuration options for the plugin
	opts = {
		-- This section enables the chat feature
		chat_config = {
			enabled = true,
		},

		-- The plugin will automatically find your GEMINI_API_KEY from the environment
		-- if it is set. If not, you can provide it here:
		-- model_config = {
		--   api_key = 'YOUR_API_KEY_HERE',
		-- },

		-- This section enables the hints feature (which provides inline suggestions)
		hints = {
			enabled = true,
			hints_delay = 1000, -- Delay in milliseconds before showing hints
		},
	},

	-- This is where you define your keymaps
	keys = {
		-- A keymap to open a Gemini chat window
		{ "<leader>gg", ":GeminiChat<CR>", desc = "Gemini: Open chat" },

		-- A keymap to explain selected code
		{ "<leader>ge", ":<C-u>GeminiCodeExplain<CR>", mode = "v", desc = "Gemini: Explain code" },

		-- A keymap to review selected code
		{ "<leader>gr", ":<C-u>GeminiCodeReview<CR>", mode = "v", desc = "Gemini: Code review" },

		-- A keymap to generate unit tests for a selected block of code
		{ "<leader>gt", ":<C-u>GeminiUnitTest<CR>", mode = "v", desc = "Gemini: Generate unit tests" },
	},
}
