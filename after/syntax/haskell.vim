"=============================================================================
" What Is This: Add some conceal operator for your haskell files
" File:         haskell.vim (conceal enhancement)
" Author:       Vincent Berthoux <twinside@gmail.com>
" Last Change:  2011-09-07
" Version:      1.3.2
" Require:
"   set nocompatible
"     somewhere on your .vimrc
"
"   Vim 7.3 or Vim compiled with conceal patch.
"   Use --with-features=big or huge in order to compile it in.
"
" Usage:
"   Drop this file in your
"       ~/.vim/after/syntax folder (Linux/MacOSX/BSD...)
"       ~/vimfiles/after/syntax folder (Windows)
"
"   For this script to work, you have to set the encoding
"   to utf-8 :set enc=utf-8
"
" Additional:
"     * if you want to avoid the loading, add the following
"       line in your .vimrc :
"        let g:no_haskell_conceal = 1
"  Changelog:
"   - 1.3.1: putting undefined in extra conceal, not appearing on windows
"   - 1.3: adding new arrow characters used by GHC in Unicode extension.
"   - 1.2: Fixing conceal level to be local (thx Erlend Hamberg)
"   - 1.1: Better handling of non utf-8 systems, and avoid some
"           concealing operations on windows on some fonts
"
if exists('g:no_haskell_conceal') || !has('conceal') || &enc != 'utf-8'
    finish
endif

" vim: set fenc=utf-8:
syntax match hsNiceOperator "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ
syntax match hsNiceOperator "<-" conceal cchar=←
syntax match hsNiceOperator "->" conceal cchar=→
syntax match hsNiceOperator "\<sum\>" conceal cchar=∑
syntax match hsNiceOperator "\<product\>" conceal cchar=∏ 
syntax match hsNiceOperator "\<sqrt\>" conceal cchar=√ 
syntax match hsNiceOperator "\<pi\>" conceal cchar=π
syntax match hsNiceOperator "\<tau\>" conceal cchar=τ
syntax match hsNiceOperator "==" conceal cchar=≡
syntax match hsNiceOperator "\/=" conceal cchar=≢
syntax match hsNiceOperator ">>" conceal cchar=»
syntax match hsNiceOperator "<<" conceal cchar=«

let s:extraConceal = 1
" Some windows font don't support some of the characters,
" so if they are the main font, we don't load them :)
if has("win32")
    let s:incompleteFont = [ 'Consolas'
                        \ , 'Lucida Console'
                        \ , 'Courier New'
                        \ ]
    let s:mainfont = substitute( &guifont, '^\([^:,]\+\).*', '\1', '')
    for s:fontName in s:incompleteFont
        if s:mainfont ==? s:fontName
            let s:extraConceal = 0
            break
        endif
    endfor
endif

if s:extraConceal
    syntax match hsNiceOperator "\<undefined\>" conceal cchar=⊥

    " Match greater than and lower than w/o messing with Kleisli composition
    syntax match hsNiceOperator "<=\ze[^<]" conceal cchar=≤
    syntax match hsNiceOperator ">=\ze[^>]" conceal cchar=≥

    syntax match hsNiceOperator "=>" conceal cchar=⇒
    syntax match hsNiceOperator "=\zs<<" conceal cchar=«

    " Redfining to get proper '::' concealing
    syntax match hs_DeclareFunction /^[a-z_(]\S*\(\s\|\n\)*::/me=e-2 nextgroup=hsNiceOperator contains=hs_FunctionName,hs_OpFunctionName
    syntax match hsNiceOperator "\:\:" conceal cchar=∷

    syntax match hsNiceoperator "++" conceal cchar=⧺
    syntax match hsNiceOperator "\<forall\>" conceal cchar=∀
    syntax match hsNiceOperator "-<" conceal cchar=↢
    syntax match hsNiceOperator ">-" conceal cchar=↣
    syntax match hsNiceOperator "-<<" conceal cchar=⤛
    syntax match hsNiceOperator ">>-" conceal cchar=⤜
    " the star does not seem so good...
    " syntax match hsNiceOperator "*" conceal cchar=★
    syntax match hsNiceOperator "`div`" conceal cchar=÷

    " Only replace the dot, avoid taking spaces around.
    syntax match hsNiceOperator /\s\.\s/ms=s+1,me=e-1 conceal cchar=∘
    syntax match hsNiceOperator "\.\." conceal cchar=‥

    syntax match hsQQEnd "|\]" contained conceal cchar=〛
    " sy match hsQQEnd "|\]" contained conceal=〚
    " syntax match hsNiceOperator "*" conceal cchar=⋅
    syntax match hsNiceOperator "*" conceal cchar=×

    syntax match hsNiceOperator "`elem`" conceal cchar=∈
    syntax match hsNiceOperator "`notElem`" conceal cchar=∉
    syntax match hsNiceOperator "`union`" conceal cchar=∪
    syntax match hsNiceOperator "`intersect`" conceal cchar=∩
    syntax match hsNiceOperator "\\\\\ze[[:alpha:][:space:]_([]" conceal cchar=∖

    syntax match hsNiceOperator "||\ze[[:alpha:][:space:]_([]" conceal cchar=∨
    syntax match hsNiceOperator "&&\ze[[:alpha:][:space:]_([]" conceal cchar=∧
    syntax match hsNiceOperator "\<not\>" conceal cchar=¬

    syntax match hsNiceOperator "\<Rational\>" conceal cchar=ℚ
    syntax match hsNiceOperator "\<Integer\>"  conceal cchar=ℤ

    syntax match hsNiceOperator "<\*>"      conceal cchar=⊛
    syntax match hsNiceOperator "`mappend`" conceal cchar=⊕
    syntax match hsNiceOperator "<>"        conceal cchar=⊕
    syntax match hsNiceOperator "\<empty\>" conceal cchar=∅

    syntax match hsNiceOperator "\<return\>" conceal cchar=η
    syntax match hsNiceOperator "\<join\>"   conceal cchar=µ
endif

hi link hsNiceOperator Operator
hi! link Conceal Operator
setlocal conceallevel=2

" Informal but still useful notation down below.
if !exists('g:informal_haskell_conceal')
	finish
endif

" m - map
syntax match hsNiceOperator "<$>"        conceal cchar=ⓜ
syntax match hsNiceOperator "`fmap`"     conceal cchar=ⓜ

" ∵ means "because/since/due to." With quite a stretch this can be used
" for 'where'. We preserve spacing, otherwise it breaks indenting in a
" major way.
syntax match WS contained "w" conceal cchar=∵
syntax match HS contained "h" conceal cchar= 
syntax match ES contained "e" conceal cchar= 
syntax match RS contained "r" conceal cchar= 
syntax match hsNiceOperator "\<where\>" contains=WS,HS,ES,RS,ES

" Minus is a special syntax construct in Haskell. We use squared minus to
" tell the syntax from the binary function.
syntax match hsNiceOperator "(-)"        conceal cchar=⊟
syntax match hsNiceOperator "`subtract`" conceal cchar=⊟

" Not an official notation ttbomk. But at least
" http://www.haskell.org/haskellwiki/Unicode-symbols mentions it.
syntax match hsNiceOperator "\<Bool\>"   conceal cchar=𝔹

" '+i' blended. x⨢y == x + iy == x:+y
syntax match hsNiceOperator ":+"         conceal cchar=⨢
