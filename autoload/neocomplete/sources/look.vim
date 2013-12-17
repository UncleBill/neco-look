let s:source = {
      \ 'name': 'look',
      \ 'kind': 'plugin',
      \ 'mark': '[look]',
      \ 'max_candidates': 15,
      \ 'min_pattern_length' : 3,
      \ 'is_volatile' : 1,
      \ }

function! b:findword(word)
    if strlen(a:word) < 2
        return []
    endif
    let list = split(neocomplete#util#system(
                \ 'look ' . a:word .
                \ '| head -n ' . 15), "\n")
    if len(list) == 0
        return b:findword(a:word[:-2])
    else
        return list
    endif
endfunction

function! s:source.gather_candidates(context)
  if a:context.complete_str !~ '^[[:alpha:]]\+$'
    return []
  endif

  let list = b:findword(a:context.complete_str)
  if neocomplete#util#get_last_status()
    return []
  endif

  return list
endfunction

function! neocomplete#sources#look#define()
  return executable('look') ? s:source : {}
endfunction
