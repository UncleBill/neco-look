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
lua << FILTER
local list = vim.eval('list')
look_ret = vim.list()
for i=1, #list do
    if list[i] and string.find( list[i], "'" ) then
    else
        look_ret:add(list[i])
    end
end
return vim.command("return luaeval('look_ret')")
FILTER
    endif
endfunction
