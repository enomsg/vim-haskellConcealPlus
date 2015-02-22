## Vim Haskell Conceal+

This bundle provides extended Haskell Conceal feature for Vim. The feature
is used to display unicode operators in Haskell code without changing the
underlying file.

This package offers more (and, more importantly, configurable) features
than the baseline vim-haskellConceal bundle. The baseline bundle has
numerous forks, which is possible to combine, so everyone is welcome to
share, improve or contribute new notations to this Conceal Plus package.

GitHub: https://github.com/enomsg/vim-haskellConcealPlus

### Why Concealing

- Using things like '->' instead real arrows '→' was never a deliberate
  choice, but a choice made due to limitations of teletypewriters and
  input inconvenience.

- With concealing you don't have to deal with cumbersome unicode-input
  methods, yet you can enjoy proper notation.

- It is not only about aesthetics. Excess of multi-character functions may
  create visual noise, which negatively affects readability. Using special
  symbols and true arrows, together with colors and bold/italic face seems
  to improve the situation. The image shows Vim with and without
  concealing, both running in a plain terminal emulator:

![demo](https://github.com/enomsg/vim-haskellConcealPlus/raw/master/demo.png)

- Using concealing instead of *-unicode* versions of packages also has
  some advantages. Mainly, concealing does not require any changes to the
  source code, it is backwards-compatible with idiomatic code. Secondly,
  with concealing no special input methods are needed. Plus, currently
  some features are hardly possible without editor's concealing (e.g.
  power superscripts).

### Installation

Decompress in your *~/vimfiles* or *~/.vim*, if you're using pathogen (you
should), put it in *~/.vim/bundle/haskellConcealPlus* folder.

### Available Options

    'q' option to disable concealing of scientific constants (e.g. π).
    '℘' option to disable concealing of powerset function
    '𝐒' option to disable String type to 𝐒 concealing
    '𝐓' option to disable Text type to 𝐓 concealing
    '𝐄' option to disable Either/Right/Left to 𝐄/𝑅/𝐿 concealing
    '𝐌' option to disable Maybe/Just/Nothing to 𝐌/𝐽/𝑁 concealing
    'A' option to not try to preserve indentation.
    's' option to disable space consumption after ∑,∏,√ and ¬ functions.
    '*' option to enable concealing of asterisk with '⋅' sign.
    'x' option to disable default concealing of asterisk with '×' sign.
    'E' option to enable ellipsis concealing with ‥  (two dot leader).
    'e' option to disable ellipsis concealing with … (ellipsis sign).
    '⇒' option to disable `implies` concealing with ⇒
    '⇔' option to disable `iff` concealing with ⇔
    'r' option to disable return (η) and join (µ) concealing.
    'b' option to disable bind (left and right) concealing
    'f' option to enable formal (★) right bind concealing
    'c' option to enable encircled b/d (ⓑ/ⓓ) for right and left binds.
    'h' option to enable partial concealing of binds (e.g. »=).
    'C' option to enable encircled 'm' letter ⓜ concealing for fmap.
    'l' option to disable fmap/lift concealing with ↥.
    '↱' option to disable mapM/forM concealing with ↱/↰
    'w' option to disable 'where' concealing with "due to"/∵ symbol.
    '-' option to disable subtract/(-) concealing with ⊟.
    'I' option to enable alternative ':+' concealing with with ⨢.
    'i' option to disable default concealing of ':+' with ⅈ.
    'R' option to disable realPart/imagPart concealing with ℜ/ℑ.
    'T' option to enable True/False constants concealing with bold 𝐓/𝐅.
    't' option to disable True/False constants concealing with italic 𝑇/𝐹.
    'B' option to disable Bool type to 𝔹 concealing
    'Q' option to disable Rational type to ℚ concealing.
    'Z' option to disable Integer type to ℤ concealing.
    '𝔻' option to disable Double type to 𝔻 concealing
    '1' option to disable numeric superscripts concealing, e.g. x².
    'a' option to disable alphabet superscripts concealing, e.g. xⁿ.

The flags can be specified via hscoptions variable. For example, *let
hscoptions="fc"* in your *~/.vimrc*.

### Known Issues and Hints:

- Concealing may seriously mess up indentation. By default the bundle
  tries to preserve spaces for commonly troublesome symbols (e.g. ->, <-
  and => arrows). But to be sure about indentation, you still have to see
  the non-concealed code. *set conceallevel=0* might be handy in these
  cases.

- *set concealcursor=nciv* seem to not play well with Vim matchparen
  feature (which is enabled by default). You can either disable concealing
  under the cursor, or disable matchparen by adding *let
  loaded_matchparen=1* at the very top of your *~/.vimrc*.

- With *set concealcursor=nciv* navigation through concealed parts of code
  might be somewhat irritating because the cursor behaves a bit
  differently. It becomes less of an issue if you are used to Vim's *w/b*
  commands (word forward/backward). You can also try *set
  concealcursor=ncv* instead.

- Finding proper fonts might be a pain. Most of modern, so called
  programming fonts (*Inconsolata*, *Anonymous Pro*, etc.) often lack
  decent unicode support. As a recommendation, try *DejaVu Sans Mono*.

- Ditto for terminal emulators: sadly, most of them have one or more
  issues with regard to the unicode characters handling. Those terminals
  that don't have problems with unicode might be pretty slow. As a
  recommendation, you can try *evilvte* (it has weird configuration, but
  draws things correctly) or *lxterminal* (seems to be quite capable, but
  limited configurability) or any other terminal emulator that happened to
  work for you.
