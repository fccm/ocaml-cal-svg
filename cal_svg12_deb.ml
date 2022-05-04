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
      <stop offset="0" style="stop-color:#ff3b73;stop-opacity:1;" />
      <stop offset="1" style="stop-color:#ff3b73;stop-opacity:0;" />
    </linearGradient>
  </defs>
  <rect x="0" y="0" width="297" height="210"
     style="fill:url(#linearGradient1956);fill-opacity:1" />
|}
;;

let add_debian_logo b () =
  Printf.kprintf (Buffer.add_string b) {|
  <g
     style="overflow:visible"
     transform="matrix(1.8980496,0,0,1.8980496,67.751617,2.0792046)">

<!--
  The Debian Open Use Logo(s) are
  Copyright (c) 1999 Software in the Public Interest, Inc.,
      https://www.spi-inc.org/
  and are released under the terms of the
  GNU Lesser General Public License, version 3 or any later version,
      https://www.gnu.org/copyleft/lgpl.html
  or, at your option, of the
  Creative Commons Attribution-ShareAlike 3.0 Unported License.
     https://creativecommons.org/licenses/by-sa/3.0/
-->

 <g id="Layer_Logo_Debian">
  <g>
   <path fill="#A80030" d="M51.986,57.297c-1.797,0.025,0.34,0.926,2.686,1.287
    c0.648-0.506,1.236-1.018,1.76-1.516C54.971,57.426,53.484,57.434,51.986,57.297"/>
   <path fill="#A80030" d="M61.631,54.893c1.07-1.477,1.85-3.094,2.125-4.766c-0.24,1.192-0.887,2.221-1.496,3.307
    c-3.359,2.115-0.316-1.256-0.002-2.537C58.646,55.443,61.762,53.623,61.631,54.893"/>
   <path fill="#A80030" d="M65.191,45.629c0.217-3.236-0.637-2.213-0.924-0.978
    C64.602,44.825,64.867,46.932,65.191,45.629"/>
   <path fill="#A80030" d="M45.172,1.399c0.959,0.172,2.072,0.304,1.916,0.533
    C48.137,1.702,48.375,1.49,45.172,1.399"/>
   <path fill="#A80030" d="M47.088,1.932l-0.678,0.14l0.631-0.056L47.088,1.932"/>
   <path fill="#A80030" d="M76.992,46.856c0.107,2.906-0.85,4.316-1.713,6.812l-1.553,0.776
    c-1.271,2.468,0.123,1.567-0.787,3.53c-1.984,1.764-6.021,5.52-7.313,5.863c-0.943-0.021,0.639-1.113,0.846-1.541
    c-2.656,1.824-2.131,2.738-6.193,3.846l-0.119-0.264c-10.018,4.713-23.934-4.627-23.751-17.371
    c-0.107,0.809-0.304,0.607-0.526,0.934c-0.517-6.557,3.028-13.143,9.007-15.832c5.848-2.895,12.704-1.707,16.893,2.197
    c-2.301-3.014-6.881-6.209-12.309-5.91c-5.317,0.084-10.291,3.463-11.951,7.131c-2.724,1.715-3.04,6.611-4.227,7.507
    C31.699,56.271,36.3,61.342,44.083,67.307c1.225,0.826,0.345,0.951,0.511,1.58c-2.586-1.211-4.954-3.039-6.901-5.277
    c1.033,1.512,2.148,2.982,3.589,4.137c-2.438-0.826-5.695-5.908-6.646-6.115c4.203,7.525,17.052,13.197,23.78,10.383
    c-3.113,0.115-7.068,0.064-10.566-1.229c-1.469-0.756-3.467-2.322-3.11-2.615c9.182,3.43,18.667,2.598,26.612-3.771
    c2.021-1.574,4.229-4.252,4.867-4.289c-0.961,1.445,0.164,0.695-0.574,1.971c2.014-3.248-0.875-1.322,2.082-5.609l1.092,1.504
    c-0.406-2.696,3.348-5.97,2.967-10.234c0.861-1.304,0.961,1.403,0.047,4.403c1.268-3.328,0.334-3.863,0.66-6.609
    c0.352,0.923,0.814,1.904,1.051,2.878c-0.826-3.216,0.848-5.416,1.262-7.285c-0.408-0.181-1.275,1.422-1.473-2.377
    c0.029-1.65,0.459-0.865,0.625-1.271c-0.324-0.186-1.174-1.451-1.691-3.877c0.375-0.57,1.002,1.478,1.512,1.562
    c-0.328-1.929-0.893-3.4-0.916-4.88c-1.49-3.114-0.527,0.415-1.736-1.337c-1.586-4.947,1.316-1.148,1.512-3.396
    c2.404,3.483,3.775,8.881,4.404,11.117c-0.48-2.726-1.256-5.367-2.203-7.922c0.73,0.307-1.176-5.609,0.949-1.691
    c-2.27-8.352-9.715-16.156-16.564-19.818c0.838,0.767,1.896,1.73,1.516,1.881c-3.406-2.028-2.807-2.186-3.295-3.043
    c-2.775-1.129-2.957,0.091-4.795,0.002c-5.23-2.774-6.238-2.479-11.051-4.217l0.219,1.023c-3.465-1.154-4.037,0.438-7.782,0.004
    c-0.228-0.178,1.2-0.644,2.375-0.815c-3.35,0.442-3.193-0.66-6.471,0.122c0.808-0.567,1.662-0.942,2.524-1.424
    c-2.732,0.166-6.522,1.59-5.352,0.295c-4.456,1.988-12.37,4.779-16.811,8.943l-0.14-0.933c-2.035,2.443-8.874,7.296-9.419,10.46
    l-0.544,0.127c-1.059,1.793-1.744,3.825-2.584,5.67c-1.385,2.36-2.03,0.908-1.833,1.278c-2.724,5.523-4.077,10.164-5.246,13.97
    c0.833,1.245,0.02,7.495,0.335,12.497c-1.368,24.704,17.338,48.69,37.785,54.228c2.997,1.072,7.454,1.031,11.245,1.141
    c-4.473-1.279-5.051-0.678-9.408-2.197c-3.143-1.48-3.832-3.17-6.058-5.102l0.881,1.557c-4.366-1.545-2.539-1.912-6.091-3.037
    l0.941-1.229c-1.415-0.107-3.748-2.385-4.386-3.646l-1.548,0.061c-1.86-2.295-2.851-3.949-2.779-5.23l-0.5,0.891
    c-0.567-0.973-6.843-8.607-3.587-6.83c-0.605-0.553-1.409-0.9-2.281-2.484l0.663-0.758c-1.567-2.016-2.884-4.6-2.784-5.461
    c0.836,1.129,1.416,1.34,1.99,1.533c-3.957-9.818-4.179-0.541-7.176-9.994l0.634-0.051c-0.486-0.732-0.781-1.527-1.172-2.307
    l0.276-2.75C4.667,58.121,6.719,47.409,7.13,41.534c0.285-2.389,2.378-4.932,3.97-8.92l-0.97-0.167
    c1.854-3.234,10.586-12.988,14.63-12.486c1.959-2.461-0.389-0.009-0.772-0.629c4.303-4.453,5.656-3.146,8.56-3.947
    c3.132-1.859-2.688,0.725-1.203-0.709c5.414-1.383,3.837-3.144,10.9-3.846c0.745,0.424-1.729,0.655-2.35,1.205
    c4.511-2.207,14.275-1.705,20.617,1.225c7.359,3.439,15.627,13.605,15.953,23.17l0.371,0.1
    c-0.188,3.802,0.582,8.199-0.752,12.238L76.992,46.856"/>
   <path fill="#A80030" d="M32.372,59.764l-0.252,1.26c1.181,1.604,2.118,3.342,3.626,4.596
    C34.661,63.502,33.855,62.627,32.372,59.764"/>
   <path fill="#A80030" d="M35.164,59.654c-0.625-0.691-0.995-1.523-1.409-2.352
    c0.396,1.457,1.207,2.709,1.962,3.982L35.164,59.654"/>
   <path fill="#A80030" d="M84.568,48.916l-0.264,0.662c-0.484,3.438-1.529,6.84-3.131,9.994
    C82.943,56.244,84.088,52.604,84.568,48.916"/>
   <path fill="#A80030" d="M45.527,0.537C46.742,0.092,48.514,0.293,49.803,0c-1.68,0.141-3.352,0.225-5.003,0.438
    L45.527,0.537"/>
   <path fill="#A80030" d="M2.872,23.219c0.28,2.592-1.95,3.598,0.494,1.889
    C4.676,22.157,2.854,24.293,2.872,23.219"/>
   <path fill="#A80030" d="M0,35.215c0.563-1.728,0.665-2.766,0.88-3.766C-0.676,33.438,0.164,33.862,0,35.215"/>
  </g>
 </g>

 </g>
|}
;;


let add_text b ~x ~y ~text ~text_anchor ~font_family ~font_size ~font_weight ~fill ?fill_opacity () =
  let fill_opacity = match fill_opacity with None -> "" | Some v -> Printf.sprintf " fill-opacity=\"%g\"" v in
  Printf.kprintf (Buffer.add_string b) {|
<text x="%d" y="%d" text-anchor="%s" font-family="%s" font-size="%g" font-weight="%s" fill="%s"%s>%s</text>|}
  x y text_anchor font_family font_size font_weight fill fill_opacity text;
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
  [| 0;  0;  1;  2;  3;  4 ; 5|];
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
  add_debian_logo svg ();

  (* Year and title *)
  let text = Printf.sprintf "%s %d" (String.capitalize_ascii cal) year in
  add_text svg ~x:14 ~y:18 ~text_anchor:"left" ~font_family:"sans-serif" ~font_size:9.8 ~font_weight:"bold" ~fill:"#000" ~fill_opacity:0.5 ~text ();
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
    add_rect svg ~x:0 ~y:6 ~width:225 ~height ~rx:16.0 ~ry:16.0 ~fill:"#FFF" ~fill_opacity:0.7 ~stroke:"#222" ~stroke_width:0.0 ();

    (* Month label *)
    let text = String.capitalize_ascii months.(pred mon) in
    add_text svg ~x:110 ~y:26 ~text_anchor:"middle" ~font_family:"sans-serif" ~font_size:15.6 ~font_weight:"bold" ~fill:"#000" ~fill_opacity:0.6 ~text ();
    add_newline svg;

    (* Labels: days names *)
    for i = 0 to 6 do
      let x = 19 + i * days_h_spacing in
      let text = days_abbr.(days_order.(i)) in
      add_text svg ~x ~y:44 ~text_anchor:"middle" ~font_family:"sans-serif" ~font_size:9.4 ~font_weight:"bold" ~fill:"#000" ~fill_opacity:0.7 ~text ();
    done;
    add_newline svg;

    let y = 50 in
    add_line svg ~x1:6 ~y1:y ~x2:(days_h_spacing * 7 + 2) ~y2:y
      ~style:"stroke:#000; stroke-width:0.9; stroke-opacity:0.5" ();

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

