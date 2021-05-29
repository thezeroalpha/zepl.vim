" Description:  Hacky workaround to make Neovim's terminal autoscroll.
" File:         zepl/contrib/nvim_autoscroll_hack.vim
" Help:         :help zepl-nvim_autoscroll_hack
" Legal:        No rights reserved.  Public domain.

augroup zepl_autoscroll
    autocmd!

    " This doesn't work (for some reason) so I have to remap keys instead.
    " autocmd TermLeave,InsertLeave zepl:* normal! G

    autocmd TermEnter zepl:* tnoremap <C-\><C-n> <C-\><C-n>G
    autocmd TermEnter zepl:* tnoremap <C-\><C-N> <C-\><C-n>G
augroup END
