def reverse {A: Type} : List A -> List A :=
  fun xs =>
    match xs with
    | [] => []
    | y :: ys => reverse ys ++ [y]

def reverse_aux {A: Type} : List A -> List A -> List A :=
  fun xs acc =>
    match xs with
    | [] => acc
    | y :: ys => reverse_aux ys (y :: acc)

def reverse_tr {A: Type} : List A -> List A :=
  fun xs =>
    reverse_aux xs []

theorem reverse_aux_is_reverse {A: Type} : ∀ {lst: List A}, ∀ {acc : List A}, reverse_aux lst acc = (reverse lst) ++ acc :=
  by
    intro lst
    induction lst with
    | nil =>
      intro acc
      simp [reverse_aux]
      simp [reverse]
    | cons x xs ih =>
      intro acc
      simp [reverse_aux]
      rw [ih]
      simp [reverse]

theorem reverse_tr_is_reverse {A: Type} {xs : List A} : reverse_tr xs = reverse xs :=
  by
    simp [reverse_tr]
    rw [reverse_aux_is_reverse]
    simp [reverse]
