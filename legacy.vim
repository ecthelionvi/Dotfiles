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

