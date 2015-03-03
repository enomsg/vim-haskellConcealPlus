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

### How to use it
Very easy! Just define a global variable with the configuration. Possible keys
are 'operator', 'identifier' and 'pattern'.

```
let g:haskell_conceal_definitions = {
\ 'operators': [
\ 	[['*'], ['×']],
\ 	[['.'], ['∘']],
\ 	[['::'], ['∷']],
\ 	[['=='], ['≡']],
\ 	[['/='], ['≢']],
\ 	[['<='], ['≤']],
\ 	[['>='], ['≥']],
\ 	[['!!'], ['‼']],
\ 	[['++'], ['⧺']],
\ 	[['||'], ['∨']],
\ 	[['&&'], ['∧']],
\ 	[['<>'], ['⊕']],
\ 	[[',+'], ['ⅈ']],
\ 	[['>>'], ['»']],
\ 	[['<<'], ['«']],
\ 	[['-<'], ['⤙']],
\ 	[['>-'], ['⤚']],
\ 	[['<|'], ['⊲']],
\ 	[['|>'], ['⊳']],
\ 	[['><'], ['⋈']],
\ 	[['-', '>'], ['→', ' ']],
\ 	[['<', '-'], ['←', ' ']],
\ 	[['=', '>'], ['⇒', ' ']],
\ 	[['***'], ['⁂']],
\ 	[['+++'], ['⧻']],
\ 	[['<$', '>'], ['F', '↥']],
\ 	[['<*>'], ['⊛']],
\ 	[['-', '<<'], ['—', '«']],
\ 	[['>>', '-'], ['»', '—']],
\ 	[['=', '<<'], ['=', '«']],
\ 	[['>>', '='], ['»', '=']],
\ 	[['>>', '>'], ['⋙', ' ']],
\ 	[['<', '<<'], ['⋘', ' ']],
\ ],
\ 'identifiers': [
\ 	[['False'], ['𝐅']],
\ 	[['True'], ['𝐓']],
\ 	[['String'], ['𝐒']],
\ 	[['Text'], ['𝐓']],
\ 	[['Either'], ['𝐄']],
\ 	[['Right'], ['𝑅']],
\ 	[['Left'], ['𝐿']],
\ 	[['Maybe'], ['𝐌']],
\ 	[['Just'], ['𝐽']],
\ 	[['Nothin', 'g'], ['𝑁', ' ']],
\ 	[['Bool'], ['𝔹']],
\ 	[['Rational'], ['ℚ']],
\ 	[['Integer'], ['ℤ']],
\ 	[['Double'], ['𝔻']],
\ 	[['undefined'], ['⊥']],
\ 	[['sum'], ['∑']],
\ 	[['sqrt'], ['√']],
\ 	[['product'], ['∏']],
\ 	[['empty'], ['∅']],
\ 	[['mzero'], ['∅']],
\ 	[['mempty'], ['∅']],
\ 	[['powerset'], ['℘']],
\ 	[['return'], ['η']],
\ 	[['join'], ['µ']],
\ 	[['realPart'], ['ℜ']],
\ 	[['imagPart'], ['ℑ']],
\ 	[['not'], ['¬']],
\ 	[['where'], ['∵']],
\ 	[['forall'], ['∀']],
\ 	[['exists'], ['∃']],
\ 	[['notExist'], ['∄']],
\ 	[['therefore'], ['∴']],
\ 	[['lift'], ['↥']],
\ 	[['fma', 'p'], ['F', '↥']],
\ 	[['lift', 'A'], ['A', '↥']],
\ 	[['lift', 'A', '2'], ['A', '2', '↥']],
\ 	[['lift', 'A', '3'], ['A', '3', '↥']],
\ 	[['lift', 'A', '4'], ['A', '4', '↥']],
\ 	[['lift', 'A', '5'], ['A', '5', '↥']],
\ 	[['lift', 'M'], ['M', '↥']],
\ 	[['lift', 'M', '2'], ['M', '2', '↥']],
\ 	[['lift', 'M', '3'], ['M', '3', '↥']],
\ 	[['lift', 'M', '4'], ['M', '4', '↥']],
\ 	[['lift', 'M', '5'], ['M', '5', '↥']],
\ 	[['`div`'], ['÷']],
\ 	[['`mappend`'], ['⊕']],
\ 	[['`implies', '`'], ['⇒', ' ']],
\ 	[['`iff', '`'], ['⇔', ' ']],
\ 	[['pi'], ['π']],
\ 	[['tau'], ['τ']],
\ 	[['planckConstant'], ['ℎ']],
\ 	[['hbar'], ['ℏ']],
\ 	[['hslash'], ['ℏ']],
\ 	[['reducedPlanckConstant'], ['ℏ']],
\ 	[['planckConstantOver2Pi'], ['ℏ']],
\ 	[['`elem`'], ['∈']],
\ 	[['`notElem`'], ['∉']],
\ 	[['`isSubsetOf`'], ['⊆']],
\ 	[['`isProperSubsetOf`'], ['⊂']],
\ 	[['`union`'], ['∪']],
\ 	[['`intersect`'], ['∩']],
\ ],
\ 'patterns': [
\ 	['', ['\'], ['λ'], '\ze\[[:alpha:][:space:]_([]'],
\ ],
\ }
```

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
