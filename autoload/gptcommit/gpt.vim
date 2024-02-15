"======================================================================
"
" gpt.vim - 
"
" Created by skywind on 2024/02/14
" Last Modified: 2024/02/14 14:59:32
"
"======================================================================


"----------------------------------------------------------------------
" errmsg
"----------------------------------------------------------------------
function! s:errmsg(msg)
	call gptcommit#utils#errmsg(a:msg)
endfunc


"----------------------------------------------------------------------
" generate commit message 
"----------------------------------------------------------------------
function! gptcommit#gpt#generate(path) abort
	let args = []
	let apikey = get(g:, 'gpt_commit_key', '')
	if apikey == ''
		call s:errmsg('g:gpt_commit_key is undefined')
		return ''
	endif
	if !isdirectory(a:path)
		call s:errmsg('invalid path: ' .. a:path)
		return ''
	endif
	let args += ['--key=' .. apikey]
	if get(g:, 'gpt_commit_staged', 1)
		let args += ['--staged']
	endif
	let proxy = get(g:, 'gpt_commit_proxy', '')
	if proxy != ''
		let args += ['--proxy=' .. proxy]
	endif
	let maxline = get(g:, 'gpt_commit_max_line', 0)
	if maxline > 0
		let args += ['--maxline=' .. maxline]
	endif
	let model = get(g:, 'gpt_commit_model', '')
	if model != ''
		let args += ['--model=' .. model]
	endif
	let lang = get(g:, 'gpt_commit_lang', '')
	if lang != ''
		let args += ['--lang=' .. lang]
	endif
	if get(g:, 'gpt_commit_concise', 0)
		let args += ['--concise']
	endif
	let prompt = get(g:, 'gpt_commit_prompt', '')
	if prompt != ''
		let args += ['--prompt=' .. prompt]
	endif
	if get(g:, 'gpt_commit_fake', 0)
		let args += ['--fake']
	endif
	let path = a:path
	if has('win32') || has('win64') || has('win95') || has('win16')
		let path = tr(path, '\', '/')
	endif
	let args += [path]
	" echo args
	return gptcommit#utils#request(args)
endfunc


"----------------------------------------------------------------------
" :GptCommit command
"----------------------------------------------------------------------
function! gptcommit#gpt#cmd(bang, path)
	let path = a:path
	if path == ''
		let path = gptcommit#utils#current_path()
	endif
	if path == ''
		call s:errmsg('can not detect path info')
		return 1
	elseif !isdirectory(path)
		call s:errmsg('directory does not exist: ' .. path)
		return 2
	elseif gptcommit#utils#repo_root(path) == ''
		call s:errmsg('not in a git repository: ' .. path) 
		return 3
	endif
	if a:bang == 0
		if gptcommit#utils#buffer_writable() == 0
			call s:errmsg('buffer is not writable')
		endif
	endif
	redraw
	echohl Title
	echo 'Generating commit message ...'
	echohl None
	redraw
	let text = gptcommit#gpt#generate(path)
	if text == ''
		echo ""
		redraw
		return 4
	endif
	if a:bang == 0
		let content = split(text, "\n")
		call append(line('.') - 1, content)
		echohl Title
		echo "Generated"
		echohl None
		redraw
	else
		let @* = text
		echohl Title
		echo 'Generated (saved in the unnamed register, paste manually by "*p).'
		echohl None
		redraw
	endif
	return 0
endfunc


