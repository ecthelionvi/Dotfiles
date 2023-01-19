function! MoveToPrevPairs()
let backsearch = '(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>'
let [lnum, col] = searchpos(backsearch, 'Wb')
call setpos('.', [0, lnum, col, 0])
endfunction

 nnoremap <silent> <Tab> <ESC>:call MoveToPrevPairs()<CR>
inoremap <silent> <A-Tab> <ESC>:call MoveToPrevPairs()<CR>i

function! MoveToNextPairs()
let forwardsearch = '(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>'
let [lnum, col] = searchpos(forwardsearch, 'Wn')
call setpos('.', [0, lnum, col, 0])
endfunction

nnoremap <silent> <Tab> <ESC>:call MoveToNextPairs()<CR>
inoremap <silent> <A-Tab> <ESC>:call MoveToNextPairs()<CR>i

""============[ Code Runner ]=============""
nnoremap <silent><expr> <leader>r ((&buftype is# "terminal") ? ":RunClose<CR>" : ":RunCode<CR>")

""==========[ Search Movement ]===========""

nnoremap  <silent><expr> n  'Nn'[v:searchforward] . ":call HLNext()\<CR>"
nnoremap  <silent><expr> N  'nN'[v:searchforward] . ":call HLNext()\<CR>"

""=============[ Schlepp ]================""

vmap <silent><unique> <up>    <Plug>SchleppUp
vmap <silent><unique> <down>  <Plug>SchleppDown
vmap <silent><unique> <left>  <Plug>SchleppLeft
vmap <silent><unique> <right> <Plug>SchleppRight

""==========[ Search Movement ]===========""

noremap <expr> n 'Nn'[v:searchforward]
noremap <expr> N 'nN'[v:searchforward]

""================[ GF ]==================""
      
map gf :edit <cfile><cr>

""==========[ Search-Replace ]============""

nnoremap cn *``cgn
nnoremap cN #``cgN
vnoremap <expr> cn g:mc . "``cgn"
vnoremap <expr> cN g:mc . "``cgN"
let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"

""===============[ Easy ]=================""
      
nnoremap ; :

""=============[ Wildmenu ]===============""

cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"

""===============[ Swap ]=================""

      let s:k_version = 201
      if &cp || (exists('g:loaded_swap_words')
        \ && (g:loaded_swap_words >= s:k_version)
        \ && !exists('g:force_reload_vim_tip_swap_word'))
        finish
      endif
      let g:swap_word_loaded = s:k_version

      nnoremap <silent> fl :call <sid>SwapWithNext('follow', 'w')<cr>
      nnoremap <silent> fh :call <sid>SwapWithPrev('follow', 'w')<cr>

      let s:k_entity_pattern = {}
      let s:k_entity_pattern.w = {}
      let s:k_entity_pattern.w.in = '\w'
      let s:k_entity_pattern.w.out = '\W'
      let s:k_entity_pattern.w.prev_end = '\zs\w\W\+$'
      let s:k_entity_pattern.k = {}
      let s:k_entity_pattern.k.in = '\k'
      let s:k_entity_pattern.k.out = '\k\@!'
      let s:k_entity_pattern.k.prev_end = '\k\(\k\@!.\)\+$'


      function! s:SwapWithNext(cursor_pos, type)
        let s = getline('.')
        let l = line('.')
        let c = col('.')-1
        let in  = s:k_entity_pattern[a:type].in
        let out = s:k_entity_pattern[a:type].out

        let crt_word_start = match(s[:c], in.'\+$')
        let crt_word_end  = match(s, in.out, crt_word_start)
        if crt_word_end == -1
          :normal fh
          return
        endif
        let next_word_start = match(s, in, crt_word_end+1)
        if next_word_start == -1
          :normal fh
          return
        endif
      let next_word_end  = match(s, in.out, next_word_start)
      let crt_word = s[crt_word_start : crt_word_end]
      let next_word = s[next_word_start : next_word_end]

      let s2 = (crt_word_start>0 ? s[:crt_word_start-1] : '')
        \ . next_word
        \ . s[crt_word_end+1 : next_word_start-1]
        \ . crt_word
        \ . (next_word_end==-1 ? '' : s[next_word_end+1 : -1])
      call setline(l, s2)
      if     a:cursor_pos == 'keep'   | let c2 = c+1
      elseif a:cursor_pos == 'follow' | let c2 = c + strlen(next_word) + (next_word_start-crt_word_end)
      elseif a:cursor_pos == 'left'   | let c2 = crt_word_start+1
      elseif a:cursor_pos == 'right'  | let c2 = strlen(next_word) + next_word_start - crt_word_end + crt_word_start
      endif
      call cursor(l,c2)
    endfunction

    function! s:SwapWithPrev(cursor_pos, type)
      let s = getline('.')
      let l = line('.')
      let c = col('.')-1
      let in  = s:k_entity_pattern[a:type].in
      let out = s:k_entity_pattern[a:type].out
      let prev_end = s:k_entity_pattern[a:type].prev_end

      let crt_word_start = match(s[:c], in.'\+$')
        if crt_word_start == -1
          :normal fl
          return
        endif
      let crt_word_end  = match(s, in.out, crt_word_start)
      let crt_word = s[crt_word_start : crt_word_end]

      let prev_word_end = match(s[:crt_word_start-1], prev_end)
      let prev_word_start = match(s[:prev_word_end], in.'\+$')
        if prev_word_end == -1
          :normal fl
          return
        endif
      let prev_word = s[prev_word_start : prev_word_end]

      let s2 = (prev_word_start>0 ? s[:prev_word_start-1] : '')
        \ . crt_word
        \ . s[prev_word_end+1 : crt_word_start-1]
        \ . prev_word
        \ . (crt_word_end==-1 ? '' : s[crt_word_end+1 : -1])
      call setline(l, s2)
      if     a:cursor_pos == 'keep'   | let c2 = c+1
      elseif a:cursor_pos == 'follow' | let c2 = prev_word_start + c - crt_word_start + 1
      elseif a:cursor_pos == 'left'   | let c2 = prev_word_start+1
      elseif a:cursor_pos == 'right'  | let c2 = strlen(crt_word) + crt_word_start - prev_word_end + prev_word_start
      endif
      call cursor(l,c2)
    endfunction