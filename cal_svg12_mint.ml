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


let add_defs b () =
  Printf.kprintf (Buffer.add_string b) {|
<defs>
  <linearGradient
     id="linearGradient1"
     x1="1" y1="26"
     x2="1" y2="220"
     gradientUnits="userSpaceOnUse">
    <stop offset="0" style="stop-color:#dbfcc0; stop-opacity:1.0" />
    <stop offset="1" style="stop-color:#e4ffc9; stop-opacity:0.3" />
  </linearGradient>
  <linearGradient d="linearGradient3431">
    <stop offset="0" style="stop-color:#3d3d3d; stop-opacity:1" />
    <stop offset="1" style="stop-color:#000000; stop-opacity:0.11400651" />
  </linearGradient>
  <linearGradient id="linearGradient3312">
    <stop offset="0" style="stop-color:#c7f994; stop-opacity:1" />
    <stop offset="1" style="stop-color:#87cf3e; stop-opacity:1" />
  </linearGradient>
  <filter id="filter3291"
     color-interpolation-filters="sRGB">
    <feGaussianBlur
       stdDeviation="0.400625"
       id="feGaussianBlur3293" />
  </filter>
  <filter id="filter3546"
     color-interpolation-filters="sRGB">
    <feGaussianBlur
       stdDeviation="0.15992437"
       id="feGaussianBlur3548" />
  </filter>
  <linearGradient
     xlink:href="#linearGradient3431"
     id="linearGradient4136"
     spreadMethod="pad"
     gradientTransform="translate(0,80)"
     gradientUnits="userSpaceOnUse"
     x1="70.491508"
     y1="416.38858"
     x2="113.64215"
     y2="375.87961" />
  <linearGradient
     xlink:href="#linearGradient3312"
     id="linearGradient3538"
     gradientTransform="matrix(2.684162,0,0,2.684162,-89.865856,-904.32339)"
     gradientUnits="userSpaceOnUse"
     x1="61.42857"
     y1="362.14285"
     x2="116.42857"
     y2="408.57144" />
  <filter id="filter3573"
     color-interpolation-filters="sRGB">
    <feGaussianBlur stdDeviation="1.6284922" />
  </filter>
</defs>

<rect x="0" y="0" width="297" height="210"
   style="fill:url(#linearGradient1); fill-opacity:1" />
|}
;;

let add_linux_mint_logo b () =
  Printf.kprintf (Buffer.add_string b) {|

<!--

Below: Linux Mint Official Logo
Author: Clement Lefebvre

Origin:
  https://fr.wikipedia.org/wiki/Fichier:Linux_Mint_Official_Logo.svg
  https://upload.wikimedia.org/wikipedia/commons/5/5c/Linux_Mint_Official_Logo.svg

Distributed under the Creative Commons Attribution 3.0 License:
  https://creativecommons.org/licenses/by/3.0/deed.en
  https://creativecommons.org/licenses/by/3.0/deed.fr

-->

<g transform="translate(34.0 17.0) scale(0.65 0.65)">
 <path
    style="display:inline; overflow:visible; visibility:visible; opacity:0.26000001; fill:#000000; fill-opacity:1;
     fill-rule:evenodd; stroke:none; marker:none; filter:url(#filter3573); enable-background:accumulate"
    transform="matrix(2.5652816,0,0,2.5652816,-688.07167,-1031.7156)"
    d="m 331.79042,510.93347 c -21.29012,0 -39.7658,-16.13992 -39.7658,-37.41096 l -0.0191,-21.99227 v -6.58604
     h -13.49776 v -36.6513 l 56.92036,0.26806 17.80557,0.0383 c 21.30926,0 39.76579,16.12071 39.76579,37.41086
     v 64.92334 h -61.20904 v 0 0 z" />
 <path
    style="display:inline; fill:url(#linearGradient3538); fill-opacity:1; fill-rule:evenodd; stroke-width:2.45968843"
    d="m 299.93164,235.71623 c 0,-36.20721 0,-121.61981 0,-121.61981 0,-40.631742 -35.63252,-73.568789
     -79.59741,-73.568789 h -45.6313 v -0.09814 L 51.287618,39.890227 v 44.375066 c 0,0 10.076999,0 18.945012,0
     13.224047,0 15.56021,9.128789 15.56021,21.764087 l 0.09814,78.45009 c 0,40.63176 35.63267,73.56876
     79.54849,73.56876 h 108.42806 c 13.90056,0 26.06418,-8.8031 26.06418,-22.3321 z" />
 <path
    style="display:inline; opacity:0.17514122; fill:url(#linearGradient4136); fill-opacity:1; fill-rule:nonzero;
     filter:url(#filter3291)"
    transform="matrix(2.5789823,0,0,2.5789823,-79.463121,-1044.8703)"
    d="m 142.9375,500.53125 c -10.75182,-7.40935 -18.36682,-15.92034 -24.78125,-27.1875 -12.64444,-23.35809
     -9.68791,-34.95326 -41,-37.6875 -9.036289,0 -15.051217,-2 -24.5625,-2 v 3.3125 c 10e-7,10e-6 3.758681,1.90749
     7.0625,1.90749 4.926697,1e-5 5.78125,3.41765 5.78125,8.125 l 0.03125,29.15501 c -3e-6,15.13758 13.295158,27.40625
     29.65625,27.40625 H 135.5 c 2.96358,0 5.62572,-1.16787 7.4375,-3.03125 z" />
 <path
    style="display:inline; overflow:visible; visibility:visible; fill:#000000; fill-opacity:0.08040203;
     fill-rule:evenodd; stroke:none; marker:none; filter:url(#filter3546); enable-background:accumulate"
    transform="matrix(2.5789823,0,0,2.5789823,-79.463121,-1044.8703)"
    d="m 105.51844,438.54009 c -3.83671,0 -7.245744,1.42445 -9.984837,4.1914 -2.737725,2.76548 -4.1752,6.21796
     -4.17519,10.11421 v 19.69466 h 8.932957 V 452.8457 c 0,-1.49338 0.48728,-2.66108 1.55355,-3.73818
     1.06977,-1.08055 2.2026,-1.56971 3.67352,-1.56971 1.50175,0 2.61758,0.4867 3.68969,1.56971 1.06628,1.0771
     1.55356,2.2448 1.55356,3.73818 v 19.69466 h 8.93297 V 452.8457 c 0,-1.49338 0.48728,-2.66108 1.55356,-3.73818
     1.07211,-1.08301 2.18794,-1.56971 3.68971,-1.56971 1.47093,0 2.60373,0.48916 3.6735,1.56971 1.06627,1.0771
     1.55356,2.2448 1.55356,3.73818 l 0.0486,23.01222 c 0,4.90894 -4.67486,9.04618 -10.68071,9.04618 l -28.805549,-0.11326
     c -4.634707,0 -8.593128,-4.51117 -8.593128,-10.30852 v -43.33528 h -8.447462 v 45.00209 c 0,4.77471 1.747181,8.96178
     5.146164,12.3476 2.905193,2.8676 6.399074,4.56445 10.324689,4.98427 v 0.16191 h 32.074486 c 4.92872,0 9.25884,-1.83265
     12.75212,-5.38904 h 0.0162 c 2.97102,-3.05245 4.70787,-6.70998 5.12997,-10.82624 l -0.0324,-24.58193 c 0,-3.89625
     -1.43744,-7.34873 -4.17521,-10.11421 -2.73906,-2.76695 -6.14812,-4.1914 -9.98482,-4.1914 -3.76604,0 -7.06133,1.40042
     -9.72593,3.96479 -2.65681,-2.56014 -5.92908,-3.96479 -9.69356,-3.96479 z" />
 <path
    style="display:inline; overflow:visible; visibility:visible; fill:#ffffff; fill-opacity:1;
     fill-rule:evenodd; stroke:none; marker:none; enable-background:accumulate"
    d="m 190.82729,86.721587 c -9.89481,0 -18.68665,3.673619 -25.75072,10.809544 -7.06056,7.132109
     -10.76778,16.036009 -10.76776,26.084359 v 50.79219 h 23.03796 v -50.79219 c 0,-3.85138 1.25668,-6.86288
     4.00656,-9.6407 2.75894,-2.78671 5.68048,-4.04826 9.47396,-4.04826 3.87298,0 6.75069,1.25521 9.51565,4.04826
     2.74991,2.77782 4.00661,5.78932 4.00661,9.6407 v 50.79219 h 23.03793 v -50.79219 c 0,-3.85138 1.25671,-6.86288
     4.00664,-9.6407 2.76494,-2.79305 5.64265,-4.04826 9.5157,-4.04826 3.7935,0 6.71497,1.26155 9.47386,4.04826
     2.7499,2.77782 4.00661,5.78932 4.00661,9.6407 l 0.1252,59.34812 c 0,12.66007 -12.05639,23.32992 -27.54537,23.32992
     l -74.28898,-0.29208 c -11.95283,0 -22.16152,-11.63423 -22.16152,-26.5855 V 67.655042 H 108.73376 V 183.71463
     c 0,12.31389 4.50596,23.11226 13.27187,31.84426 7.49243,7.39547 16.5031,12.18937 26.62716,13.27208 l 82.71956,-2e-4
     c 12.71108,0 23.87836,-4.72636 32.88749,-13.89822 h 0.0418 c 7.66218,-7.87223 12.14152,-17.30492 13.2301,-27.92069
     l -0.0834,-63.39637 c 0,-10.04835 -3.7071,-18.95225 -10.76775,-26.084359 -7.06401,-7.135925 -15.85592,-10.809544
     -25.75068,-10.809544 -9.71255,0 -18.21104,3.611659 -25.08302,10.225122 -6.85188,-6.602566 -15.29097,-10.225122
     -24.99951,-10.225122 z" />
 <path
    style="display:inline; overflow:visible; visibility:visible; opacity:0.3; fill:#52a800; fill-opacity:1;
     fill-rule:evenodd; stroke:none; marker:none; enable-background:accumulate"
    d="m 177.27943,206.07866 v 22.75211 h 54.11314 c 12.71103,0 23.81234,-4.74075 32.82144,-13.91261
     h 0.077 c 7.6622,-7.87226 12.13224,-17.28632 13.22083,-27.90209 v -12.91336 h -22.98272 v 8.8395
     c 0,12.66014 -12.02881,23.29018 -27.51779,23.29018 l -49.7318,-0.15373 z" />
 <path
    style="display:inline; overflow:visible; visibility:visible; fill:#ffffff; fill-opacity:1;
     fill-rule:evenodd; stroke:none; marker:none; enable-background:accumulate"
    d="m 164.71846,274.89014 c -52.36706,0 -97.811452,-39.69918 -97.811452,-92.01931 l -0.04698,-63.52792
     V 103.14333 H 33.659769 V 22.426316 l 140.006321,0.659344 43.79618,0.09421 c 52.41412,0 97.81143,39.651923
     97.81143,92.01903 V 274.89011 H 164.71853 v 0 0 z m 129.22209,-42.83713 c 0,-34.7884 0,-116.85409 0,-116.85409
     0,-39.039554 -34.23623,-70.685955 -76.47835,-70.685955 h -43.84323 v -0.09421 L 55.039774,43.900626 v 37.909628
     c 0,0 4.762719,0 13.283228,0 9.018201,0 19.869854,8.474782 19.869854,20.911236 l 0.09421,80.10261 c 0,39.03958
     34.236404,70.68593 76.431374,70.68593 h 104.17924 c 13.35583,0 25.04285,-8.45815 25.04285,-21.45702 z" />
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

let add_rect b ~x ~y ~width ~height ?rx ?ry ?fill ?fill_opacity ?stroke ?stroke_width ?stroke_opacity ?css () =
  let rx           = match rx           with None -> "" | Some v -> Printf.sprintf " rx=\"%g\"" v in
  let ry           = match ry           with None -> "" | Some v -> Printf.sprintf " ry=\"%g\"" v in
  let fill         = match fill         with None -> "" | Some v -> Printf.sprintf " fill=\"%s\"" v in
  let fill_opacity = match fill_opacity with None -> "" | Some v -> Printf.sprintf " fill-opacity=\"%g\"" v in
  let stroke       = match stroke       with None -> "" | Some v -> Printf.sprintf " stroke=\"%s\"" v in
  let stroke_width = match stroke_width with None -> "" | Some v -> Printf.sprintf " stroke-width=\"%g\"" v in
  let stroke_opacity = match stroke_opacity with None -> "" | Some v -> Printf.sprintf " stroke-opacity=\"%g\"" v in
  let css          = match css          with None -> "" | Some v -> Printf.sprintf " class=\"%s\"" v in

  Printf.kprintf (Buffer.add_string b) {|
<rect x="%d" y="%d" width="%d" height="%d"%s%s%s%s%s%s%s%s />|}
  x y width height rx ry css fill fill_opacity stroke stroke_width stroke_opacity;
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
  add_defs svg ();
  add_linux_mint_logo svg ();

  (* Year and title *)
  let text = Printf.sprintf "%s %d" (String.capitalize_ascii cal) year in
  add_text svg ~x:13 ~y:19 ~text_anchor:"left" ~font_family:"sans-serif" ~font_size:9.8 ~font_weight:"bold" ~fill:"#000" ~fill_opacity:0.5 ~text ();
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
    add_rect svg ~x:0 ~y:6 ~width:225 ~height ~rx:16.0 ~ry:16.0 ~fill:"#f0fde6" ~fill_opacity:0.7 ~stroke:"#222" ~stroke_width:0.5 ~stroke_opacity:0.3 ();

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

