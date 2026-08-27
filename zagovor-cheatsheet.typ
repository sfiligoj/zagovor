// zagovor cheat sheet — Typst source
// compile: typst compile zagovor-cheatsheet.typ zagovor-cheatsheet.pdf
// (or run ./generate-pdf.sh, which installs typst if missing)
// © 2026 Gregor Sfiligoj — CC BY 4.0

#set page(
  paper: "a4",
  flipped: true,
  margin: (top: 12mm, bottom: 9mm, left: 12mm, right: 12mm),
)
#set text(font: ("Helvetica Neue", "Arial"), size: 8.6pt, fill: rgb("#1a1a1a"))
#set par(leading: 0.55em)

#let mono-font = ("SF Mono", "Menlo", "Consolas")

#let orange = rgb("#c2410c")
#let dark = rgb("#0f0f0f")
#let hgray = rgb("#666666")
#let subgray = rgb("#555555")
#let cardbg = rgb("#fafafa")
#let cardborder = rgb("#e2e2e2")
#let tokbg = rgb("#1f2937")
#let toktext = rgb("#f3f4f6")
#let sbg = rgb("#7c2d12")
#let exbg = rgb("#0f172a")
#let extext = rgb("#e2e8f0")

// ---- small building blocks -------------------------------------------

#let tok(body, bg: tokbg) = box(
  fill: bg, radius: 3pt, outset: (x: 4pt, y: 1.5pt),
)[#text(font: mono-font, size: 8pt, fill: toktext)[#body]]

#let tok-o(body) = tok(body, bg: orange)
#let tok-s(body) = tok(body, bg: sbg)

#let mono(body) = text(font: mono-font)[#body]

#let card(title, body) = block(
  breakable: false, fill: cardbg, stroke: 1pt + cardborder, radius: 5pt,
  inset: (top: 7pt, x: 8pt, bottom: 8pt), below: 9pt, width: 100%,
)[
  #text(size: 9.4pt, fill: orange, tracking: 0.5pt)[#upper(title)]
  #v(-2pt)
  #line(length: 100%, stroke: 0.5pt + rgb("#eeeeee"))
  #v(4pt)
  #body
]

#let kv(rows) = table(
  columns: (auto, 1fr), column-gutter: 8pt, stroke: none, inset: (x: 0pt, y: 1.7pt),
  align: (left + top, left + top), ..rows,
)

#let ex(body) = block(
  fill: exbg, radius: 4pt, inset: (x: 7pt, y: 6pt), below: 6pt, width: 100%,
)[#set text(font: mono-font, size: 7.7pt, fill: extext)
  #body
]

#let v-c = rgb("#fb923c")
#let f-c = rgb("#fbbf24")
#let n-c = rgb("#f87171")
#let c-c = rgb("#94a3b8")
#let p-c = rgb("#86efac")

#let tip(body) = block(
  fill: rgb("#fff7ed"), stroke: (left: 2.5pt + orange),
  inset: (x: 7pt, y: 5pt), radius: (top-right: 4pt, bottom-right: 4pt),
  above: 6pt, width: 100%,
)[#set text(size: 7.9pt)
  #body
]

// ---- header -------------------------------------------------------------

#block(
  width: 100%, stroke: (bottom: 2.5pt + orange),
  inset: (bottom: 5pt), below: 9pt,
)[
  #grid(
    columns: (1fr, auto), align: (horizon + left, horizon + right),
    grid(
      columns: (auto, auto), column-gutter: 13pt, align: horizon,
      image("zagovor-logo-braille.svg", height: 46pt),
      [
        #text(font: "Georgia", size: 21pt, weight: 500, fill: dark)[zagovor] #h(4pt) #text(size: 13pt, fill: rgb("#888888"))[· prompt dialect]

        #text(size: 8.4pt, fill: subgray)[#text(style: "italic", fill: orange)[a precise spoken formula that makes something happen] — a small hand-typed vocabulary for chat. The win is #text(style: "italic", fill: orange)[your] consistency; keep it small enough to remember.]
      ],
    ),
    text(size: 9pt, fill: hgray)[v0.1],
  )
]

// ---- grammar bar ----------------------------------------------------------

#block(
  fill: tokbg, radius: 5pt, inset: (x: 9pt, y: 8pt), below: 9pt, width: 100%,
)[
  #set text(font: mono-font, size: 9.6pt, fill: rgb("#e5e7eb"))
  #text(fill: rgb("#9ca3af"))[\# grammar — one verb per request] \
  #text(fill: v-c)[VERB] target [#text(fill: f-c)[FLAG=value] ...] [#text(fill: n-c)[NO=...]] [#text(fill: p-c)[: payload]]
]

// ---- three-column body ----------------------------------------------------

#grid(columns: (1fr, 1fr, 1fr), column-gutter: 11pt,

[
  #card("Verbs — the operation")[
    #kv((
      tok-o[ANS], [direct answer, nothing extra],
      tok-o[EXPLAIN], [answer + reasoning],
      tok-o[DEFINE], [define a term / concept],
      tok-o[COMPARE], [weigh options against each other],
      tok-o[DECIDE], [pick one and justify],
      tok-o[DRAFT], [produce new text],
      tok-o[REVISE], [rework text I give you],
      tok-o[CRITIQUE], [find flaws, no rewrite],
      tok-o[PLAN], [ordered steps to a goal],
      tok-o[CODE], [write code],
      tok-o[SUMMARIZE], [compress provided material],
      tok-o[BRAINSTORM], [many options, breadth],
    ))
  ]

  #card("Flags — modifiers")[
    #kv((
      tok[LEN=], [1line · brief · para · full · #mono[Nw]],
      tok[FMT=], [prose · bullets · table · code · json],
      tok[DEPTH=], [eli5 · normal · expert],
      tok[TONE=], [plain · blunt · formal],
    ))
  ]
],

[
  #card("NO= — suppress (verbosity killers)")[
    #kv((
      tok-s[NO=preamble], [],
      tok-s[NO=caveats], [],
      tok-s[NO=hedging], [],
      tok-s[NO=followup-questions], [],
    ))
    #v(5pt)
    #text(size: 7.7pt, fill: orange, weight: 600)[Highest value. Adopt these + LEN= first.]
  ]

  #card("Control words")[
    #kv((
      mono[ASSUME:], [fill gaps with these, don't ask],
      mono[CTX:], [background / data, kept separate],
      mono[REF:], [source material to rely on],
      mono[IF .. ELSE], [conditional branch],
      mono[ASK], [invite clarifying Qs (off by default)],
      mono[SET ..], [set a default for the session],
      mono[RESET], [clear session defaults],
    ))
  ]
],

[
  #card("Examples")[
    #ex[
      #text(fill: v-c)[DECIDE] postgres-vs-sqlite #text(fill: f-c)[FMT=table DEPTH=expert] #text(fill: n-c)[NO=preamble] \
      #h(1em)#text(fill: c-c)[CTX:] 1-user desktop app, \<100MB, offline
    ]
    #ex[
      #text(fill: v-c)[DRAFT] cover-letter #text(fill: f-c)[LEN=brief TONE=plain] #text(fill: n-c)[NO=hedging] \
      #h(1em)#text(fill: c-c)[REF:] \<paste job posting\> \
      #h(1em)#text(fill: c-c)[ASSUME:] 5 yrs exp, no relocation
    ]
    #ex[
      #text(fill: v-c)[EXPLAIN] tcp-handshake #text(fill: f-c)[DEPTH=eli5 LEN=para] #text(fill: n-c)[NO=caveats]
    ]
    #ex[
      #text(fill: v-c)[SET] #text(fill: f-c)[LEN=brief] #text(fill: n-c)[NO=preamble NO=caveats] \
      #text(fill: c-c)[\# inherited until RESET]
    ]
  ]

  #card("Session-default block")[
    #text(size: 7.9pt, fill: rgb("#333333"))[Paste into #text(fill: orange, style: "normal", weight: 600)[custom instructions / user preferences] so the vocabulary is always active:]
    #ex[
      I sometimes prefix requests with a compact syntax: \
      #text(fill: v-c)[VERB] target [#text(fill: f-c)[FLAG=value]] [#text(fill: n-c)[NO=...]] [: payload]. \
      Treat VERB as the operation, FLAG=value as \
      output constraints, NO=x as things to omit, \
      CTX:/REF: as background vs source, ASSUME: \
      as gap-fillers so you don't ask. Honor these \
      literally. With no prefix, default to: brief, \
      no preamble, no hedging, answer first.
    ]
    #tip[
      Borrowed: #text(weight: 600)[EXPLAIN] & budget-thinking from #link("https://arxiv.org/abs/2602.21257")[#text(fill: orange)[SPL — Structured Prompt Language]]; prepended-decorator style from #link("https://github.com/synaptiai/prompt-decorators")[#text(fill: orange)[Prompt Decorators]]. Version it: v0.1 → v0.2.
    ]
  ]
]

)

// ---- footer -----------------------------------------------------------

#place(bottom + right)[
  #text(size: 7pt, fill: rgb("#999999"))[
    zagovor v0.1  ——··  personal prompt dialect · named for the Slovene spoken charm-formula · © 2026 Gregor Sfiligoj · licensed under #link("https://creativecommons.org/licenses/by/4.0/")[CC BY 4.0]
  ]
]
