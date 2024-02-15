# Preface

Generate proper git commit message using ChatGPT in Vim

## Quick start

For vim-plug:

```vimL
Plug 'skywind3000/vim-gpt-commit'

let g:gpt_commit_key = 'Your open apikey'
" uncomment this line below to enable proxy
" let g:gpt_commit_proxy = 'socks5://127.0.0.1:1080'
```

For lazy:

```lua
{
    'skywind3000/vim-gpt-commit',
    config = function () 
        vim.g.gpt_commit_key = 'Your openai apikey'
        -- uncomment this line below to enable proxy
        -- vim.g.gpt_commit_proxy = 'socks5://127.0.0.1:1080'
    end,
},
```

## Command

This plugin provides only one command:

```VimL
:GptCommand[!] [repo_path]
```

It will generate git commit message and append to the current cursor position. If the `repo_path` is omitted, the directory name of the current buffer will be used.

If the bang (`!`) is included, `:GptCommand` will not append any text to the current buffer, instead, it will only store the messages in the unnamed register (`*`). You can use them any time manually by `"*p` or display the content by:

```VimL
:echo @*
```

## Options

| Name | Required | Default | Description |
|-|-|-|-|
| g:gpt_commit_key | Yes | `''` | Your openai apikey |
| g:gpt_commit_proxy | - | `''` | proxy |
| g:gpt_commit_concise | - | `0` | set to 1 to generate less verbose message |
| g:gpt_commit_lang | - | `''` | output language |
| g:gpt_commit_model | - | `'gpt-3.5-turbo'` | ChatGPT model |
| g:gpt_commit_staged | - | `1` | set to 1 to use staged diff |
| g:gpt_commit_max_line | - | `160` | max diff lines to reference |

## Credit

