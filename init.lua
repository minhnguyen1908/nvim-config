-- Set <space> as the leader key.
-- The leader key is a prefix for custom keybindings and many plugins.
-- NOTE: This must happen before plugins are loaded (otherwise wrong leader will be used).
-- See `:help mapleader` for more information.
vim.g.mapleader = " "
vim.g.maplocalleader = " " -- Also set localleader, useful for buffer-specific maps.

-- [[ Setting global Neovim options ]]
-- These options control Neovim's behavior, appearance, and core functionality.
-- See `:help option-list` for a full list, and `:help 'optionname'` for individual option docs.

vim.o.number = true -- Print the line number in front of each line.
vim.o.relativenumber = true -- Use relative line numbers, which makes jumping with `j` and `k` much easier.
-- This will affect the 'number' option, see `:h number_relativenumber`.

vim.o.termguicolors = true -- Enable true colors (24-bit RGB) in the terminal if supported.
-- Essential for most modern colorschemes to display correctly.

vim.o.expandtab = true -- Use spaces instead of tabs when you press the Tab key.
vim.o.tabstop = 4 -- Set the visual width of a tab character to 4 spaces.
vim.o.shiftwidth = 4 -- Set the number of spaces for indentation (e.g., when using `>>` or `==`).
vim.o.autoindent = true -- Automatically indent new lines to match the previous line's indentation.
vim.o.smartindent = true -- Smarter auto-indentation specifically for programming languages.

vim.o.mouse = "a" -- Enable mouse support in all modes ('a' means all modes).
-- Optional, but can be helpful for beginners or for quick window resizing.

vim.o.wrap = false -- Do not wrap lines. Lines will extend horizontally.
-- Generally preferred for code and configuration files.

vim.o.hlsearch = true -- Highlight all matches when searching.
vim.o.incsearch = true -- Show partial matches as you type your search query (incremental search).

vim.o.ignorecase = true -- Ignore case when searching (`/pattern` matches 'Pattern', 'pattern').
vim.o.smartcase = true -- Don't ignore case if your search pattern contains uppercase characters.
-- E.g., `/foo` matches 'Foo', 'foo'; but `/Foo` only matches 'Foo'.

vim.o.cursorline = true -- Highlight the line where the cursor is on.

vim.o.scrolloff = 10 -- Keep a minimal number of screen lines (10) above and below the cursor.
-- Prevents the cursor from sticking to the very top or bottom of the screen.

vim.o.list = true -- Show special characters like tabs (`^I`) and trailing spaces (`$`).
-- Helpful for maintaining clean code.

vim.o.confirm = true -- If performing an operation that would fail due to unsaved changes (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s).

vim.o.undofile = true -- Enable persistent undo. Your undo history is saved across sessions.
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir" -- Specify the directory for persistent undo files.
-- `vim.fn.stdpath("data")` is cross-platform.

vim.opt.splitright = true -- Open new vertical splits to the right of the current window.
vim.opt.splitbelow = true -- Open new horizontal splits below the current window.

-- Create the undo directory if it does not exist.
local undodir = vim.o.undodir
if not vim.fn.isdirectory(undodir) then
	vim.fn.mkdir(undodir, "p")
end

-- Sync clipboard between OS and Neovim.
-- This sets `clipboard='unnamedplus'` which makes Neovim use the system clipboard for yanking/pasting.
-- We schedule it to run after `UIEnter` to potentially improve startup time.
-- Remove this if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		vim.o.clipboard = "unnamedplus"
	end,
})

-- Open neo-tree automatically when Neovim starts without a specific file
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Check if no files were opened and if the current buffer is empty
		if #vim.api.nvim_list_bufs() == 1 and vim.bo.buftype == "" and vim.fn.argv(0) == nil then
			vim.cmd("Neotree")
		end
	end,
	group = vim.api.nvim_create_augroup("NeoTreeAutoOpen", { clear = true }),
	desc = "Open NeoTree on startup if no file is specified",
})

-- [[ Basic Autocommands ]]
-- Autocommands automatically execute commands when certain events occur (e.g., opening a file).
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`.

-- Highlight when yanking (copying) text.
-- When you yank text (`y`), it briefly highlights the yanked text.
-- Try it with `yap` (yank a paragraph) in Normal mode. See `:h vim.hl.on_yank()`.
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank() -- Changed from vim.hl.on_yank() to vim.highlight.on_yank() for consistency with modern APIs
	end,
})

-- [[ Create user commands ]]
-- User commands are custom commands you can define and execute with `:CommandName`.
-- See `:h nvim_create_user_command()` and `:h user-commands`.

-- Create a command `:GitBlameLine` that prints the git blame for the current line.
vim.api.nvim_create_user_command("GitBlameLine", function()
	local line_number = vim.fn.line(".") -- Get the current line number. See `:h line()`.
	local filename = vim.api.nvim_buf_get_name(0) -- Get the current buffer's file path.
	print(vim.fn.system({ "git", "blame", "-L", line_number .. ",+1", filename }))
end, { desc = "Print the git blame for the current line" })

-- [[ Plugin Manager Setup: lazy.nvim ]]
-- This section installs and configures the `lazy.nvim` plugin manager itself.
-- This block MUST be at the very top of your plugin definitions.
require("config.lazy")

-- [[ Add optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by
-- default. You can enable any of them by using the `:packadd` command.
-- These are typically added at the end of the config.

-- For example, to add the "nohlsearch" package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
vim.cmd("packadd! nohlsearch")
-- vim.cmd('source ~/.config/nvim/db_connections.vim')
