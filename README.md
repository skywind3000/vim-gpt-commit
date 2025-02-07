# Preface

Generate proper git commit message using ChatGPT (or [Ollama](https://github.com/ollama/ollama)) in Vim:

![](https://skywind3000.github.io/images/p/misc/2024/gptcommit1.gif)

This plugin provides a `:GptCommit` command to generate commit message and append in the current buffer.

Usually, it can be used when editing the `COMMIT_EDITMSG` file, or in a fugitive commit window.

## Quick start

For vim-plug:

```vimL
Plug 'skywind3000/vim-gpt-commit'

let g:gpt_commit_key = 'Your openai apikey'
" uncomment this line below to enable proxy
" let g:gpt_commit_proxy = 'socks5://127.0.0.1:1080'

" uncomment the following lines if you want to use Ollama:
" let g:gpt_commit_engine = 'ollama'
" let g:gpt_commit_ollama_url = 'http://127.0.0.1:11434/api/chat'
" let g:gpt_commit_ollama_model = 'llama2'
```

For lazy:

```lua
{
    'skywind3000/vim-gpt-commit',
    config = function ()
        -- if you don't want to set your api key directly, add to your .zshrc:
        -- export OPENAI_API_KEY='sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
        vim.g.gpt_commit_key = os.getenv("OPENAI_API_KEY")
        -- uncomment this line below to enable proxy
        -- vim.g.gpt_commit_proxy = 'socks5://127.0.0.1:1080'

        -- uncomment the following lines if you want to use Ollama:
        -- vim.g.gpt_commit_engine = 'ollama'
        -- vim.g.gpt_commit_ollama_url = 'http://127.0.0.1:11434/api/chat'
        -- vim.g.gpt_commit_ollama_model = 'llama2'
    end,
},
```

Requirements:

- Python: A Python 3 executable binary needs to be located in your `$PATH`, but vim's `+python3` feature is not required.

## Command

This plugin provides only one command:

```VimL
:GptCommit[!] [repo_path]
```

It will generate git commit message and append to the current cursor position. If the `repo_path` is omitted, the directory name of the current buffer will be used.

If the bang (`!`) is included, `:GptCommit` will not append any text to the current buffer, instead, it will only store the messages in the unnamed register (`*`). You can use them any time manually by `"*p` or display the content by:

```VimL
:echo @*
```

You will see the result in the command line.

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
| g:gpt_gpt_commit_max_logs | - | `0` | max log history (git log) use as context |
| g:gpt_commit_url | - | `''` | alternative request URL, see #1 |
| g:gpt_commit_python | - | `''` | specify the Python executable file explicitly |
| g:gpt_commit_engine | - | `'chatgpt'` | change to 'ollama' to use Ollama |
| g:gpt_commit_ollama_model | Yes | `''` | ollama model |
| g:gpt_commit_ollama_url | - | `''` | explicitly setting ollama URL|

Note #1: the default URL is "https://api.openai.com", can be changed by setting `g:gpt_commit_url`.

## Script

For command line usage, you can execute `gptcommit.py` in the `bin` directory:

```
usage: python3 gptcommit.py <options> repo_path
available options:
  --key=xxx       required, your openai apikey
  --staged        optional, use staged diff if present
  --proxy=xxx     optional, proxy support
  --maxline=num   optional, max diff lines to feed ChatGPT, default ot 160
  --model=xxx     optional, can be gpt-3.5-turbo (default) or something
  --lang=xxx      optional, output language
  --concise       optional, generate concise message if present
  --utf8          optional, output utf-8 encoded text if present
  --url=xxx       optional, alternative openai request url
  --maxlogs=num   optional, use git <num> log entries to enrich the context
```

It can be integrated into other editors. 

## Credit

If you find this plugin amusing, you might also be interested in my other vim plugins, such as:

- [vim-auto-popmenu](https://github.com/skywind3000/vim-auto-popmenu): Display the completion menu automantically.
- [vim-color-export](https://github.com/skywind3000/vim-color-export): A tool to backport NeoVim colorschemes to Vim. 
- [vim-navigator](https://github.com/skywind3000/vim-navigator): Navigate your commands easily.
- [vim-rt-format](https://github.com/skywind3000/vim-rt-format): Prettify current line when you press Enter.
- [vim-quickui](https://github.com/skywind3000/vim-quickui): The missing UI extensions for Vim 8.2 (and NeoVim 0.4).
- [asynctasks.vim](https://github.com/skywind3000/asynctasks.vim): Modern task system for project building/testing/deploying.


