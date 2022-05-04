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
let lang = "uk"  (* language: Ukrainian *)
let lang = "ru"  (* language: Russian *)
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
  width="%dmm"
  height="%dmm"
  viewBox="0 0 %d %d">
|} width height width height;
  (b)

let finish_svg b =
  Buffer.add_string b "\n</svg>\n";
;;


let new_css () = ref []

let fill           = "fill"
let fill_opacity   = "fill-opacity"
let stroke         = "stroke"
let stroke_width   = "stroke-width"
let stroke_opacity = "stroke-opacity"
let font_size      = "font-size"
let font_style     = "font-style"
let font_weight    = "font-weight"
let font_family    = "font-family"
let text_anchor    = "text-anchor"
let letter_spacing = "letter-spacing"
let word_spacing   = "word-spacing"

let css_add css ~selector ~style =
  css := (selector, style) :: !css

let add_css_to_svg css b =
  Printf.kprintf (Buffer.add_string b) {|
<style type="text/css">
<![CDATA[
|};

  List.iter (fun (selector, styles) ->
    Printf.kprintf (Buffer.add_string b) "\n%s {\n" selector;
    List.iter (fun (attr, value) ->
      Printf.kprintf (Buffer.add_string b) "  %s: %s;\n" attr value;
    ) styles;
    Printf.kprintf (Buffer.add_string b) "}\n";
  ) (List.rev !css);

  Printf.kprintf (Buffer.add_string b) {|
]]>
</style>
|};
;;


let add_blur_filter b ~id ~stdDeviation () =
  Printf.kprintf (Buffer.add_string b) {|
  <defs>
    <filter
       id="%s"
       x="-0.2"
       y="-0.2"
       width="1.4"
       height="1.4">
      <feGaussianBlur stdDeviation="%g" />
    </filter>
  </defs>
|} id stdDeviation;
;;

let add_linear_gradient_background b () =
  Printf.kprintf (Buffer.add_string b) {|
  <defs>
    <linearGradient
       id="linearGradient1956"
       x1="1" y1="26"
       x2="1" y2="254"
       gradientUnits="userSpaceOnUse">
      <stop offset="0" style="stop-color:#ff6309;stop-opacity:0.5;" />
      <stop offset="1" style="stop-color:#ff6309;stop-opacity:0.1;" />
    </linearGradient>
  </defs>
  <rect x="0" y="0" width="297" height="210"
     style="fill:url(#linearGradient1956);fill-opacity:1" />
|}
;;

let add_ubuntu_logo b () =
  Printf.kprintf (Buffer.add_string b) {|

<!--
Ubunto Logo:
https://fr.m.wikipedia.org/wiki/Fichier:Ubuntu-Logo_ohne_Schriftzug.svg
Ubuntu is a registered trademark of Canonical Ltd.

Copyright 2017 Canonical Ltd.

This work is licensed under the Creative Commons Attribution-Share Alike 3.0 Unported License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
or send a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco, California, 94105, USA.

Use of Canonical Trade Marks is subject to Canonical's IP Rights Policy.
Canonical's IP Right Policy can be found at
https://www.ubuntu.com/legal/terms-and-policies/intellectual-property-policy
<g transform="matrix(2.1873865,0,0,2.1157866,56.109572,7.1245282)">
-->

<g transform="matrix(2.1364183,0,0,2.0664868,56.258558,10.977782)">
 <circle
   cx="9.1239996"
   cy="46.903999"
   r="9.1239996"
   fill="#ff6309" />
 <circle
   cx="74.547997"
   cy="84.667000"
   r="9.1239996"
   fill="#ffb515" />
 <path
   d="M 52.739,24.327 C 64.1,24.327 73.526,32.763 75.087,43.7
    L 90.719,43.7 C 90.009,35.106 86.446,27.096 80.489,20.779
    C 76.674,22.722 71.983,22.759 67.998,20.459 C 64.01,18.156
    61.696,14.072 61.474,9.792 C 58.643,9.132 55.718,8.79
    52.739,8.79 C 47.035,8.79 41.523,10.035 36.51,12.396
    L 44.336,25.951 C 46.935,24.905 49.771,24.327 52.739,24.327 z"
   fill="#ff6309" />
 <path
   d="M 75.088,50.098 C 73.531,61.039 64.103,69.48 52.739,69.48
    C 49.769,69.48 46.932,68.902 44.333,67.854 L 36.506,81.41
    C 41.518,83.772 47.032,85.018 52.738,85.018 C 55.719,85.018
    58.648,84.674 61.48,84.014 C 61.698,79.729 64.013,75.638
    68.004,73.334 C 71.99,71.032 76.683,71.069 80.499,73.016
    C 86.451,66.698 90.01,58.689 90.718,50.098 L 75.088,50.098
    L 75.088,50.098 z"
   fill="#c90016" />
 <path
   d="M 30.163,46.904 C 30.163,39.711 33.544,33.294 38.799,29.157
    L 30.975,15.604 C 29.14,16.886 27.404,18.337 25.787,19.953
    C 21.259,24.481 18.012,29.948 16.225,35.915 C 19.825,38.247
    22.209,42.295 22.209,46.904 C 22.209,51.512 19.825,55.561
    16.225,57.892 C 18.012,63.859 21.259,69.326 25.787,73.854
    C 27.403,75.47 29.137,76.919 30.971,78.202 L 38.796,64.648
    C 33.542,60.511 30.163,54.094 30.163,46.904 z"
   fill="#ffb515" />
 <circle
   cx="74.540001"
   cy="9.1260004"
   r="9.1239996"
   fill="#c90016" />
</g>

|}
;;


let add_text b ~x ~y ~text ~text_anchor ~font_family ~font_size ~font_weight ~fill ?fill_opacity ?stroke ?stroke_width ?stroke_opacity () =
  let fill_opacity   = match fill_opacity   with None -> "" | Some v -> Printf.sprintf " fill-opacity=\"%g\"" v in
  let stroke         = match stroke         with None -> "" | Some v -> Printf.sprintf " stroke=\"%s\"" v in
  let stroke_width   = match stroke_width   with None -> "" | Some v -> Printf.sprintf " stroke-width=\"%g\"" v in
  let stroke_opacity = match stroke_opacity with None -> "" | Some v -> Printf.sprintf " stroke-opacity=\"%g\"" v in
  Printf.kprintf (Buffer.add_string b) {|
<text x="%d" y="%d" text-anchor="%s" font-family="%s" font-size="%g" font-weight="%s" fill="%s"%s%s%s%s>%s</text>|}
  x y text_anchor font_family font_size font_weight fill fill_opacity stroke stroke_width stroke_opacity text;
;;

let add_line b ~x1 ~y1 ~x2 ~y2 ~style () =
  Printf.kprintf (Buffer.add_string b) {|
<line x1="%d" y1="%d" x2="%d" y2="%d" style="%s" />|}
  x1 y1 x2 y2 style
;;

let add_rect b ~x ~y ~width ~height ?rx ?ry ?fill ?stroke ?stroke_width ?fill_opacity ?css ?filter () =
  let fill_opacity = match fill_opacity with None -> "" | Some v -> Printf.sprintf " fill-opacity=\"%g\"" v in
  let fill         = match fill         with None -> "" | Some v -> Printf.sprintf " fill=\"%s\"" v in
  let stroke       = match stroke       with None -> "" | Some v -> Printf.sprintf " stroke=\"%s\"" v in
  let stroke_width = match stroke_width with None -> "" | Some v -> Printf.sprintf " stroke-width=\"%g\"" v in
  let css          = match css          with None -> "" | Some v -> Printf.sprintf " class=\"%s\"" v in
  let rx           = match rx           with None -> "" | Some v -> Printf.sprintf " rx=\"%g\"" v in
  let ry           = match ry           with None -> "" | Some v -> Printf.sprintf " ry=\"%g\"" v in
  let filter       = match filter       with None -> "" | Some v -> Printf.sprintf " filter=\"%s\"" v in

  Printf.kprintf (Buffer.add_string b) {|
<rect x="%d" y="%d" width="%d" height="%d" %s%s%s%s%s%s%s%s />|}
  x y width height rx ry css fill stroke stroke_width fill_opacity filter;
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
  "sl", "koledar";
  "uk", "календар";
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
  "uk", [|
    "січня"; "лютого"; "березня"; "квітня";
    "травня"; "червня"; "липня"; "серпня";
    "вересня"; "жовтня"; "листопада"; "грудня";
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
  "uk", [| "понеділок"; "вівторок"; "середа";
    "четвер"; "пʼятниця"; "субота"; "неділя" |];
  "ru", [| "понедельник"; "вторник"; "среда";
    "четверг"; "пятница"; "суббота"; "воскресенье" |];
]

let days_abbr_lang = [
  "en", [| "Mon"; "Tue"; "Wed";
    "Thu"; "Fri"; "Sat"; "Sun" |];
  "fr", [| "lun"; "mar"; "mer";
    "jeu"; "ven"; "sam"; "dim" |];
  "de", [| "Mo"; "Di"; "Mi";
    "Do"; "Fr"; "Sa"; "So" |];
  "es", [| "lun"; "mar"; "mié";
    "jue"; "vie"; "sáb"; "dom" |];
  "it", [| "lun"; "mar"; "mer";
    "gio"; "ven"; "sab"; "dom" |];
  "nl", [| "ma"; "di"; "wo";
    "do"; "vr"; "za"; "zo" |];
  "da", [| "man"; "tir"; "ons";
    "tor"; "fre"; "lør"; "søn" |];
  "id", [| "Sen"; "Sel"; "Rab";
    "Kam"; "Jum"; "Sab"; "Min" |];
  "pt", [| "seg"; "ter"; "qua"; "qui";
    "sex"; "sáb"; "dom" |];
  "no", [| "man"; "tir"; "ons";
    "tor"; "fre"; "lør"; "søn" |];
  "sl", [| "pon"; "tor"; "sre";
    "čet"; "pet"; "sob"; "ned" |];
  "uk", [| "пн"; "вт"; "ср";
    "чт"; "пт"; "сб"; "нд" |];
  "ru", [| "пн"; "вт"; "ср";
    "чт"; "пт"; "сб"; "вс" |];
]


let days = List.assoc lang days_lang
let days_abbr = List.assoc lang days_abbr_lang
let months = List.assoc lang months_lang
let cal = List.assoc lang cal_lang

let monday_first = 6, [| 0; 1; 2; 3; 4; 5; 6 |]
let sunday_first = 0, [| 6; 0; 1; 2; 3; 4; 5 |]

let off, days_order =
  try
    match Sys.argv.(3) with
    | "--monday-first" -> monday_first
    | "--sunday-first" -> sunday_first
    | _ -> raise Exit
  with _ ->
    monday_first


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


let current_year () =
  let t = Unix.localtime (Unix.time ()) in
  (t.Unix.tm_year  + 1900)


let () =
  let year =
    try int_of_string Sys.argv.(1)
    with _ -> current_year ()
  in

  let svg = new_svg_document ~width:297 ~height:210 () in

  (* Background *)
  add_linear_gradient_background svg ();
  add_ubuntu_logo svg ();

  (* Year and title *)
  let text = Printf.sprintf "%s %d" (String.capitalize_ascii cal) year in
  add_text svg ~x:14 ~y:18 ~text_anchor:"left" ~font_family:"sans-serif" ~font_size:10.4 ~font_weight:"bold"
      ~fill:"#c90016" ~fill_opacity:1.0 ~text ();
  add_newline svg;

  for mon = 1 to 12 do  (* for each month *)

    let tx, ty =
      let m = pred mon in
      float (12 + (m mod 4) * 70),
      float (26 + (m / 4) * 60)
    in

    begin_group svg ~translate:(tx, ty) ~scale:(0.28, 0.29);
    add_newline svg;

    let cell_height = 23 in
    let days_h_spacing = 31 in

    (* Month block background *)
    let height = 24 + 14 + 6 * cell_height + 12 in
    add_rect svg ~x:0 ~y:6 ~width:225 ~height ~rx:16.0 ~ry:16.0 ~fill:"#FFF" ~fill_opacity:0.6 ~stroke:"#222" ~stroke_width:0.0 ();

    (* Month label *)
    let text = String.capitalize_ascii months.(pred mon) in
    add_text svg ~x:110 ~y:26 ~text_anchor:"middle" ~font_family:"sans-serif" ~font_size:15.6 ~font_weight:"bold" ~fill:"#c90016" ~fill_opacity:0.8 ~text ();
    add_newline svg;

    (* Labels: days names *)
    for i = 0 to 6 do
      let x = 19 + i * days_h_spacing in
      let text = days_abbr.(days_order.(i)) in
      add_text svg ~x ~y:44 ~text_anchor:"middle" ~font_family:"sans-serif" ~font_size:9.4 ~font_weight:"bold" ~fill:"#c90016" ~fill_opacity:0.9 ~text ();
    done;
    add_newline svg;

    let y = 50 in
    add_line svg ~x1:6 ~y1:y ~x2:(days_h_spacing * 7 + 2) ~y2:y
      ~style:"stroke:#c90016; stroke-width:0.9; stroke-opacity:0.5" ();

    let t = Unix.gmtime 0.0 in
    let m = make_month t year (pred mon) in

    let len = Array.length m in
    let num_rows =
      if m.(len-1).(0) = 0
      then (len-2)
      else (len-1)
    in

    (* Day Numbers *)
    for w = 0 to num_rows do  (* for each row of the month *)
      for i = 0 to 6 do  (* for each day *)
        let x = 4 + i * days_h_spacing in
        let y = 50 + w * cell_height in
        let d = m.(w).(i) in
        if d = 0 then begin
          if w = 0 then ()
        end else begin
          let text = Printf.sprintf "%d" d in
          add_text svg ~x:(x+15) ~y:(y+18) ~text_anchor:"middle" ~font_family:"sans-serif" ~font_size:14.2 ~font_weight:"normal" ~fill:"#222" ~text ();
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

