# Persistent ChatGPT Instructions File: Week 5 Discussion (Ch. 11–15) + Late Essay 1 Recovery

Version: 2025-10-01  
Course: ENGL 1110  
Author (You): [ADD NAME]

---

## 1. What Is Actually Due This Week (Week 5)

| Item | LMS Location | Due Date | Status Action |
|------|--------------|----------|---------------|
| Week 3 Discussion (HUG Ch. 11–15) | Discussions area | Oct 5 (Sun) | Draft & post ~275 words + replies |
| Essay 1 (Final) | Assignments area (Essay 1 Final Draft) | Was Sept 26 (late) | Submit polished salvage version ASAP (intro + 2–3 body paragraphs + conclusion) |
| In-Class Peer Review / Reflection | Class activity | This week | Bring partial draft (even if late) |

NOT due this week: Comparative Essay, Research components, Bricklayer’s Son template (that’s just your notes).

---

## 2. Your Existing Support Files (Use, Don’t Duplicate)

| File | Purpose | How to Reference in Prompts |
|------|---------|---------------------------|
| `discussions/2025-10-05-hug-ch11-15-discussion-plan.md` | Structural plan for discussion | Use for outline steps & claim templates |
| `discussions/hug-ch11-15-angles-explained.md` | Mechanism lists for Safety vs Gatekeeping | Quote mechanisms (label narrowing, interruption) |
| `discussions/hug-ch11-15-emotion-tone-map.md` | Emotional arc + tone vocabulary | Ask AI to maintain emotional pairing (e.g., Vigilance + Tensioned Care) |
| `assignments/ENGL-1110/essay1-catchup-plan.md` | Salvage workflow & thesis templates | Provide thesis skeleton references |
| `assignments/ENGL-1110/personal-narrative-integration-guide.md` | How to embed personal stories | Insert anecdote length constraints |
| `assignments/ENGL-1110/essay-outlines-and-chat-prompts.md` | Global prompt scripts & outlines | Pull thesis formula & style checks |

---

## 3. Personal Experience Themes (Your Reusable Inputs)

| Token Name | Short Description (You Fill) | Emotional Labels (from tone map) | Use Context |
|------------|------------------------------|----------------------------------|------------|
| [ANEC_CODESWITCH] | Moment adjusting speech to avoid misread | Vigilance / Containment | Safety or Gatekeeping discussion |
| [ANEC_HEADLINE] | Media flattening of nuanced situation | Containment / Fatigue | Gatekeeping angle |
| [ANEC_FAMILY] | Family debate about exposure / speaking | Tensioned Care / Vigilance | Safety angle |
| [ANEC_SILENCE] | Choosing not to respond to protect self | Vigilance / Agency | Essay 1 reflective close |

Fill these with 1–2 sentence snapshots before running prompts.

---

## 4. CORE SYSTEM PROMPT (Paste into ChatGPT Before Anything Else)

```text
SYSTEM ROLE: You are an academic writing assistant helping produce a discussion post (≈275 words) on The Hate U Give, Chapters 11–15 and a salvage draft of a late literary analysis essay. You MUST:
- Never fabricate or fully quote the novel; use bracketed placeholders like [FRAG 1], [FRAG 2].
- Ask for missing user inputs only once at top if placeholders are blank.
- Prioritize analysis of craft mechanisms (register shift, interruption, paraphrase compression) over plot recap.
- Integrate ONE personal anecdote placeholder (max 2 sentences) then pivot back with an analytical verb (e.g., "calibrates", "negotiates").
- Maintain emotional pairing chosen (e.g., Vigilance + Tensioned Care) using tone map vocabulary.
- Output clearly labeled sections.
- Avoid moralizing generalities; keep abstraction nouns precise (narrative economy, cognitive triage, lexical power).
If user does not supply required fragments, output a TODO list section at top identifying exact missing items.
```

---

## 5. DISCUSSION POST PROMPTS (Choose ONE Angle)

### 5A. Safety vs Activism Angle Prompt

```text
TASK: Generate a 275-word discussion post for HUG Ch. 11–15 using SAFETY VS ACTIVISM angle.
INPUTS:
- Claim Seed: Starr’s decision to speak is a negotiated familial risk calculus, not a spontaneous moral leap.
- Emotional Pairing: Vigilance + Tensioned Care.
- Anecdote Placeholder: [ANEC_FAMILY] (2 sentences max).
REQUIREMENTS:
1. Sections: Hook, Claim, Analysis 1 (family scene micro-moment), Analysis 2 (internal vs external register), Synthesis, Open Question.
2. Insert exactly TWO fragment placeholders: [FRAG 1] (pause / hesitation beat), [FRAG 2] (interior fragmentation or polished external line).
3. After each fragment: HOW (mechanism) → WHY (interpretive meaning) → THEME (collective negotiation of risk).
4. Use at least three mechanism verbs from: calibrates, negotiates, modulates, repositions.
5. End with an open-ended question starting with Where / How.
6. No paragraph ends with a placeholder.
OUTPUT: Provide final draft + checklist indicating compliance.
```

### 5B. Media Gatekeeping Angle Prompt

```text
TASK: Generate 275-word discussion post on MEDIA GATEKEEPING in HUG Ch. 11–15.
INPUTS:
- Claim Seed: Media framing pre-loads moral categories, forcing Starr into cognitive triage before truth can advance.
- Emotional Pairing: Vigilance + Containment.
- Anecdote Placeholder: [ANEC_HEADLINE].
REQUIREMENTS:
1. Sections: Hook, Claim, Mechanism 1 (label narrowing), Mechanism 2 (paraphrase compression), Cognitive Labor analysis, Synthesis, Question.
2. Placeholders: [LABEL FRAG], [PARA FRAG].
3. Introduce term narrative economy in synthesis.
4. Use verbs: compresses, reframes, pre-loads, reclaims (pick at least 3).
5. Final question: "How does anticipatory self-editing reshape our sense of witness credibility?"
6. Provide a short (<=25 words) peer reply template at end.
OUTPUT: Draft + Compliance Checklist.
```

---

## 6. LATE ESSAY 1 SALVAGE PROMPTS

### 6A. Outline & Thesis Refresh

```text
TASK: Produce a salvage outline for Essay 1 (Literary Analysis) ~1000 words.
INPUTS: Thesis Seed = Thomas’s juxtaposition of internal fragmentation and externally calibrated diction reframes voice as negotiated survival labor rather than adolescent uncertainty.
Use Body Sections: Mechanism 1 (internal vs external syntax), Mechanism 2 (dialogic interruption & hesitation), Optional Complexity (apparent emotional distance), Style Pivot (labor cost), Conclusion (implication + positional resonance via [ANEC_CODESWITCH]).
For each body: list Claim Sentence, [QUOTE X] placeholder (<12 words), HOW term, WHY thematic impact, Link back phrase.
OUTPUT: Bullet outline + risk of over-reliance warning + 2 possible thesis refinements.
```

### 6B. Body Paragraph Drafting

```text
TASK: Draft Body Paragraph (170–190 words) for Mechanism 1.
INPUTS: [QUOTE 1], Emotional Pairing = Vigilance + Containment.
REQUIREMENTS: 1 sentence context, placeholder, 3–4 sentence close reading (syntax pattern → cognitive labor), interpretive turn (negotiated survival), mini-link forward.
OUTPUT: Paragraph + suggestion for transitional hook into Mechanism 2.
```

### 6C. Revision Pass (Style & Tone)

```text
TASK: Style upgrade pass.
INPUT: Paragraph text.
REQUIREMENTS: Replace vague verbs, add one analytical noun (e.g., register calculus), shorten one long sentence, ensure no sentence ends with placeholder, list 3 edits in a change log.
```

---

## 7. REVISION DIAGNOSTIC PROMPT (Self-Check)

```text
TASK: Diagnose weaknesses.
INPUT: Full draft discussion post.
CHECK:
- Are HOW steps appearing before WHY claims?
- Are placeholders replaced?
- Is anecdote ≤ 2 sentences?
- Are emotional labels reflected by mechanism terms?
OUTPUT: Table listing Issue | Evidence | Fix Suggestion.
```

---

## 8. PLACEHOLDERS YOU MUST FILL BEFORE FINAL SUBMISSION

| Placeholder | What To Add | Source |
|-------------|-------------|-------|
| [FRAG 1], [FRAG 2] | Short textual fragments (<10–12 words) | Ch. 11–15 notes |
| [LABEL FRAG] | Labeling instance | Media scene |
| [PARA FRAG] | Compressed paraphrase moment | Interview segment |
| [QUOTE 1], [QUOTE 2], [QUOTE 3] | Essay body micro-quotes | Annotated novel |
| [ANEC_CODESWITCH] | 2-sentence personal snapshot | Your experience |
| [ANEC_FAMILY] | Family negotiation snapshot | Your experience |
| [ANEC_HEADLINE] | Headline framing anecdote | Your experience |

---

## 9. OUTPUT CHECKLIST (Use for Any AI Result)

| Criterion | Yes/No |
|-----------|--------|
| No fabricated quotations (only placeholders or your filled fragments) |  |
| Each fragment followed by HOW → WHY |  |
| At least 3 analytical verbs appear |  |
| Anecdote pivot line returns to text |  |
| Emotional pairing vocabulary present |  |
| Open question invites textual engagement |  |

---

## 10. SUBMISSION ROUTE SUMMARY

| Work Type | Where to Turn In | Formatting Reminder |
|-----------|------------------|---------------------|
| Discussion Post | LMS > Discussions > Week 3 (HUG Ch. 11–15) | Paste plain text; keep quotes short |
| Essay 1 Salvage | LMS > Assignments > Essay 1 Final Draft | MLA heading + double-spaced (in doc or PDF) |
| Peer Replies | Same thread | 100–150 words; extend, reframe, or question |

---

## 11. WHEN TO ASK FOR MORE INFO (AI Should Prompt You If)

- Missing any [ANEC_*] anecdote placeholders.
- Thesis seed absent or too plot-like.
- Less than two mechanism terms supplied.

---

## 12. QUICK START WORKFLOW (You Today)

1. Fill anecdote placeholders in Section 3.
2. Run 5A or 5B prompt for discussion draft.
3. Replace placeholders with real fragments from chapters.
4. Run Revision Diagnostic (Section 7) on result.
5. Fill Quote placeholders for Essay 1; run 6A then 6B for first body paragraph.
6. Apply Style Pass (6C).

---

## 13. OPTIONAL: Provide Your Answers Here Before Prompting

| Placeholder | Your Entry |
|-------------|-----------|
| [ANEC_CODESWITCH] |  |
| [ANEC_HEADLINE] |  |
| [ANEC_FAMILY] |  |
| Thesis (Essay 1) |  |

---

## 14. Need Tailored Claim Variants?

If undecided, ask: "Generate 3 refined claims for [Safety OR Gatekeeping] using mechanism verbs." Paste best one into prompt.

---
*Keep this file as your control center. Always run AI prompts from here so outputs stay consistent with course expectations.*
