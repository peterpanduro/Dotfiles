-- core.keymaps

local map = vim.keymap.set

map("n", "<leader>pv", vim.cmd.Ex, { desc = "Netrw" })
map("n", "<esc>", ":noh<cr>", { silent = true })
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- delete single character without copying into register
map("n", "x", '"_x')

-- Yank to system clipboard
map("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- Buffers
map("n", "<leader>bd", ":bd<cr>", { desc = "Deload buffer" })
map("n", "<leader>bn", ":bn<cr>", { desc = "Next Buffer" })
map("n", "<leader>bp", ":bp<cr>", { desc = "Previous Buffer" })

-- Window management
map("n", "<leader>wh", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>wv", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>we", "<C-w>=", { desc = "Make split windows equal size" })
map("n", "<leader>wq", ":close<CR>", { silent = true, desc = "Close current window" })

-- Move lines with Alt
map("n", "<A-j>", "mz:m+<CR>`z==")
map("n", "<A-k>", "mz:m-2<CR>`z==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("i", "<A-j>", "<Esc>:m+<CR>==gi")
map("i", "<A-k>", "<Esc>:m-2<CR>==gi")
map("n", "<A-down>", "mz:m+<CR>`z==")
map("n", "<A-up>", "mz:m-2<CR>`z==")
map("v", "<A-down>", ":m '>+1<CR>gv=gv")
map("v", "<A-up>", ":m '<-2<CR>gv=gv")
map("i", "<A-down>", "<Esc>:m+<CR>==gi")
map("i", "<A-up>", "<Esc>:m-2<CR>==gi")

-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
