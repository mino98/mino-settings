" .vimrc

" Reference keys (to print out and put above your keyboard! ;):
"
"         F1      F2      F3      F4      F5      F6      F7      F8      F9     F10     F11     F12
" UnMod NxFile HighSrc Search  SetPaste CopyLn  NxWind SplitWn  Format   HilCor Save   NxTAGWn  NxTAG
" Shift PrFile HighChr Src ID  Cmp CTAG PasteLn PrWind BrowsSpl Reindent UnlCor SaveQ  CloseWn  PrTAG
"

set backupskip=/tmp/*,/private/tmp/*" 

" first clear any existing autocommands:
autocmd!

"----------------------------
" Added by mino:
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
set ruler
set showcmd
set number
"----------------------------

" * User Interface

" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
  syntax on
endif

" have 100 lines of command-line (etc) history:
set history=100

" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=%,/10,'100,r/mnt/cdrom,r/mnt/floppy,f1,h,\"100

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess=aoI

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd
set showbreak=@

" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

" have the mouse enabled all the time:
" set mouse=n
" set mousemodel=popup_setpos

" don't have files trying to override this .vimrc:
set nomodeline

" scroll 2 lines before end of file.. ;)
set so=2
set sidescroll=12

" Backups in ~/.vimbakups dir (comment following 3 lines to disable backups)
"set backup
"set backupext=.bak
"set backupdir=~/.vimbackups

" source $VIMRUNTIME/ftplugin/man.vim
runtime macros/justify.vim
set tags=./tags,./../tags,./../../tags,./../../../tags,tags,/usr/include/tags,/usr/src/linux/tags

" * Text Formatting -- General

" don't make it look like there are line breaks where there aren't:
set nowrap

" use indents of 2 spaces, and have them copied down lines:
set shiftwidth=2
set tabstop=4 
set shiftround
set expandtab
set autoindent

" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions-=t
set textwidth=79

" get rid of the default style of C comments, and define a style with two stars
" at the start of `middle' rows which (looks nicer and) avoids asterisks used
" for bullet lists being treated like C comments; then define a bullet list
" style for single stars (like already is for hyphens):
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*

" treat lines starting with a quote mark as comments (for `Vim' files, such as
" this very one!), and colons as well so that reformatting usenet messages from
" `Tin' users works OK:
set comments+=b:\"
set comments+=n::


" * Text Formatting -- Specific File Formats

" enable filetype detection:
filetype on

" recognize anything in my .Postponed directory as a news article, and anything
" at all with a .txt extension as being human-language text [this clobbers the
" `help' filetype, but that doesn't seem to prevent help from working
" properly]:
augroup filetype
  autocmd BufNewFile,BufRead */.Postponed/* set filetype=mail
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END

" Ritorna all'ultima posizione precedente di un file editato 
autocmd BufReadPost * if line("'\"") | exe "'\"" | endif

" in human-language files, automatically format everything at 72 chars:
autocmd FileType mail,human set formatoptions+=t textwidth=72

" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang set cindent
" and extended ctag listing
autocmd FileType c,cpp,slang set showfulltag 
" and set indent as folded elements for F1
autocmd FileType c,cpp,slang set foldmethod=indent
autocmd FileType c,cpp,slang set foldlevel=999

" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c set formatoptions+=ro

" for Perl programming, have things in braces indenting themselves:
autocmd FileType perl set smartindent

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
autocmd FileType html set formatoptions+=tl

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
autocmd FileType html,css set noexpandtab tabstop=2

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8

" File tipe definition for boiler project by Zad ;)
" boiler
autocmd BufNewFile,BufRead *.bt,*.bl,*.bi :set syntax=c

" * Search & Replace

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

" assume the /g flag on :s substitutions to replace all matches in a line:
"set gdefault

" higlight search
set hlsearch


" * Spelling

" define `Ispell' language and personal dictionary, used in several places
" below:
let IspellLang = 'british'
let PersonalDict = '~/.ispell_' . IspellLang

" try to avoid misspelling words in the first place -- have the insert mode
" <Ctrl>+N/<Ctrl>+P keys perform completion on partially-typed words by
" checking the Linux word list and the personal `Ispell' dictionary; sort out
" case sensibly (so that words at starts of sentences can still be completed
" with words that are in the dictionary all in lower case):
execute 'set dictionary+=' . PersonalDict
set dictionary+=/usr/dict/words
set complete=.,w,k
set infercase

" In visual mode, substitute selected text with yyanked one =)
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" mappa gf per andare nel file sotto al cursore ma aprire una nuova finestra
map gf :sfind <cfile><CR>

" Spell checking operations are defined next.  They are all set to normal mode
" keystrokes beginning \s but function keys are also mapped to the most common
" ones.  The functions referred to are defined at the end of this .vimrc.

" \si ("spelling interactive") saves the current file then spell checks it
" interactively through `Ispell' and reloads the corrected version:
execute 'nnoremap \si :w<CR>:!ispell -x -d ' . IspellLang . ' %<CR>:e<CR><CR>'

" \sl ("spelling list") lists all spelling mistakes in the current buffer,
" but excludes any in news/mail headers or in ("> ") quoted text:
execute 'nnoremap \sl :w ! grep -v "^>" <Bar> grep -E -v "^[[:alpha:]-]+: " ' .
  \ '<Bar> ispell -l -d ' . IspellLang . ' <Bar> sort <Bar> uniq<CR>'

" \sh ("spelling highlight") highlights (in red) all misspelt words in the
" current buffer, and also excluding the possessive forms of any valid words
" (EG "Ilda's" won't be highlighted if "Ilda" is in the dictionary); with
" mail and news messages it ignores headers and quoted text; for HTML it
" ignores tags and only checks words that will appear, and turns off other
" syntax highlighting to make the errors more apparent [function at end of
" file]:
"nnoremap \sh :call HighlightSpellingErrors()<CR><CR>
"nmap <F9> \sh

" \sc ("spelling clear") clears all highlighted misspellings; for HTML it
" restores regular syntax highlighting:
nnoremap \sc :if &ft == 'html' <Bar> sy on <Bar>
  \ else <Bar> :sy clear SpellError <Bar> endif<CR>
nmap <S-F9> \sc


" * Keystrokes -- Moving Around

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode:
set whichwrap=h,l,~,[,],<,>

" page down with <Space> (like in `Lynx', `Mutt', `Pine', `Netscape Navigator',
" `SLRN', `Less', and `More'); page up with - (like in `Lynx', `Mutt', `Pine'),
" or <BkSpc> (like in `Netscape Navigator'):
noremap <Space> <PageDown>
noremap <BS> <Up>
" [<Space> by default is like l, <BkSpc> like h]

" scroll the window (but leaving the cursor in the same place) by one
" line up/down with +/-:
noremap - <C-Y>
noremap + <C-E>
"noremap <C--> 2<C-E>
"noremap <C-+> 2<C-Y>
" [<Ins> by default is like i, and <Del> like x.]

" use <Ctrl>+N/<Ctrl>+P to cycle through files:
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>
" [<Ctrl>+N by default is like j, and <Ctrl>+P like k.]

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>


" * Keystrokes -- Formatting

" have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gqap
vnoremap Q gq
" or the whole document:
nnoremap ,Q gggqG
" justifica tutto il testo..
nmap ,q _j

" have the usual indentation keystrokes still work in visual mode:
vnoremap <C-T> >
vnoremap <C-D> <LT>
vmap <C-Tab> <C-T>
vmap <S-Tab> <C-D>

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" Function to comment the a selected region in visual mode
function! Komment()
  if getline(".") =~ '\/\*'
    let hls=@/
    s/^\/\*//
    s/*\/$//
    let @/=hls
  else
    let hls=@/
    s/^/\/*/
    let @/=hls
endfunction
vmap k v`<I<CR><esc>k0i/*<ESC>`>I<CR><esc>k0i*/<ESC>'
vmap p v`<I<CR><esc>k0i{<ESC>`>I<CR><esc>k0i}<ESC>''

" * Keystrokes -- Toggles

" Keystrokes to toggle options are defined here.  They are all set to normal
" mode keystrokes beginning \t but some function keys (which won't work in all
" terminals) are also mapped.


" have <F1> prompt for a help topic, rather than displaying the introduction
" page, and have it do this from any mode:
nnoremap <F1> :bnext!<CR>
imap <F1> <ESC> :bnext!<CR>
noremap <S-F1> :bprevious! <CR>
imap <S-F1> <ESC> :bprevious! <CR>
"nnoremap <F1> za
"inoremap <F1> <C-O>za
"nnoremap <S-F1> zi
"inoremap <S-F1> <C-O>zi
"nnoremap <C-F1> :mkview
"inoremap <C-F1> <ESC>:mkview

" have \th ("toggle highlight") toggle highlighting of search matches, and
" report the change:
" have \tl ("toggle list") toggle list on/off and report the change:
nnoremap \th :set invhls hls?<CR>
nmap <F2> \th
imap <F2> <C-O>\th
nnoremap \tl :set invlist list?<CR>
nmap <S-F2> \tl
imap <S-F2> <C-O>\tl

" <F3> search <S-F3> search next identifyer
nmap <F3> /
imap <F3> <C-O>/ 
nmap <S-F3> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
imap <S-F3> <C-O>[I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" have \tp ("toggle paste") toggle paste on/off and report the change, and
" where possible also have <F4> do this both in normal and insert mode:
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>

" copia/incolla riga
nnoremap <F5> yy
nnoremap <S-F5> P
inoremap <F5> <C-O>yy
inoremap <S-F5> <C-O>P

" use <F6> to cycle through split windows (and <Shift>+<F6> to cycle backwards,
" where possible):
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W
inoremap <F6> <C-O><C-W>w
inoremap <S-F6> <C-O><C-W>W

" use <F7> to split <F7> to browse split
nmap <F7> :browse edit .<CR>
imap <F7> <C-O>:browse edit .<CR>
nmap <S-F7> :browse split .<CR>
imap <S-F7> <C-O>:browse split .<CR>

" use <F8> to
nmap <F8> ,Q'"<CR>
imap <F8> <C-O>,Q'"<CR>
nmap <S-F8> gg=G``
imap <S-F8> <C-O>gg=G``

" use <F10> to save <S-F10> to save and quit
nmap <F10> :wall<CR>
imap <F10> <C-O>:wall<CR>
nmap <S-F10> :wq<CR>
imap <S-F10> <C-O>:wq<CR>

" use <F11> next tag new window <S-F11> close window
nmap <F11> <C-W>]
imap <F11> <C-O><C-W>]
nmap <S-F11> :close<CR>
imap <S-F11> <C-O>:close<CR>

" use <F12> next tag <S-F12> previous tag
nmap <F12> <C-]>
imap <F12> <C-O><C-]>
nmap <S-F12> <C-T>
imap <S-F12> <C-O><C-T>

nmap ,t :!(cd %:p:h;ctags *)&<CR>
nmap <S-F4> :!(cd %:p:h;ctags *)&<CR>
imap <S-F4> <C-O>:!(cd %:p:h;ctags *)&<CR> 


" * Keystrokes -- Insert Mode

"like emacs
noremap <C-x>s :wall<CR>
imap <C-x>s <ESC>:wall<CR>
noremap <C-x>c :q<CR>
imap <C-x>c <ESC>:q<CR>
noremap <C-x><C-b> :ls<CR>
imap <C-x><C-b> <ESC>:ls<CR>
imap <S-Tab> <ESC>==A
noremap <C-x><C-f> :hide edit
imap <C-x><C-f> <ESC>:hide edit
noremap <C-x>b :bprevious!<CR>
imap <C-x>b <ESC>:bprevious!<CR>
noremap <C-s> /
imap <C-s> <ESC>/
noremap <C-g> <ESC>
imap <C-g> <ESC>
" Visual mode
"imap <silent> <C-Space> <C-r>=<SID>StartVisualMode()<CR>
"noremap <silent> <C-Space> <C-r>=<SID>StartVisualMode()<CR>
"imap <C-x><C-b>


" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" have <Tab> (and <Shift>+<Tab> where it works) change the level of
" indentation:
"inoremap <Tab> <C-T>
"inoremap <S-Tab> <C-D>
" [<Ctrl>+V <Tab> still inserts an actual tab character.]

" Strip blanks at end of line =)
"nnoremap \ss :%s/{TAB}*$//

" DOS2UNIX =)
"nnoremap \sd :1,$ s/{ctrl-V}{ctrl-M}//

" abbreviations:
" correct my common typos without me even noticing them:
cabbrev WQ wq
cabbrev Wq wq
"set lines=60
"set columns=150
set paste

set background=dark
colorscheme solarized

