function! halffuzzy#look(word)
    if strlen(a:word) < 1
        return []
    endif
    let list = split(neocomplete#util#system(
                \ 'look ' . a:word .
                \ '| head -n 15'), "\n")
    if len(list) == 0
        return halffuzzy#look(a:word[:-2])
    else
        return filter(list, 'v:val !~ "''"')
    endif
endfunction
