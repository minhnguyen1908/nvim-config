return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional, for image previews
    },
    config = function()
        -- If you want icons for diagnostics columns, you'll need to find a plugin that provides them.
        -- For example:
        --   "nvim-tree/nvim-web-devicons",
        --   "kyazdani42/nvim-web-devicons",
        vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

        require("neo-tree").setup({
            close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
            sort_case_insensitive = false, -- used when sorting files and directories in the tree
            sort_function = nil, -- use a custom function for sorting files and directories in the tree
            -- sort_function = function (a,b)
            --       if a.type == b.type then
            --           return a.path > b.path
            --       else
            --           return a.type > b.type
            --       end
            --   end , -- this sorts files and directories descendantly
            default_component_configs = {
                container = {
                    enable_character_fade = true,
                },
                indent = {
                    indent_size = 2,
                    padding = 1, -- extra padding on left hand side
                    -- indent guides
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeIndentMarker",
                    -- expander config, needed for nesting files
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "󰜌",
                    -- The next two settings are only used if you have a file system provider that can provide file content.
                    -- They are used to render the icons for open and closed files respectively.
                    file_open = "󰈔",
                    file_closed = "   閉",
                },
                modified = {
                    symbol = "[+]",
                    highlight = "NeoTreeModified",
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = "",
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                        deleted = "✖", -- this can only be used in the git_status source
                        renamed = "󰁕", -- this can only be used in the git_status source
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = "󰄱",
                        staged = "",
                        conflict = "",
                    },
                },
            },
            -- A list of functions, each representing a global keymap.
            -- A keymap consists of a key, a function that is executed when the key is pressed, and a description.
            -- The function receives the state of the tree as its only argument.
            -- The description is used to generate the help text.
            -- The keymaps are evaluated in the order they are defined.
            -- You can set `enabled = false` for any keymap to disable it.
            --
            -- You can also specify the source of the keymap, which is the name of the source that the keymap is active for.
            -- If the source is not specified, the keymap is active for all sources.
            --
            -- The available sources are:
            --   "filesystem",
            --   "buffers",
            --   "git_status",
            --   "document_symbols",
            --
            -- The available actions are:
            --   "open",
            --   "open_vsplit",
            --   "open_hsplit",
            --   "open_tabnew",
            --   "close_node",
            --   "focus",
            --   "expand",
            --   "collapse",
            --   "toggle_node",
            --   "prev_sibling",
            --   "next_sibling",
            --   "parent",
            --   "first_child",
            --   "last_child",
            --   "prev_source",
            --   "next_source",
            --   "refresh",
            --   "cut",
            --   "copy",
            --   "paste",
            --   "rename",
            --   "delete",
            --   "new_file",
            --   "new_directory",
            --   "close_window",
            --   "toggle_hidden",
            --   "toggle_filter",
            --   "toggle_git_ignored",
            --   "toggle_git_untracked",
            --   "toggle_diagnostics",
            --   "show_help",
            --
            window = {
                position = "left",
                width = 40,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ['Y'] = function(state)
                        -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
                        -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
                        local node = state.tree:get_node()
                        local filepath = node:get_id()
                        local filename = node.name
                        local modify = vim.fn.fnamemodify

                        local results = {
                            filepath,
                            modify(filepath, ':.'),
                            modify(filepath, ':~'),
                            filename,
                            modify(filename, ':r'),
                            modify(filename, ':e'),
                        }

                        -- absolute path to clipboard
                        local i = vim.fn.inputlist({
                            'Choose to copy to clipboard:',
                            '1. Absolute path: ' .. results[1],
                            '2. Path relative to CWD: ' .. results[2],
                            '3. Path relative to HOME: ' .. results[3],
                            '4. Filename: ' .. results[4],
                            '5. Filename without extension: ' .. results[5],
                            '6. Extension of the filename: ' .. results[6],
                        })

                        if i > 0 then
                            local result = results[i]
                            if not result then return print('Invalid choice: ' .. i) end
                            vim.fn.setreg('"', result)
                            vim.notify('Copied: ' .. result)
                        end
                    end,
                    ["<space>"] = {
                        "toggle_node",
                        nowait = false, -- disable `nowait` if you have existing combos starting with <space>
                    },
                    ["<2-LeftMouse>"] = "open",
                    ["<cr>"] = "open",
                    ["<esc>"] = "cancel", -- close preview or floating neo-tree window
                    ["P"] = {
                        "toggle_preview",
                        config = { use_float = true, use_image_nvim = true },
                    },
                    -- Read `#mappings` for possible actions
                    ["S"] = "open_split",
                    ["s"] = "open_vsplit",
                    -- ["S"] = "split_with_window_picker",
                    -- ["s"] = "vsplit_with_window_picker",
                    ["t"] = "open_tabnew",
                    -- ["<cr>"] = "open_drop",
                    -- ["t"] = "open_tab_drop",
                    ["w"] = "open_with_window_picker",
                    --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
                    ["l"] = "focus_preview",
                    ["L"] = "close_node",
                    -- ['l'] = 'open' -- you can disable default table keybindings and map your own like this
                    ["a"] = {
                        "add",
                        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc).
                        -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/input#brace-expansion
                        config = {
                            show_path = "none", -- "none", "relative", "absolute"
                        },
                    },
                    ["A"] = "add_directory", -- also accepts the config.show_path option.
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["c"] = "copy", -- copy submitted node to clipboard
                    ["m"] = "move", -- move submitted node to clipboard
                    ["q"] = "close_window",
                    ["R"] = "refresh",
                    ["?"] = "show_help",
                    ["<"] = "prev_source",
                    [">"] = "next_source",
                    ["i"] = "show_file_details",
                },
            },
            nesting_rules = {},
            filesystem = {
                filtered_items = {
                    visible = false, -- when true, they will be rendered with grey color
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_hidden = false, -- only works on Windows for hidden files/directories
                    hide_by_name = {
                        --"node_modules"
                    },
                    hide_by_pattern = { -- uses glob style patterns
                        --"*.meta",
                        --"*/src/*/tsconfig.json",
                    },
                    always_show = { -- remains visible even if other settings would hide it
                        --".gitignored",
                    },
                    never_show = { -- remains hidden even if other settings would show it
                        --".DS_Store",
                        --"thumbs.db"
                    },
                    never_show_by_pattern = { -- uses glob style patterns
                        --".null-ls_*",
                    },
                },
                follow_current_file = {
                    enabled = false, -- This will find and focus the file in the active buffer every
                    -- time the current file is changed while the tree is open.
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                group_empty_dirs = false, -- when true, empty folders will be grouped together
                hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                -- in whatever position is specified in window.position
                -- "open_current",  -- netrw disabled, opening a directory opens within the current window
                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                -- instead of relying on nvim autocmd events.
                window = {
                    mappings = {
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["H"] = "toggle_hidden",
                        ["/"] = "fuzzy_finder",
                        ["D"] = "fuzzy_finder_directory",
                        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the loaded sorter
                        ["f"] = "filter_on_submit",
                        ["<c-x>"] = "clear_filter",
                        ["[g"] = "prev_git_modified",
                        ["]g"] = "next_git_modified",
                        ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                        ["oc"] = { "order_by_created", nowait = false },
                        ["od"] = { "order_by_diagnostics", nowait = false },
                        ["og"] = { "order_by_git_status", nowait = false },
                        ["om"] = { "order_by_modified", nowait = false },
                        ["on"] = { "order_by_name", nowait = false },
                        ["os"] = { "order_by_size", nowait = false },
                        ["ot"] = { "order_by_type", nowait = false },
                    },
                    fuzzy_finder_mappings = { -- define keymaps for filter popup
                        ["<down>"] = "move_cursor_down",
                        ["<C-n>"] = "move_cursor_down",
                        ["<up>"] = "move_cursor_up",
                        ["<C-p>"] = "move_cursor_up",
                    },
                },

                commands = {}, -- Add custom commands here
            },
            buffers = {
                follow_current_file = {
                    enabled = true, -- This will find and focus the file in the active buffer every
                    -- time the current file is changed while the tree is open.
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                group_empty_dirs = true, -- when true, empty folders will be grouped together
                show_unloaded = true,
                window = {
                    mappings = {
                        ["bd"] = "buffer_delete",
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                    },
                },
            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"] = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gg"] = "git_commit_and_push",
                    },
                },
            },
        })
    end,
}
