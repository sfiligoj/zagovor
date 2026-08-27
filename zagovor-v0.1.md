# Zagovor — v0.1
### a prompt dialect · *"a precise spoken formula that makes something happen"*

**Zagovor** (Slovene): a spoken charm-formula from folk tradition — *what is performed
with speech*. The belief behind it is that precisely articulated words have causative
power. That is exactly what this is: a small, hand-typed vocabulary for talking to an
AI in chat.

Not a compiler — the AI still reads everything as natural language. The win is *your*
consistency: fixed words remove ambiguity and decision fatigue, and the AI responds to
clear structure very predictably. Keep it small enough to remember.

---

## Grammar

```
VERB target [FLAG=value ...] [NO=...] [: payload]
```

One verb per request (one *zagovor*). Chain as many flags as you want. Payload (after
`:` or on indented lines) holds the actual content/data.

---

## Verbs — the operation

| Verb       | Means                                  |
|------------|----------------------------------------|
| ANS        | direct answer, nothing extra           |
| EXPLAIN    | answer + reasoning                     |
| DEFINE     | define a term/concept                  |
| COMPARE    | weigh options against each other       |
| DECIDE     | pick one and justify                   |
| DRAFT      | produce new text                       |
| REVISE     | rework text I give you                 |
| CRITIQUE   | find flaws, no rewrite                  |
| PLAN       | ordered steps to a goal                |
| CODE       | write code                             |
| SUMMARIZE  | compress provided material             |
| BRAINSTORM | generate many options, breadth         |

## Flags — modifiers

| Flag    | Values                              |
|---------|-------------------------------------|
| LEN=    | 1line · brief · para · full · Nw (e.g. 50w) |
| FMT=    | prose · bullets · table · code · json |
| DEPTH=  | eli5 · normal · expert              |
| TONE=   | plain · blunt · formal              |

## NO= — suppress (the verbosity killers)

`NO=preamble` · `NO=caveats` · `NO=hedging` · `NO=followup-questions`

These are the highest-value tokens. If you adopt nothing else, adopt these + LEN=.

## Control words

| Word        | Effect                                                  |
|-------------|---------------------------------------------------------|
| ASSUME: ... | fill gaps with these so I don't stop to ask             |
| CTX: ...    | background/data, kept separate from the request         |
| REF: ...    | source material to rely on                              |
| IF ... ELSE | conditional branch                                      |
| ASK         | explicitly invite clarifying questions (off by default) |
| SET ...     | set a default for the rest of the session               |
| RESET       | clear all session defaults                              |

---

## Examples (casting a zagovor)

```
DECIDE postgres-vs-sqlite FMT=table DEPTH=expert NO=preamble
  CTX: single-user desktop app, <100MB data, offline
```

```
DRAFT cover-letter LEN=brief TONE=plain NO=hedging
  REF: <paste job posting>
  ASSUME: 5 yrs experience, no relocation
```

```
EXPLAIN tcp-handshake DEPTH=eli5 LEN=para NO=caveats
```

```
SET LEN=brief NO=preamble NO=caveats
```
(everything after this inherits those defaults until RESET)

---

## Session-default block (paste into custom instructions / user preferences)

> I sometimes prefix requests with a compact syntax I call Zagovor:
> `VERB target [FLAG=value] [NO=...] [: payload]`.
> Treat VERB as the operation, FLAG=value as output constraints, NO=x as things
> to omit, CTX:/REF: as background vs. source material, ASSUME: as gap-fillers so
> you don't ask. Honor these literally. When no prefix is present, default to:
> brief, no preamble, no hedging, answer first.

---

## Lineage & versioning

Borrowed `EXPLAIN` and budget-thinking from SPL (Structured Prompt Language); the
prepended-decorator ergonomics echo Prompt Decorators. Named for the Slovene *zagovor*,
a spoken charm-formula.

Bump the number when the vocabulary changes (v0.1 → v0.2). Keep a changelog line so old
saved prompts still make sense to you.

© 2026 Gregor Sfiligoj — CC BY 4.0.
