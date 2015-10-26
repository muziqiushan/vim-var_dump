" echom &ft
" if (&ft =~ '\(php\|smarty\)$')
"     nnoremap <buffer> <C-x> :call <SID>debug("var_dump(",");","$,-,>,.")<CR>
"     nnoremap <buffer> <C-d> :call <SID>debug("var_dump(",");exit;","$,-,>,.")<CR>
"     nnoremap <buffer> <C-e> :call <SID>debug("echo json_encode(",");exit;","$,-,>,.")<CR>
" elseif(&ft =~ "javascript$")
"     nnoremap <buffer> <C-x> :call <SID>debug("console.log(",");","-,.,[,]")<CR>
" elseif(&ft =~ "cpp$")
"     nnoremap <buffer> <C-x> :call <SID>debug("cout<<","<<endl")<CR>
" endif
function! Debug(...)
    let cur_line_num = line('.')
    let next_line = getline(cur_line_num+1)
    let flag = match(next_line,'^\s*{') 
    let tmp_pos = getpos('.')
    let debug_prefix = (a:0 >= 1)?(a:1):""
    let debug_suffix = (a:0 >= 2)?(a:2):""
    let keyword_suffix = (a:0 >= 3)?(a:3):""
	execute 'setl iskeyword +='.keyword_suffix
    let debug_str = debug_prefix.expand("<cword>").debug_suffix
    if (flag >= 0)
        " echom "has {}"
        " echom string(tmp_pos)
        call append(cur_line_num+1,debug_str)
        let tmp_pos[1] = cur_line_num+2
        " let tmp_pos[2] = 0
        " echom string(tmp_pos)
        " echom type(tmp_pos)
        " call setpos('.',tmp_pos)
    else
        call append(cur_line_num,debug_str)
        let tmp_pos[1] = cur_line_num+1
    endif
    call setpos('.',tmp_pos)
    exec ":w"
    normal ==
	setl iskeyword<
endfunction
