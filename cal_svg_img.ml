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
let lang = "sl"  (* language: Slovenian *)
let lang = "en"  (* language: English *)
let lang = "fr"  (* language: French *)

let lang =
  try Sys.argv.(2) with _ -> lang


(* SVG *)

let new_svg_document ~width ~height () =
  let b = Buffer.create 100 in
  Printf.kprintf (Buffer.add_string b)
    {|<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
  version="1.1"
  baseProfile="full"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
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

let add_rect b ~x ~y ~width ~height ~fill ~stroke ~stroke_width =
  Printf.kprintf (Buffer.add_string b) {|
<rect x="%d" y="%d" width="%d" height="%d" fill="%s" stroke="%s" stroke-width="%g" />|}
  x y width height fill stroke stroke_width;
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

let load_file fn =
  let ic = open_in fn in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  (Bytes.unsafe_to_string s)


let add_image b fn () =
  let img = load_file fn in
  let s64 =
    match Base64.encode img with Ok s -> s
    | Error (`Msg msg) -> prerr_endline msg; exit 1
  in
  Printf.kprintf (Buffer.add_string b) {|
<image
  y="0"
  x="0"
  width="210"
  height="140"
  preserveAspectRatio="none"
  xlink:href="data:image/jpeg;base64,%s" />
|} s64 ;;


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
  "sl", "koledar";
  "ru", "календарь";
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
  "sl", [|
    "januar"; "februar"; "marec"; "april";
    "maj"; "junij"; "julij"; "avgust";
    "september"; "oktober"; "november"; "december";
  |];
  "ru", [|
    "январь"; "февраль"; "март"; "апрель";
    "май"; "июнь"; "июль"; "август";
    "сентябрь"; "октябрь"; "ноябрь"; "декабрь";
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
  "sl", [| "ponedeljek"; "torek"; "sreda";
    "četrtek"; "petek"; "sobota"; "nedelja" |];
  "ru", [| "понедельник"; "вторник"; "среда";
    "четверг"; "пятница"; "суббота"; "воскресенье" |];
]


let days = List.assoc lang days_lang
let months = List.assoc lang months_lang

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
  [| 0;  0;  1;  2;  3;  4;  5|];
  [| 6;  7;  8;  9; 10; 11; 12|];
  [|13; 14; 15; 16; 17; 18; 19|];
  [|20; 21; 22; 23; 24; 25; 26|];
  [|27; 28; 29; 30; 31;  0;  0|];
  [| 0;  0;  0;  0;  0;  0;  0|];
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


let current_year_and_month () =
  let t = Unix.localtime (Unix.time ()) in
  (t.Unix.tm_year  + 1900,
   t.Unix.tm_mon + 1)


let _imgs = [|
  (* CC0 Images from AltPhotos.com: *)
  (* https://altphotos.com/free/dog/ *)
  (* See the file "dogs-calendar-credits.txt" for more details. *)
  "_imgs_cc0/dogs/animal-dog-border-collie.jpg";
  "_imgs_cc0/dogs/black-dog-portrait.jpg";
  "_imgs_cc0/dogs/car-dog.jpg";
  "_imgs_cc0/dogs/cute-puppy-grass.jpg";
  "_imgs_cc0/dogs/dog-sleep-l.jpg";
  "_imgs_cc0/dogs/dog-sofa.jpg";
  "_imgs_cc0/dogs/dogs-run-sea.jpg";
  "_imgs_cc0/dogs/french-bulldog.jpg";
  "_imgs_cc0/dogs/jack-russell-terrier-grass-frisbee.jpg";
  "_imgs_cc0/dogs/shepherd.jpg";
  "_imgs_cc0/dogs/winter-husky-dog.jpg";
  "_imgs_cc0/dogs/wolf-closeup-winter.jpg";
|]

let _imgs = [|
  (* CC0 Images from AltPhotos.com: *)
  (* https://altphotos.com/ *)
  (* See the file "night-city-calendar-credits.txt" for more details. *)
  "_imgs_cc0/alt/sort-todo/city-night/bay-night-singapore.jpg";
  "_imgs_cc0/alt/sort-todo/city-night/city-night-bridge.jpg";
  "_imgs_cc0/alt/sort-todo/city-night/city-night.jpg";
  "_imgs_cc0/alt/sort-todo/city-night/dubai-aerial-night-burj-khalifa.jpg";
  "_imgs_cc0/alt/sort-todo/city-night/long-exposure-city-traffic.jpg";
  "_imgs_cc0/alt/sort-todo/city-night/night-lights-trail.3.jpg";
  "_imgs_cc0/alt/sort-todo/city-night/san-francisco-night.jpg";
  "_imgs_cc0/alt/sort-todo/city-night/singapore-night-bay.jpg";
  "_imgs_cc0/alt/sort-todo/city-night/singapore-night.jpg";
  "_imgs_cc0/alt/sort-todo/city-night/times-square-night.jpg";
  "_imgs_cc0/alt/sort-todo/city-night/singapore-night-temple-asia.jpg";
  "_imgs_cc0/alt/sort-todo/city-night/traffic-city-night.jpg";
|]

let imgs = [|
  (* https://en.wikipedia.org/wiki/Thirty-six_Views_of_Mount_Fuji
   *
   * Thirty-six Views of Mount Fuji is a series of landscape printscreated by
   * the Japanese ukiyo-e artist Hokusai (1760–1849).
   * The series depicts Mount Fuji from different locations and in various seasons
   * and weather conditions.
   *)
  "_imgs_cc0/japan/800px-Fuji_seen_through_the_Mannen_bridge_at_Fukagawa.jpg";
  "_imgs_cc0/japan/800px-Katsushika_Hokusai,_Goten-yama_hill,_Shinagawa_on_the_Tōkaidō,_ca._1832.jpg";
  "_imgs_cc0/japan/800px-Sazai_hall_-_500_Rakan_temples.jpg";
  "_imgs_cc0/japan/800px-Senju_in_the_Musachi_provimce.jpg";
  "_imgs_cc0/japan/800px-Shimomeguro.jpg";
  "_imgs_cc0/japan/800px-Sunset_across_the_Ryogoku_bridge_from_the_bank_of_the_Sumida_river_at_Onmagayashi.jpg";
  "_imgs_cc0/japan/800px-Surugadai_in_Edo_Mount_Fuji.jpg";
  "_imgs_cc0/japan/800px-The_coast_of_seven_leages_in_Kamakura.jpg";
  "_imgs_cc0/japan/800px-The_Tea_plantation_of_Katakura_in_the_Suruga_province.jpg";
  "_imgs_cc0/japan/800px-Tsukada_Island_in_the_Musashi_province.jpg";
  "_imgs_cc0/japan/800px-Ushibori_in_the_Hitachi_province.jpg";
  "_imgs_cc0/japan/Lower_Meguro_Shimo_Meguro_Mount_Fuji.jpg";
|]


let () =
  let year, mon =
    try Scanf.sscanf Sys.argv.(1) "%d-%d" (fun y m -> (y, m))
    with _ -> current_year_and_month ()
  in

  let svg = new_svg_document ~width:210 ~height:297 () in

  add_image svg imgs.(pred mon) ();

  begin_group svg ~translate:(0.5, 140.0) ~scale:(0.7, 0.7);
  add_newline svg;

  (* Title: Month and Year *)
  let text = Printf.sprintf "%s %d" (String.capitalize_ascii months.(pred mon)) year in
  add_text svg ~x:150 ~y:21 ~text_anchor:"middle" ~font_family:"sans-serif" ~font_size:12.0 ~font_weight:"bold" ~fill:"#444" ~text;
  add_newline svg;

  (* Labels: days names *)
  for i = 0 to 6 do
    let x = 10 + i * 40 in
    add_rect svg ~x ~y:30 ~width:40 ~height:10 ~fill:"#AAB" ~stroke:"#000" ~stroke_width:0.3;
    let x = 30 + i * 40 in
    let text = String.capitalize_ascii days.(days_order.(i)) in
    add_text svg ~x ~y:37 ~text_anchor:"middle" ~font_family:"sans-serif" ~font_size:5.0 ~font_weight:"bold" ~fill:"#FFF" ~text;
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

  for w = 0 to num_rows do  (* for each row of the month *)
    for i = 0 to 6 do  (* for each day *)
      let x = 10 + i * 40 in
      let y = 40 + w * cell_height in
      let d = m.(w).(i) in
      if d = 0 then begin
        if w = 0 then
          add_rect svg ~x ~y ~width:40 ~height:cell_height ~fill:"#E8E8EB" ~stroke:"#000" ~stroke_width:0.3
      end else begin
        add_rect svg ~x ~y ~width:40 ~height:cell_height ~fill:"#FFF" ~stroke:"#000" ~stroke_width:0.3;
        let text = Printf.sprintf "%d" d in
        add_text svg ~x:(x+2) ~y:(y+7) ~text_anchor:"right" ~font_family:"sans-serif" ~font_size:5.2 ~font_weight:"bold" ~fill:"#778" ~text;
      end;
    done;
    add_newline svg;
  done;
  end_group svg;
  add_newline svg;
  finish_svg svg;
  print_string (get_svg_document svg);
;;

