-- Izomorfizmi

theorem eq1 {A B : Prop} : (A ∧ B) ↔ (B ∧ A) :=
  by
    constructor -- apply Iff.intro
    intro ab
    constructor -- apply And.intro
    exact ab.right
    exact ab.left
    intro ba
    constructor -- apply And.intro
    exact ba.right
    exact ba.left

theorem eq2 {A B : Prop} : (A ∨ B) ↔ (B ∨ A) :=
  sorry

theorem eq3 {A B C : Prop} : (A ∧ (B ∧ C)) ↔ (B ∧ (A ∧ C)) :=
  sorry

theorem eq4 {A B C : Prop} : (A ∨ (B ∨ C)) ↔ (B ∨ (A ∨ C)) :=
  sorry

theorem eq5 {A B C : Prop} : A ∧ (B ∨ C) ↔ (A ∧ B) ∨ (A ∧ C) :=
  sorry

theorem eq6 {A B C : Prop} : (B ∨ C) → A ↔ (B → A) ∧ (C → A) :=
  by
    constructor

    intro h
    constructor

    intro b
    apply h
    left
    exact b

    intro c
    have xx : B ∨ C := Or.inr c
    have yy := h xx
    exact yy

    intro h
    intro bc
    cases bc

    case inl b =>
      apply h.left
      exact b

    case inr c =>
      apply h.right
      exact c

theorem eq7 {A B C : Prop} : C → (A ∧ B) ↔ (C → A) ∧ (C → B) :=
  sorry
