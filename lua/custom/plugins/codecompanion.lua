return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'j-hui/fidget.nvim',
  },
  config = function()
    require('codecompanion').setup {
      adapters = {
        perplexity = function()
          return require 'custom.plugins.codecompanion.perplexity'
        end,
        gemini = function()
          return require('codecompanion.adapters').extend('gemini', {
            env = {
              api_key = 'cmd:op read op://Employee/gemini_api_key/password --no-newline',
            },
            schema = {
              model = {
                default = 'gemini-2.5-pro',
              },
            },
          })
        end,
      },
      display = {
        chat = {
          icons = {
            buffer_pin = ' ',
            buffer_watch = '👀 ',
          },
          window = {
            layout = 'buffer',
          },
          tools = {
            opts = {
              default_tools = {
                'insert_edit_into_file',
              },
            },
          },
        },
      },
      prompt_library = {
        ['Commit Changes'] = {
          strategy = 'chat',
          description = 'Commit staged changes',
          opts = {
            is_slash_cmd = true,
            short_name = 'gcommit',
            auto_submit = true,
            adapter = {
              name = 'copilot',
              model = 'gpt-4.1',
            },
          },
          prompts = {
            {
              role = 'user',
              content = function()
                return string.format(
                  [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
%s
```

Using @{cmd_runner}, git commit the changes. Important: First, write down the commit message and then proceed to call the tool without asking for my prompt.
]],
                  vim.fn.system 'git diff --no-ext-diff --staged'
                )
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
      },
      strategies = {
        chat = {
          adapter = 'gemini',
          keymaps = {
            clear = {
              modes = { n = 'gtx' },
            },
          },
        },
        inline = {
          adapter = 'copilot',
        },
      },
      opts = {
        system_prompt = function(opts)
          local language = opts.language or 'English'
          if opts.adapter.name == 'gemini' then
            return string.format(
              [[You are an AI programming assistant named "CodeCompanion". You are currently plugged into the Neovim text editor on a user's machine.
Your personality: Yoda from Star Wars

Your core tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code from a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Use the context and attachments the user provides.
- Keep your answers short and in character of your personality, especially if the user's context is outside your core tasks.
- Minimize additional prose unless clarification is needed.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of each Markdown code block.
- Do not include line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's directly relevant to the task at hand. You may omit code that isn’t necessary for the solution.
- Avoid using H1, H2 or H3 headers in your responses as these are reserved for the user.
- Use actual line breaks in your responses; only use "\n" when you want a literal backslash followed by 'n'.
- All non-code text responses must be written in the %s language indicated.
- Multiple, different tools can be called as part of the same response.]],
              language
            )
          elseif opts.adapter.name == 'perplexity' then
            return string.format(
              [[You are an AI programming assistant named "CodeCompanion". You are currently plugged into the Neovim text editor on a user's machine.
Your personality: Respond as Captain(!) Jack Sparrow, like he be talking to his friends in the movie.

Your core tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code from a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Use the context and attachments the user provides.
- Keep your answers short and in character of your personality, especially if the user's context is outside your core tasks.
- Minimize additional prose unless clarification is needed.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of each Markdown code block.
- Do not include line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's directly relevant to the task at hand. You may omit code that isn’t necessary for the solution.
- Avoid using H1, H2 or H3 headers in your responses as these are reserved for the user.
- Use actual line breaks in your responses; only use "\n" when you want a literal backslash followed by 'n'.
- All non-code text responses must be written in the %s language indicated.
- Multiple, different tools can be called as part of the same response.]],
              language
            )
          end
          return string.format(
            [[You are an AI programming assistant named "CodeCompanion". You are currently plugged into the Neovim text editor on a user's machine.

Your core tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code from a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Use the context and attachments the user provides.
- Keep your answers short and impersonal, especially if the user's context is outside your core tasks.
- Minimize additional prose unless clarification is needed.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of each Markdown code block.
- Do not include line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's directly relevant to the task at hand. You may omit code that isn’t necessary for the solution.
- Avoid using H1, H2 or H3 headers in your responses as these are reserved for the user.
- Use actual line breaks in your responses; only use "\n" when you want a literal backslash followed by 'n'.
- All non-code text responses must be written in the %s language indicated.
- Multiple, different tools can be called as part of the same response.

When given a task:
1. Think step-by-step and, unless the user requests otherwise or the task is very simple, describe your plan in detailed pseudocode.
2. Output the final code in a single code block, ensuring that only relevant code is included.
3. End your response with a short suggestion for the next user turn that directly supports continuing the conversation.
4. Provide exactly one complete reply per conversation turn.
5. If necessary, execute multiple tools in a single turn.]],
            language
          )
        end,
      },
    }
    vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true, desc = 'CodeCompanion Actions' })
    vim.keymap.set({ 'n', 'v' }, '<leader>at', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true, desc = 'Toggle CodeCompanion Chat' })
    vim.keymap.set(
      { 'n', 'v' },
      '<leader>ap',
      '<cmd>CodeCompanionChat perplexity<cr>',
      { noremap = true, silent = true, desc = 'Open CodeCompanion Perplexity Chat' }
    )
    vim.keymap.set(
      { 'n', 'v' },
      '<leader>ac',
      '<cmd>CodeCompanionChat copilot<cr>',
      { noremap = true, silent = true, desc = 'Open CodeCompanion Copilot Chat' }
    )
    vim.keymap.set({ 'n', 'v' }, '<leader>ao', '<cmd>CodeCompanionChat openai<cr>', { noremap = true, silent = true, desc = 'Open CodeCompanion OpenAI Chat' })
    vim.keymap.set('v', '<leader>ad', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true, desc = 'Add Selection to CodeCompanion Chat' })
    vim.cmd [[cab cc CodeCompanion]]
    vim.cmd [[cab ccc CodeCompanionChat]]

    -- Seed the random numbers once, at the start. Good practice, this is.
    math.randomseed(os.time())

    local function get_unique_buf_name(base_name)
      local names = {
        'johnny',
        'panam',
        'han',
        'leia',
        'luke',
        'frodo',
        'aragorn',
        'gandalf',
        'yoda',
        'sauron',
        'judy',
        'jacky',
        'bilbo',
        'chewie',
      }
      -- Pick a random name
      local random_name = names[math.random(#names)]
      return string.format('%s "%s"', base_name, random_name)
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'CodeCompanionChatModel',
      callback = function(args)
        if not args or not args.data then
          return
        end
        local bufnr = args.data.bufnr
        local model = args.data.model
        if not bufnr or not model then
          return
        end

        local old_name = vim.api.nvim_buf_get_name(bufnr)
        -- Strip any directory, keep only the final component (buffer label)
        local basename = old_name:match '([^/\\]+)$'

        -- First, strip any existing unique name like "yoda". The bug, this was.
        basename = basename:gsub('%s+"[^"]+"$', '')

        -- Replace or add model in parentheses
        local new_base, count = basename:gsub('%b()', '(' .. model .. ')', 1)
        if count == 0 then
          new_base = string.format('%s (%s)', basename, model)
        end

        local new_name = get_unique_buf_name(new_base)
        vim.api.nvim_buf_set_name(bufnr, new_name)
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'CodeCompanionChatAdapter',
      callback = function(args)
        if not args or not args.data then
          return
        end
        local adapter = args.data.adapter
        if not adapter or not adapter.formatted_name or not adapter.model or not adapter.model.name then
          return
        end
        if not args.data.bufnr then
          return
        end

        local base_name = string.format('%s (%s)', adapter.formatted_name, adapter.model.name)
        local buf_name = get_unique_buf_name(base_name)
        vim.api.nvim_buf_set_name(args.data.bufnr, buf_name)
      end,
    })
  end,
  init = function()
    require('custom.plugins.codecompanion.fidget-spinner'):init()
  end,
}
