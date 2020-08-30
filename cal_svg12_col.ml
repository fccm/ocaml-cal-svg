(* A Simple Calendar Generator in SVG
 Copyright (C) 2020 Florent Monnier
 
 This software is provided "AS-IS", without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.
 
 Permission is granted to anyone to use this software and associated elements
 for any purpose, including commercial applications, and to alter it and
 redistribute it freely.
*)
#load "unix.cma"

let lang = "de"  (* language: German *)
let lang = "es"  (* language: Spanish *)
let lang = "it"  (* language: Italian *)
let lang = "nl"  (* language: Dutch *)
let lang = "da"  (* language: Danish *)
let lang = "id"  (* language: Indonesian *)
let lang = "pt"  (* language: Portuguese *)
let lang = "no"  (* language: Norwegian *)
let lang = "en"  (* language: English *)
let lang = "fr"  (* language: French *)


(* SVG *)

let new_svg_document ~width ~height () =
  let b = Buffer.create 10 in
  Printf.kprintf (Buffer.add_string b) {|<?xml version="1.0" standalone="no"?>
<svg
  version="1.1"
  baseProfile="full"
  xmlns="http://www.w3.org/2000/svg"
  width="%dmm"
  height="%dmm"
  viewBox="0 0 %d %d">
|} width height width height;
  (b)

let finish_svg b =
  Buffer.add_string b "\n</svg>\n";
;;

let add_text b ~x ~y ~text_anchor ~font_family ~font_size ~font_weight ~fill ~text =
  Printf.kprintf (Buffer.add_string b) {|
<text x="%d" y="%d" text-anchor="%s" font-family="%s" font-size="%g" font-weight="%s" fill="%s">%s</text>|}
  x y text_anchor font_family font_size font_weight fill text;
;;

let add_rect b ~x ~y ~width ~height ~fill ~stroke ~stroke_width ?fill_opacity () =
  let fill_opacity = match fill_opacity with None -> "" | Some v -> Printf.sprintf " fill-opacity=\"%g\"" v in
  Printf.kprintf (Buffer.add_string b) {|
<rect x="%d" y="%d" width="%d" height="%d" fill="%s" stroke="%s" stroke-width="%g"%s />|}
  x y width height fill stroke stroke_width fill_opacity;
;;

let begin_group b ~translate:(tx, ty) ~scale:(sx, sy) =
  Printf.kprintf (Buffer.add_string b) {|
<g transform="translate(%g %g) scale(%g %g)">|} tx ty sx sy;
;;

let end_group b =
  Buffer.add_string b "\n</g>\n";
;;

let add_newline b =
  Buffer.add_char b '\n';
;;

let get_svg_document b =
  (Buffer.contents b)


(* Labels *)

let cal_lang = [
  "en", "calendar";
  "fr", "calendrier";
  "de", "Kalender";
  "es", "calendario";
  "it", "calendario";
  "nl", "kalender";
  "da", "kalender";
  "id", "kalendar";
  "pt", "calendário";
  "no", "kalender";
]

let months_lang = [
  "en", [|
    "January"; "February"; "March"; "April";
    "May"; "June"; "July"; "August"; "September";
    "October"; "November"; "December";
  |];
  "fr", [|
    "janvier"; "février"; "mars"; "avril"; "mai";
    "juin"; "juillet"; "août"; "septembre";
    "octobre"; "novembre"; "décembre";
  |];
  "de", [|
    "Januar"; "Februar"; "März"; "April"; "Mai";
    "Juni"; "Juli"; "August"; "September";
    "Oktober"; "November"; "Dezember";
  |];
  "es", [|
    "enero"; "febrero"; "marzo"; "abril";
    "mayo"; "junio"; "julio"; "agosto";
    "septiembre"; "octubre"; "noviembre"; "diciembre";
  |];
  "it", [|
    "gennaio"; "febbraio"; "marzo"; "aprile";
    "maggio"; "giugno"; "luglio"; "agosto";
    "settembre"; "ottobre"; "novembre"; "dicembre";
  |];
  "nl", [|
    "januari"; "februari"; "maart"; "april";
    "mei"; "juni"; "juli"; "augustus";
    "september"; "oktober"; "november"; "december";
  |];
  "da", [|
    "januar"; "februar"; "marts"; "april";
    "maj"; "juni"; "juli"; "august";
    "september"; "oktober"; "november"; "december";
  |];
  "id", [|
    "Januari"; "Februari"; "Maret"; "April"; "Mei";
    "Juni"; "Juli"; "Agustus"; "September";
    "Oktober"; "November"; "Desember";
  |];
  "pt", [|
    "janeiro"; "fevereiro"; "março"; "abril";
    "maio"; "junho"; "julho"; "agosto";
    "setembro"; "outubro"; "novembro"; "dezembro";
  |];
  "no", [|
    "januar"; "februar"; "mars"; "april";
    "mai"; "juni"; "juli"; "august";
    "september"; "oktober"; "november"; "desember";
  |];
]


let days_lang = [
  "en", [| "Monday"; "Tuesday"; "Wednesday";
    "Thursday"; "Friday"; "Saturday"; "Sunday" |];
  "fr", [| "lundi"; "mardi"; "mercredi";
    "jeudi"; "vendredi"; "samedi"; "dimanche" |];
  "de", [| "Montag"; "Dienstag"; "Mittwoch";
    "Donnerstag"; "Freitag"; "Samstag"; "Sonntag" |];
  "es", [| "lunes"; "martes"; "miércoles";
    "jueves"; "viernes"; "sábado"; "domingo" |];
  "it", [| "lunedì"; "martedì"; "mercoledì";
    "giovedì"; "venerdì"; "sabato"; "domenica" |];
  "nl", [| "maandag"; "dinsdag"; "woensdag";
    "donderdag"; "vrijdag"; "zaterdag"; "zondag" |];
  "da", [| "mandag"; "tirsdag"; "onsdag";
    "torsdag"; "fredag"; "lørdag"; "søndag" |];
  "id", [| "Senin"; "Selasa"; "Rabu";
    "Kamis"; "Jumat"; "Sabtu"; "Minggu" |];
  "pt", [| "segunda-feira"; "terça-feira"; "quarta-feira";
    "quinta-feira"; "sexta-feira"; "sábado"; "domingo" |];
  "no", [| "mandag"; "tirsdag"; "onsdag"; "torsdag";
    "fredag"; "lørdag"; "søndag" |];
]

 
let days = List.assoc lang days_lang
let months = List.assoc lang months_lang
let cal = List.assoc lang cal_lang
 
let monday_first = 6, [| 0; 1; 2; 3; 4; 5; 6 |]
let sunday_first = 0, [| 6; 0; 1; 2; 3; 4; 5 |]
 
let off, days_order = sunday_first
let off, days_order = monday_first
 
 
let t_same t1 t2 =
  ( t1.Unix.tm_year = t2.Unix.tm_year &&
    t1.Unix.tm_mon  = t2.Unix.tm_mon &&
    t1.Unix.tm_mday = t2.Unix.tm_mday )
 

let indices ofs =
  (ofs / 7, ofs mod 7)
 

(*
let t = Unix.gmtime 0.0 in
  make_month t 2020 0 ;; 
- : int array array =
 [|
  [| 0;  0;  1;  2;  3;  4 ; 5|];
  [| 6;  7;  8;  9; 10; 11; 12|];
  [|13; 14; 15; 16; 17; 18; 19|];
  [|20; 21; 22; 23; 24; 25; 26|];
  [|27; 28; 29; 30; 31;  0;  0|];
  [|0; 0; 0; 0; 0; 0; 0|]
 |]
*)
let make_month t year month =
  let empty_day = 0 in
  let m = Array.make_matrix 6 7 empty_day in
  let ofs = ref 0 in
  for day = 1 to 31 do
    let tm =
      { t with
        Unix.tm_year = year - 1900;
        Unix.tm_mon = month;
        Unix.tm_mday = day;
      }
    in
    (* with Unix.mktime '40 October' is changed into '9 November' *)
    let _, this = Unix.mktime tm in
    if !ofs = 0 then ofs := (this.Unix.tm_wday + off) mod 7;
    if t_same this tm then
      let i, j = indices !ofs in
      m.(i).(j) <- day;
    incr ofs;
  done;
  (m)
 

let current_year () =
  let t = Unix.localtime (Unix.time ()) in
  (t.Unix.tm_year  + 1900)


let () =
  let year =
    try int_of_string Sys.argv.(1)
    with _ -> current_year ()
  in

  let svg = new_svg_document ~width:297 ~height:210 () in
  add_rect svg ~x:0 ~y:0 ~width:297 ~height:210 ~fill:"#BBB" ~stroke:"#BBB" ~stroke_width:0.0 ();

  (* Year and title *)
  let text = Printf.sprintf "%s %d" (String.capitalize_ascii cal) year in
  add_text svg ~x:16 ~y:16 ~text_anchor:"left" ~font_family:"sans-serif" ~font_size:7.4 ~font_weight:"bold" ~fill:"#555" ~text;
  add_newline svg;

  for mon = 1 to 12 do  (* for each month *)

    let tx, ty =
      let m = pred mon in
      float (18 + (m mod 4) * 68),
      float (26 + (m / 4) * 60)
    in

    begin_group svg ~translate:(tx, ty) ~scale:(0.27, 0.27);

    (* Month label *)
    add_rect svg ~x:4 ~y:6 ~width:210 ~height:24 ~fill:"#24D" ~stroke:"#000" ~stroke_width:0.0 ~fill_opacity:0.3 ();
    let text = String.capitalize_ascii months.(pred mon) in
    add_text svg ~x:12 ~y:22 ~text_anchor:"left" ~font_family:"sans-serif" ~font_size:13.0 ~font_weight:"bold" ~fill:"#444" ~text;
    add_newline svg;

    (* Labels: days names *)
    for i = 0 to 6 do
      let x = 4 + i * 30 in
      add_rect svg ~x ~y:30 ~width:30 ~height:14 ~fill:"#CCF" ~stroke:"#000" ~stroke_width:0.0 ~fill_opacity:0.3 ();
      let x = 19 + i * 30 in
      let text = String.capitalize_ascii days.(days_order.(i)) in
      let text = String.sub text 0 3 in
      add_text svg ~x ~y:40 ~text_anchor:"middle" ~font_family:"sans-serif" ~font_size:8.0 ~font_weight:"normal" ~fill:"#000" ~text;
    done;
    add_newline svg;

    let t = Unix.gmtime 0.0 in
    let m = make_month t year (pred mon) in

    let len = Array.length m in
    let num_rows =
      if m.(len-1).(0) = 0
      then (len-2)
      else (len-1)
    in
    let cell_height = 28 in

    (* Day Numbers *)
    for w = 0 to num_rows do  (* for each row of the month *)
      for i = 0 to 6 do  (* for each day *)
        let x = 4 + i * 30 in
        let y = 44 + w * cell_height in
        let d = m.(w).(i) in
        if d = 0 then begin
          if w = 0 then add_rect svg ~x ~y ~width:30 ~height:cell_height ~fill:"#FFF" ~stroke:"#FFF" ~stroke_width:0.0 ~fill_opacity:0.2 ()
        end else begin
          add_rect svg ~x ~y ~width:30 ~height:cell_height ~fill:"#FFF" ~stroke:"#FFF" ~stroke_width:0.0 ~fill_opacity:0.3 ();
          let text = Printf.sprintf "%d" d in
          add_text svg ~x:(x+15) ~y:(y+18) ~text_anchor:"middle" ~font_family:"sans-serif" ~font_size:14.0 ~font_weight:"normal" ~fill:"#222" ~text;
        end;
      done;
      add_newline svg;
    done;
    end_group svg;
  done;
  add_newline svg;
  finish_svg svg;
  print_string (get_svg_document svg);
;;

