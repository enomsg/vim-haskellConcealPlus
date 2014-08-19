" vim: sw=4
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

" Cf - check a flag. Return true if the flag is specified.
function Cf(flag)
    return exists('g:hscoptions') && stridx(g:hscoptions, a:flag) >= 0
endfunction

if exists('g:no_haskell_conceal') || !has('conceal') || &enc != 'utf-8'
    finish
endif

" vim: set fenc=utf-8:
syntax match hsNiceOperator "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ

" 'q' option to disable concealing of scientific constants (e.g. π).
if !Cf('q')
    syntax match hsNiceOperator "\<pi\>" conceal cchar=π
    syntax match hsNiceOperator "\<tau\>" conceal cchar=τ
    syntax match hsNiceOperator "\<planckConstant\>" conceal cchar=ℎ
    syntax match hsNiceOperator "\<reducedPlanckConstant\|planckConstantOver2Pi\|hbar\|hslash\>" conceal cchar=ℏ
endif

syntax match hsNiceOperator "==" conceal cchar=≡
syntax match hsNiceOperator "\/=" conceal cchar=≢

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

    " Redfining to get proper '::' concealing
    syntax match hs_DeclareFunction /^[a-z_(]\S*\(\s\|\n\)*::/me=e-2 nextgroup=hsNiceOperator contains=hs_FunctionName,hs_OpFunctionName

    syntax match hsNiceoperator "!!" conceal cchar=‼
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

    syntax match hsQQEnd "|\]" contained conceal cchar=〛
    " sy match hsQQEnd "|\]" contained conceal=〚

    syntax match hsNiceOperator "`elem`" conceal cchar=∈
    syntax match hsNiceOperator "`notElem`" conceal cchar=∉
    syntax match hsNiceOperator "`union`" conceal cchar=∪
    syntax match hsNiceOperator "`intersect`" conceal cchar=∩
    syntax match hsNiceOperator "\\\\\ze[[:alpha:][:space:]_([]" conceal cchar=∖

    syntax match hsNiceOperator "||\ze[[:alpha:][:space:]_([]" conceal cchar=∨
    syntax match hsNiceOperator "&&\ze[[:alpha:][:space:]_([]" conceal cchar=∧

    syntax match hsNiceOperator "<\*>"      conceal cchar=⊛
    syntax match hsNiceOperator "`mappend`" conceal cchar=⊕
    syntax match hsNiceOperator "<>"        conceal cchar=⊕
    syntax match hsNiceOperator "\<empty\>" conceal cchar=∅
endif

hi link hsNiceOperator Operator
hi! link Conceal Operator
setlocal conceallevel=2

" 'A' option to not try to preserve indentation.
if Cf('A')
    syntax match hsNiceOperator "<-" conceal cchar=←
    syntax match hsNiceOperator "->" conceal cchar=→
    syntax match hsNiceOperator "=>" conceal cchar=⇒
    syntax match hsNiceOperator "\:\:" conceal cchar=∷
else
    syntax match hsLRArrowHead contained ">" conceal cchar= 
    syntax match hsLRArrowTail contained "-" conceal cchar=→
    syntax match hsLRArrowFull "->" contains=hsLRArrowHead,hsLRArrowTail

    syntax match hsRLArrowHead contained "<" conceal cchar=←
    syntax match hsRLArrowTail contained "-" conceal cchar= 
    syntax match hsRLArrowFull "<-" contains=hsRLArrowHead,hsRLArrowTail

    syntax match hsLRDArrowHead contained ">" conceal cchar= 
    syntax match hsLRDArrowTail contained "=" conceal cchar=⇒
    syntax match hsLRDArrowFull "=>" contains=hsLRDArrowHead,hsLRDArrowTail
endif

" 's' option to disable space consumption after ∑,∏,√ and ¬ functions.
if Cf('s')
    syntax match hsNiceOperator "\<sum\>"        conceal cchar=∑
    syntax match hsNiceOperator "\<product\>"    conceal cchar=∏
    syntax match hsNiceOperator "\<sqrt\>"       conceal cchar=√
    syntax match hsNiceOperator "\<not\>"        conceal cchar=¬
else
    syntax match hsNiceOperator "\<sum\>\s*"     conceal cchar=∑
    syntax match hsNiceOperator "\<product\>\s*" conceal cchar=∏
    syntax match hsNiceOperator "\<sqrt\>\s*"    conceal cchar=√
    syntax match hsNiceOperator "\<not\>\s*"     conceal cchar=¬
endif

" '*' option to enable concealing of asterisk with '⋅' sign.
if Cf('*')
    syntax match hsNiceOperator "*" conceal cchar=⋅
" 'x' option to disable default concealing of asterisk with '×' sign.
elseif !Cf('x')
    syntax match hsNiceOperator "*" conceal cchar=×
endif

" 'E' option to enable ellipsis concealing with ‥  (two dot leader).
if Cf('E')
    " The two dot leader is not guaranteed to be at the bottom. So, it
    " will break on some fonts.
    syntax match hsNiceOperator "\.\." conceal cchar=‥
" 'e' option to disable ellipsis concealing with … (ellipsis sign).
elseif !Cf('e')
    syntax match hsNiceOperator "\.\." conceal cchar=…
end

" 'r' option to disable return (η) and join (µ) concealing.
if !Cf('r')
    syntax match hsNiceOperator "\<return\>" conceal cchar=η
    syntax match hsNiceOperator "\<join\>"   conceal cchar=µ
endif

" 'b' option to disable bind (left and right) concealing
if Cf('b')
    " Vim has some issues concealing with composite symbols like '«̳', and
    " unfortunately there is no other common short notation for both
    " binds. So 'b' option to disable bind concealing altogether.
" 'f' option to enable formal (★) right bind concealing
elseif Cf('f')
    syntax match hsNiceOperator ">>="    conceal cchar=★
" 'c' option to enable encircled b/d (ⓑ/ⓓ) for right and left binds.
elseif Cf('c')
    syntax match hsNiceOperator ">>="    conceal cchar=ⓑ
    syntax match hsNiceOperator "=<<"    conceal cchar=ⓓ
" 'h' option to enable partial concealing of binds (e.g. »=).
elseif Cf('h')
    syntax match hsNiceOperator ">>"     conceal cchar=»
    syntax match hsNiceOperator "<<"     conceal cchar=«
    syntax match hsNiceOperator "=\zs<<" conceal cchar=«
" Left and right arrows with hooks are the default option for binds.
else
    syntax match hsNiceOperator ">>="    conceal cchar=↪
    syntax match hsNiceOperator "=<<"    conceal cchar=↩
endif

if !Cf('h')
    syntax match hsNiceOperator "\zs>>\ze\_[^=]" conceal cchar=»
    syntax match hsNiceOperator "[^=]*\zs<<\ze"  conceal cchar=«
endif

" 'C' option to enable encircled 'm' letter ⓜ concealing for fmap.
if Cf('C')
    syntax match hsNiceOperator "<$>"    conceal cchar=ⓜ
    syntax match hsNiceOperator "`fmap`" conceal cchar=ⓜ
" 'l' option to disable fmap/lift concealing with ↥.
elseif !Cf('l')
    syntax match hsNiceOperator "`liftM`" conceal cchar=↥
    syntax match hsNiceOperator "`liftA`" conceal cchar=↥
    syntax match hsNiceOperator "`fmap`"  conceal cchar=↥
    syntax match hsNiceOperator "<$>"     conceal cchar=↥
endif

" 'w' option to disable 'where' concealing with "due to"/∵ symbol.
if !Cf('w')
    " ∵ means "because/since/due to." With quite a stretch this can be
    " used for 'where'. We preserve spacing, otherwise it breaks indenting
    " in a major way.
    syntax match WS contained "w" conceal cchar=∵
    syntax match HS contained "h" conceal cchar= 
    syntax match ES contained "e" conceal cchar= 
    syntax match RS contained "r" conceal cchar= 
    syntax match hsNiceOperator "\<where\>" contains=WS,HS,ES,RS,ES
endif

" '-' option to disable subtract/(-) concealing with ⊟.
if !Cf('-')
    " Minus is a special syntax construct in Haskell. We use squared minus to
    " tell the syntax from the binary function.
    syntax match hsNiceOperator "(-)"        conceal cchar=⊟
    syntax match hsNiceOperator "`subtract`" conceal cchar=⊟
endif

" 'I' option to enable alternative ':+' concealing with with ⨢.
if Cf('I')
    " With some fonts might look better than ⅈ.
    syntax match hsNiceOperator ":+"         conceal cchar=⨢
" 'i' option to disable default concealing of ':+' with ⅈ.
elseif !Cf('i')
    syntax match hsNiceOperator ":+"         conceal cchar=ⅈ
endif

" 'R' option to disable realPart/imagPart concealing with ℜ/ℑ.
if !Cf('R')
    syntax match hsNiceOperator "\<realPart\>" conceal cchar=ℜ
    syntax match hsNiceOperator "\<imagPart\>" conceal cchar=ℑ
endif

" 'T' option to enable True/False constants concealing with bold 𝐓/𝐅.
if Cf('T')
    syntax match hsNiceSpecial "\<True\>"  conceal cchar=𝐓
    syntax match hsNiceSpecial "\<False\>" conceal cchar=𝐅
" 't' option to disable True/False constants concealing with italic 𝑇/𝐹.
elseif !Cf('t')
    syntax match hsNiceSpecial "\<True\>"  conceal cchar=𝑇
    syntax match hsNiceSpecial "\<False\>" conceal cchar=𝐹
endif

" 'B' option to disable Bool type to 𝔹 concealing
if !Cf('B')
    " Not an official notation ttbomk. But at least
    " http://www.haskell.org/haskellwiki/Unicode-symbols mentions it.
    syntax match hsNiceOperator "\<Bool\>" conceal cchar=𝔹
endif

" 'Q' option to disable Rational type to ℚ concealing.
if !Cf('Q')
    syntax match hsNiceOperator "\<Rational\>" conceal cchar=ℚ
endif

" 'Z' option to disable Integer type to ℤ concealing.
if !Cf('Z')
    syntax match hsNiceOperator "\<Integer\>"  conceal cchar=ℤ
endif

" '1' option to disable numeric superscripts concealing, e.g. x².
if !Cf('1')
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)0\ze\_W" conceal cchar=⁰
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)1\ze\_W" conceal cchar=¹
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)2\ze\_W" conceal cchar=²
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)3\ze\_W" conceal cchar=³
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)4\ze\_W" conceal cchar=⁴
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)5\ze\_W" conceal cchar=⁵
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)6\ze\_W" conceal cchar=⁶
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)7\ze\_W" conceal cchar=⁷
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)8\ze\_W" conceal cchar=⁸
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)9\ze\_W" conceal cchar=⁹
endif

" 'a' option to disable alphabet superscripts concealing, e.g. xⁿ.
if !Cf('a')
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)a\ze\_W" conceal cchar=ᵃ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)b\ze\_W" conceal cchar=ᵇ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)c\ze\_W" conceal cchar=ᶜ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)d\ze\_W" conceal cchar=ᵈ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)e\ze\_W" conceal cchar=ᵉ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)f\ze\_W" conceal cchar=ᶠ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)g\ze\_W" conceal cchar=ᵍ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)h\ze\_W" conceal cchar=ʰ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)i\ze\_W" conceal cchar=ⁱ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)j\ze\_W" conceal cchar=ʲ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)k\ze\_W" conceal cchar=ᵏ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)l\ze\_W" conceal cchar=ˡ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)m\ze\_W" conceal cchar=ᵐ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)n\ze\_W" conceal cchar=ⁿ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)o\ze\_W" conceal cchar=ᵒ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)p\ze\_W" conceal cchar=ᵖ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)r\ze\_W" conceal cchar=ʳ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)s\ze\_W" conceal cchar=ˢ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)t\ze\_W" conceal cchar=ᵗ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)u\ze\_W" conceal cchar=ᵘ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)v\ze\_W" conceal cchar=ᵛ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)w\ze\_W" conceal cchar=ʷ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)x\ze\_W" conceal cchar=ˣ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)y\ze\_W" conceal cchar=ʸ
    syntax match hsNiceOperator "\(\*\*\|\^\|\^\^\)z\ze\_W" conceal cchar=ᶻ
endif

" TODO:
" See Basic Syntax Extensions - School of Haskell | FP Complete
" intersection = (∩)
"
" From the Data.IntMap.Strict.Unicode
" notMember = (∉) = flip (∌)
" member = (∈) = flip (∋)
" isProperSubsetOf = (⊂) = flip (⊃)
" isSubsetOf = (⊆) = flip (⊇)
"
" From Data.Sequence.Unicode
" (<|) = (⊲ )
" (|>) = (⊳ )
" (><) = (⋈ )
