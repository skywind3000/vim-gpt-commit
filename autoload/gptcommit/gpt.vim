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
	let args += [a:path]
	" echo args
	return gptcommit#utils#request(args)
endfunc


"----------------------------------------------------------------------
" 
"----------------------------------------------------------------------
function! gptcommit#gpt#cmd(path)

endfunc

