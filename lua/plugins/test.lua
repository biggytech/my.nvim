return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "adrigzr/neotest-mocha",
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-mocha")({
          command = "npm test --",
          command_args = function(context)
            -- The context contains:
            --   results_path: The file that json results are written to
            --   test_name_pattern: The generated pattern for the test
            --   path: The path to the test file
            --
            -- It should return a string array of arguments
            --
            -- Not specifying 'command_args' will use the defaults below
            return {
              "--full-trace",
              "--reporter=json",
              "--reporter-options=output=" .. context.results_path,
              "--grep=" .. context.test_name_pattern,
              context.path,
            }
          end,
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        })
      )

      opts.output = {
        enabled = true,
      }
      opts.diagnostic = {
        enabled = true,
      }
      opts.status = {
        enabled = true,
      }
      opts.output_panel = {
        enabled = true,
      }
      opts.running = {
        concurrent = true,
      }

      return opts
    end,
    keys = {
      {
        "<leader>tc",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Current Test",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>tL",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Debug Last Test",
      },
      {
        "<leader>tw",
        "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
        desc = "Run Watch",
      },
    },
  },
}
