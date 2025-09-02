return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- Always run (good defaults)
      python = { "pylint" },
      go = { "golangci-lint" },
      c = { "clangtidy" },
      cpp = { "clangtidy" },
      rust = { "rust-analyzer" },
      sh = { "shellcheck" },
      yaml = { "yamllint" },
      dockerfile = { "hadolint" },

      -- Config-dependent
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    local function file_in_cwd(file_name)
      return vim.fs.find(file_name, {
        upward = true,
        stop = vim.loop.cwd():match("(.+)/"),
        path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
        type = "file",
      })[1]
    end

    local function requires_config(linter_name)
      local config_files = {
        eslint_d = { "eslint.config.js", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" },
      }
      return config_files[linter_name]
    end

    local function filter_linters(linters)
      local active = {}
      for _, linter in ipairs(linters or {}) do
        local configs = requires_config(linter)
        if not configs then
          table.insert(active, linter) -- always run
        else
          for _, f in ipairs(configs) do
            if file_in_cwd(f) then
              table.insert(active, linter)
              break
            end
          end
        end
      end
      return active
    end

    local function try_linting()
      local linters = lint.linters_by_ft[vim.bo.filetype]
      lint.try_lint(filter_linters(linters))
    end

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = try_linting,
    })

    vim.keymap.set("n", "<leader>l", try_linting, { desc = "Trigger linting for current file" })
  end,
}

