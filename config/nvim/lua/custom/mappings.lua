local M = {}

M.substitute = {
  n = {
    ["cp"] = {
      function()
        require('substitute').operator()
      end,
      opts = { noremap = true }
    },
    ["cpp"] = {
      function()
        require('substitute').line()
      end,
      opts = { noremap = true }
    }
  },

  x = {
    ["cp"] = {
      function()
        require('substitute').visual()
      end,
      opts = { noremap = true }
    },
  }
}

M.hop = {
  n = {
    ["hw"] = {
      function()
        require('hop').hint_words({
          direction = require('AFTER_CURSOR').HintDirection.AFTER_CURSOR,
          current_line_only = true
        })
      end
    },
    ["Hw"] = {
      function()
        require('hop').hint_words({
          direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
          current_line_only = true
        })
      end
    },
    ["hhw"] = {
      function()
        require('hop').hint_words()
      end
    },
    ["h/"] = {
      function()
        require('hop').hint_patterns({
          direction = require('hop.hint').HintDirection.AFTER_CURSOR,
          current_line_only = true
        })
      end
    },
    ["H/"] = {
      function()
        require('hop').hint_patterns({
          direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
          current_line_only = true
        })
      end
    },
    ["hh/"] = {
      function()
        require('hop').hint_patterns()
      end
    },
    ["hc"] = {
      function()
        require('hop').hint_char1({
          direction = require('hop.hint').HintDirection.AFTER_CURSOR,
          current_line_only = true
        })
      end
    },
    ["Hc"] = {
      function()
        require('hop').hint_char1({
          direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
          current_line_only = true
        })
      end
    },
    ["hhc"] = {
      function()
        require('hop').hint_char2()
      end
    },
  },

  o = {
    ["hw"] = {
      function()
        require('hop').hint_words({
          direction = require('hop.hint').HintDirection.AFTER_CURSOR,
          current_line_only = true
        })
      end
    },
    ["Hw"] = {
      function()
        require('hop').hint_words({
          direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
          current_line_only = true
        })
      end
    },
    ["hhw"] = {
      function()
        require('hop').hint_words()
      end
    },
    ["h/"] = {
      function()
        require('hop').hint_patterns({
          direction = require('hop.hint').HintDirection.AFTER_CURSOR,
          current_line_only = true
        })
      end
    },
    ["H/"] = {
      function()
        require('hop').hint_patterns({
          direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
          current_line_only = true
        })
      end
    },
    ["hh/"] = {
      function()
        require('hop').hint_patterns()
      end
    },
    ["hc"] = {
      function()
        require('hop').hint_char1({
          direction = require('hop.hint').HintDirection.AFTER_CURSOR,
          current_line_only = true
        })
      end
    },
    ["Hc"] = {
      function()
        require('hop').hint_char1({
          direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
          current_line_only = true
        })
      end
    },
    ["hhc"] = {
      function()
        require('hop').hint_char2()
      end
    },
  }
}

return M
