(* ========== Vaja 2: Uvod v funkcijsko programiranje  ========== *)

(*----------------------------------------------------------------------------*]
Vektorje predstavimo kot seznam števil s plavajočo vejico.
[*----------------------------------------------------------------------------*)

type vector = float list

(*----------------------------------------------------------------------------*]
Definirajte enotske vektorje `i`, `j` in `k` v treh dimenzijah.
[*----------------------------------------------------------------------------*)

let i = [ 1.; 0.; 0. ]
let j = [ 0.; 1.; 0. ]
let k = [ 0.; 0.; 1. ]

(*----------------------------------------------------------------------------*]
Napišite funkcijo `razteg : float -> vector -> vector`, ki vektor,
predstavljen s seznamom števil s plavajočo vejico, pomnoži z danim skalarjem.
[*----------------------------------------------------------------------------*)

let rec razteg skalar vektor = List.map (fun elem -> skalar *. elem) vektor

(*----------------------------------------------------------------------------*]
Napišite funkcijo `sestej : vector -> vector -> vector`, ki vrne vsoto dveh
vektorjev.
[*----------------------------------------------------------------------------*)

let rec sestej prvi drugi = List.map2 ( +. ) prvi drugi

(*----------------------------------------------------------------------------*]
Napišite funkcijo `skalarni_produkt : vector -> vector -> float`, ki izračuna
skalarni produkt dveh vektorjev
[*----------------------------------------------------------------------------*)

let rec skalarni_produkt prvi drugi = List.fold_left (+.) 0. (List.map2 ( *. ) prvi drugi)

(*----------------------------------------------------------------------------*]
Napišite funkcijo `norma : vector -> float`, ki vrne evklidsko normo vektorja.
[*----------------------------------------------------------------------------*)

let rec norma vektor = sqrt (skalarni_produkt vektor vektor)

(*----------------------------------------------------------------------------*]
Napišite funkcijo `projeciraj : vector -> vector -> vector`, ki izračuna
projekcijo prvega vektorja na drugega.
[*----------------------------------------------------------------------------*)

let rec projeciraj prvi drugi = razteg (skalarni_produkt prvi drugi) (razteg (1. /. norma drugi) drugi)

(*----------------------------------------------------------------------------*]
Napišite funkcijo `ovij : string -> string -> string`, ki sprejme ime HTML
oznake in vsebino ter vrne niz, ki predstavlja ustrezno HTML oznako.

Primer:
`ovij "h1" "Hello, world!"`

[*----------------------------------------------------------------------------*)

let rec ovij oznaka niz = "<" ^ oznaka ^ ">" ^ niz ^ "</" ^ oznaka ^ ">"

(*----------------------------------------------------------------------------*]
Napišite funkcijo `zamakni : int -> string -> string`, ki sprejme število
presledkov in niz ter vrne niz, v katerem je vsaka vrstica zamaknjena za ustrezno število presledkov.

Primer:
`zamakni 4 "Hello, world!"`

[*----------------------------------------------------------------------------*)

let rec zamakni zamik niz =
    let presledki = String.make zamik ' ' in
    niz
    |> String.split_on_char '\n'
    |> List.map (String.cat presledki)
    |> String.concat "\n"

(*----------------------------------------------------------------------------*]
Napišite funkcijo `ul : string list -> string`, ki sprejme seznam nizov in vrne
niz, ki predstavlja ustrezno zamaknjen neurejeni seznam v HTML-ju:

Primer:
`ul ["ananas"; "banana"; "čokolada"]`

[*----------------------------------------------------------------------------*)

let rec ul seznam =
    seznam
    |> List.map (ovij "li")
    |> String.concat "\n"
    |> zamakni 2
    |> (fun vsebina -> "\n" ^ vsebina ^ "\n")
    |> ovij "ul"

(*----------------------------------------------------------------------------*]
Napišite funkcijo `razdeli_vrstico : string -> string * string`, ki sprejme niz,
ki vsebuje vejico, loči na del pred in del za njo.

Primer:
`razdeli_vrstico "mleko, 2"`

[*----------------------------------------------------------------------------*)

let rec razdeli_vrstico niz =
    let indeks = String.index niz ',' in
    let prvi = String.sub niz 0 indeks in
    let drugi = String.sub niz (indeks + 1) (String.length niz - indeks - 1) in
    (String.trim prvi, String.trim drugi)

(*----------------------------------------------------------------------------*]
Napišite funkcijo `pretvori_v_seznam_parov : string -> (string * string) list`,
ki sprejme večvrstični niz, kjer je vsaka vrstica niz oblike
"izdelek, vrednost", in vrne seznam ustreznih parov.

Primer:
`pretvori_v_seznam_parov "mleko, 2\nkruh, 1\njabolko, 5"`

[*----------------------------------------------------------------------------*)

let pretvori_v_seznam_parov niz =
  niz
  |> String.trim
  |> String.split_on_char '\n'
  |> List.map razdeli_vrstico

(*----------------------------------------------------------------------------*]
Napišite funkcijo `pretvori_druge_komponente : ('a -> 'b) -> (string * 'a) list -> (string * 'b) list`,
ki dano funkcijo uporabi na vseh drugih komponentah elementov seznama.

Primer:
```ml
let seznam = [("ata", "mama"); ("teta", "stric")] in
pretvori_druge_komponente String.length seznam
```

[*----------------------------------------------------------------------------*)

let rec pretvori_druge_komponente funkcija seznam = List.map (fun (x, y) -> (x, funkcija y)) seznam

(*----------------------------------------------------------------------------*]
Napišite funkcijo `izracunaj_skupni_znesek : string -> string -> float`, ki
sprejme večvrstična niza nakupovalnega seznama in cenika in izračuna skupni
znesek nakupa.

Primer:
```ml
let nakupovalni_seznam = "mleko, 2\njabolka, 5"
and cenik = "jabolka, 0.5\nkruh, 2\nmleko, 1.5" in
izracunaj_skupni_znesek cenik nakupovalni_seznam
```

[*----------------------------------------------------------------------------*)

let rec izracunaj_skupni_znesek cenik seznam =
  let cene =
    cenik
    |> pretvori_v_seznam_parov
    |> pretvori_druge_komponente float_of_string
  in

  let cena_izdelka (izdelek, kolicina) =
    let cena = List.assoc izdelek cene in
    float_of_int kolicina *. cena
  in

  seznam
  |> pretvori_v_seznam_parov
  |> pretvori_druge_komponente int_of_string
  |> List.map cena_izdelka
  |> List.fold_left (+.) 0.
