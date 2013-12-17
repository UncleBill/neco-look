let s:source = {
      \ 'name': 'look',
      \ 'kind': 'plugin',
      \ 'mark': '[look]',
      \ 'max_candidates': 15,
      \ 'min_pattern_length' : 3,
      \ 'is_volatile' : 1,
      \ }

function! s:source.gather_candidates(context)
  if a:context.complete_str !~ '^[[:alpha:]]\+$'
    return []
  endif

  let list = halffuzzy#look(a:context.complete_str)
  if neocomplete#util#get_last_status()
    return []
  endif

  return list
endfunction

function! neocomplete#sources#look#define()
  return executable('look') ? s:source : {}
endfunction
