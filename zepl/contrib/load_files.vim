" Description:  Load files into the REPL.
" File:         zepl/contrib/load_file.vim
" Help:         :help zepl-load_files
" Legal:        No rights reserved.  Public domain.

function! zepl#contrib#load_files#load(...) abort
    " The dictionary entry identifying the command to laod a file
    let loader_cmd_varname = 'load_file'

    " Check buffer-local config, then global config
    if exists('b:repl_config') && has_key(b:repl_config, &filetype)
      let config_entry = b:repl_config[&filetype]
    elseif exists('g:repl_config') && has_key(g:repl_config, &filetype)
      let config_entry = g:repl_config[&filetype]
    else
      echoerr 'Neither b:repl_config nor g:repl_config has a definition for the filetype "'.&filetype.'"'
      return
    endif

    if has_key(config_entry, loader_cmd_varname)
      let load_cmd = config_entry[loader_cmd_varname]

      let fns = (a:0 > 0 ? a:000 : [expand('%')])
      let fns = map(copy(fns), 'fnamemodify(expand(v:val), ":p")')
      " let fns = filter(uniq(copy(fns)), 'filereadable(v:val)')
      let cmds = map(copy(fns), 'printf(load_cmd, v:val)')
      call zepl#send(cmds)
    else
      echoerr 'Neither b:repl_config nor g:repl_config has "load_file" defined.'
    endif
endfunction

command! -nargs=* -complete=file -bar ReplLoadFile :call zepl#contrib#load_files#load(<f-args>)

nnoremap <silent> <Plug>ReplLoadFile :<C-u>ReplLoadFile<CR>

if get(g:, 'zepl_default_maps', 1)
    nmap <silent> gz. <Plug>ReplLoadFile
endif
