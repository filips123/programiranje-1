open Avtomat

type stanje_vmesnika =
  | SeznamMoznosti
  | IzpisAvtomata
  | BranjeNiza
  | RezultatPrebranegaNiza
  | OpozoriloONapacnemNizu

type model = {
  avtomat : avtomat;
  stanje_avtomata : stanje;
  stanje_vmesnika : stanje_vmesnika;
}

type msg = PreberiNiz of string | ZamenjajVmesnik of stanje_vmesnika

let update model = function
  | PreberiNiz str -> (
      match Avtomat.preberi_niz model.avtomat model.stanje_avtomata str with
      | None -> { model with stanje_vmesnika = OpozoriloONapacnemNizu }
      | Some stanje_avtomata ->
          {
            model with
            stanje_avtomata;
            stanje_vmesnika = RezultatPrebranegaNiza;
          })
  | ZamenjajVmesnik stanje_vmesnika -> { model with stanje_vmesnika }

let rec izpisi_moznosti () =
  print_endline "1) izpiši avtomat";
  print_endline "2) preberi niz";
  print_string "> ";
  match read_line () with
  | "1" -> ZamenjajVmesnik IzpisAvtomata
  | "2" -> ZamenjajVmesnik BranjeNiza
  | _ ->
      print_endline "** VNESI 1 ALI 2 **";
      izpisi_moznosti ()

let izpisi_avtomat avtomat =
  let izpisi_stanje stanje =
    let prikaz = stanje.oznaka in
    let prikaz =
      if stanje = avtomat.zacetno_stanje then "-> " ^ prikaz else prikaz
    in
    let prikaz =
      if List.mem stanje avtomat.sprejemna_stanja then prikaz ^ " +" else prikaz
    in
    print_endline prikaz
  in
  List.iter izpisi_stanje avtomat.stanja

let beri_niz _model =
  print_string "Vnesi niz > ";
  let str = read_line () in
  PreberiNiz str

let izpisi_rezultat model =
  if List.mem model.stanje_avtomata model.avtomat.sprejemna_stanja then
    print_endline "Niz je bil sprejet"
  else print_endline "Niz ni bil sprejet"

let view model =
  match model.stanje_vmesnika with
  | SeznamMoznosti -> izpisi_moznosti ()
  | IzpisAvtomata ->
      izpisi_avtomat model.avtomat;
      ZamenjajVmesnik SeznamMoznosti
  | BranjeNiza -> beri_niz model
  | RezultatPrebranegaNiza ->
      izpisi_rezultat model;
      ZamenjajVmesnik SeznamMoznosti
  | OpozoriloONapacnemNizu ->
      print_endline "Niz ni veljaven";
      ZamenjajVmesnik SeznamMoznosti

let init avtomat =
  {
    avtomat;
    stanje_avtomata = avtomat.zacetno_stanje;
    stanje_vmesnika = SeznamMoznosti;
  }

let rec main_loop model =
  let msg = view model in
  let model' = update model msg in
  main_loop model'

let _ = main_loop (init ravno_prav_nicel)