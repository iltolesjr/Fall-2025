# Grade Calculator (What‑If Scenarios)

Use this to compute current/what‑if grades by points or weights.

## A) Points-based courses (e.g., ENGL 1110 — total 750 points)

Inputs:

- Total course points = 750
- Earned points so far = sum of completed assignments
- Future/unknown items: plug in assumptions

Formula:

- Current percent = (Earned points / 750) × 100
- What‑if percent = ((Earned so far + assumed future points) / 750) × 100

Example — ENGL 1110 midterm portfolio = 50 points:

- If midterm = 0 and all else = 100% of their points:
  - Let P = points from all other assignments
  - What‑if percent = (P / 750) × 100
- If midterm later allowed and scored M:
  - What‑if percent = ((P + M) / 750) × 100

## B) Weight-based courses (e.g., typical ITEC schemas)

Inputs per category (weights sum to 100%):

- Homework: w_H, average h
- Labs: w_L, average l
- Quizzes: w_Q, average q
- Midterm: w_M, score m
- Final: w_F, score f
- Projects: w_P, average p

Formula:

- Overall% = w_H·h + w_L·l + w_Q·q + w_M·m + w_F·f + w_P·p
  (Use weights as decimals, e.g., 20% → 0.20)

Scenario with midterm = 0:

- Overall% = w_H·h + w_L·l + w_Q·q + 0 + w_F·f + w_P·p

## Quick table to fill

Course: ____________

- Total points or weights: ____________
- Categories/Assignments with points/weights and your scores:

Notes:

- If a category isn’t graded yet, either exclude it (some LMS do running total) or include with neutral assumption.
- Double-check whether the LMS uses “equal weight by item” or “equal weight by category.”
