-- File: lua/keymaps.lua

local map = vim.keymap.set

-- [[ Basic Mappings ]]
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit Neovim" })
map("n", "<leader>Q", ":q!<CR>", { desc = "Force Quit Neovim (discard changes)" })
map("n", "<leader>x", ":wq<CR>", { desc = "Save and Quit" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set({ "t", "i" }, "<A-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
vim.keymap.set({ "t", "i" }, "<A-j>", "<C-\\><C-n><C-w>j", { desc = "Move to down window" })
vim.keymap.set({ "t", "i" }, "<A-k>", "<C-\\><C-n><C-w>k", { desc = "Move to up window" })
vim.keymap.set({ "t", "i" }, "<A-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "Move to up window" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>pl", "o<C-r>+<Esc>", { desc = "Paste system clipboard to new line below" })

-- =============================================================================
-- CENTRALIZED PLUGIN KEYMAPS
-- =============================================================================

-- --- Plugin: neo-tree.nvim ---
map("n", "<leader>e", ":Neotree filesystem toggle left<CR>", { desc = "Toggle Neo-tree" })

-- --- Plugin: diffview.nvim ---
map("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Diffview: Open Git Diff" })
map("n", "<leader>gh", ":DiffviewFile<CR>", { desc = "Diffview: Open Current File Diff" })
map("n", "<leader>gl", ":DiffviewLog<CR>", { desc = "Diffview: Open Git Log Diff" })
map("n", "<leader>gq", ":DiffviewClose<CR>", { desc = "Diffview: Close Diffview" })

-- --- Plugin: toggleterm.nvim ---
map({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })

-- --- Plugin: gemini.nvim ---
map("n", "<leader>gg", "<cmd>GeminiChat<CR>", { desc = "Gemini: Open chat" })
map("v", "<leader>ge", ":<C-u>GeminiCodeExplain<CR>", { desc = "Gemini: Explain code" })
map("v", "<leader>gr", ":<C-u>GeminiCodeReview<CR>", { desc = "Gemini: Code review" })
map("v", "<leader>gt", ":<C-u>GeminiUnitTest<CR>", { desc = "Gemini: Generate unit tests" })

-- --- Plugin: nerdcommenter ---
-- Using the improved version of the keymap we discussed
map({ "n", "v" }, "<leader>c ", "<cmd>NERDCommenterToggle<CR>", { desc = "NerdCommenter: Toggle comment" })
map("n", "<leader>cc", "<cmd>NERDCommenterComment<CR>", { desc = "NerdCommenter: Add comment" })

-- --- Plugin: telescope.nvim ---
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope: Find Files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope: Find Buffers" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope: Live Grep (text)" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope: Search Help" })
map("n", "<leader>fG", "<cmd>Telescope git_files<cr>", { desc = "Telescope: Git Files" })
map("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope: Git Commits" })
map("n", "<leader>ts", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Telescope: LSP Document Symbols" })

-- --- Plugin: vim-mundo ---
map("n", "<leader>u", "<cmd>MundoShow<CR>", { desc = "Open Undo Tree (Mundo)" })

-- --- Plugin: copilot.vim ---
map("i", "<C-l>", function()
	vim.fn.feedkeys(vim.fn["copilot#Accept"](), "i")
end, { noremap = true, silent = true, desc = "Copilot: Accept suggestion" })
-- =============================================================================
-- LSP KEYMAPS (This part remains the same)
-- =============================================================================
return function(client, bufnr)
	local lsp_map = function(mode, lhs, rhs, opts)
		opts = opts or {}
		opts.buffer = bufnr
		map(mode, lhs, rhs, opts)
	end
	-- ... (the rest of your LSP keymaps function is unchanged)
	vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
	lsp_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
	lsp_map("n", "K", vim.lsp.buf.hover, { desc = "Hover Info" })
	lsp_map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
	lsp_map("n", "gr", vim.lsp.buf.references, { desc = "Show References" })
	lsp_map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
	lsp_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
	lsp_map("n", "[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, { desc = "Previous Diagnostic" })
	lsp_map("n", "]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, { desc = "Next Diagnostic" })
	local diagnostic_severity = vim.diagnostic.severity
	lsp_map("n", "[e", function()
		vim.diagnostic.jump({ count = -1, severity = diagnostic_severity.ERROR })
	end, { desc = "Previous ERROR Diagnostic" })
	lsp_map("n", "]e", function()
		vim.diagnostic.jump({ count = 1, severity = diagnostic_severity.ERROR })
	end, { desc = "Next ERROR Diagnostic" })
	lsp_map("n", "[w", function()
		vim.diagnostic.jump({ count = -1, severity = diagnostic_severity.WARN })
	end, { desc = "Previous WARNING Diagnostic" })
	lsp_map("n", "]w", function()
		vim.diagnostic.jump({ count = 1, severity = diagnostic_severity.WARN })
	end, { desc = "Next WARNING Diagnostic" })
	lsp_map("n", "<leader>le", function()
		vim.diagnostic.setloclist({ severity = diagnostic_severity.ERROR })
	end, { desc = "Quickfix List with ERRORs" })
	lsp_map("n", "<leader>lw", function()
		vim.diagnostic.setloclist({ severity = diagnostic_severity.WARN })
	end, { desc = "Quickfix List with WARNINGS " })
end
