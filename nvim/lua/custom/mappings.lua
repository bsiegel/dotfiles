local map = require("core.utils").map

-- substitute
map("n", "cp", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
map("n", "cpp", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
map("x", "cp", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

-- hop
map('n', 'hw', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
map('n', 'Hw', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
map('n', 'hhw', "<cmd>lua require'hop'.hint_words()<cr>", {})
map('n', 'h/', "<cmd>lua require'hop'.hint_patterns({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
map('n', 'H/', "<cmd>lua require'hop'.hint_patterns({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
map('n', 'hh/', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
map('n', 'hc', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
map('n', 'Hc', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
map('n', 'hhc', "<cmd>lua require'hop'.hint_char2()<cr>", {})
map('o', 'hw', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
map('o', 'Hw', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
map('o', 'hhw', "<cmd>lua require'hop'.hint_words()<cr>", {})
map('o', 'h/', "<cmd>lua require'hop'.hint_patterns({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
map('o', 'H/', "<cmd>lua require'hop'.hint_patterns({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
map('o', 'hh/', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
map('o', 'hc', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
map('o', 'Hc', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
map('o', 'hhc', "<cmd>lua require'hop'.hint_char2()<cr>", {})
