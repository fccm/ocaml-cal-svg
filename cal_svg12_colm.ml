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

  List.iter (fun (selector, style) ->
    Printf.kprintf (Buffer.add_string b) "\n%s {\n" selector;
    List.iter (fun (attr, value) ->
      Printf.kprintf (Buffer.add_string b) "  %s: %s;\n" attr value;
    ) style;
    Printf.kprintf (Buffer.add_string b) "}\n";
  ) (List.rev !css);

  Printf.kprintf (Buffer.add_string b) {|
]]>
</style>
|};
;;


let add_text b ~x ~y ~text ?text_anchor ?font_family ?font_size ?font_weight ?fill ?fill_opacity ?css () =
  let fill         = match fill         with None -> "" | Some v -> Printf.sprintf " fill=\"%s\"" v in
  let fill_opacity = match fill_opacity with None -> "" | Some v -> Printf.sprintf " fill-opacity=\"%g\"" v in
  let text_anchor  = match text_anchor  with None -> "" | Some v -> Printf.sprintf " text-anchor=\"%s\"" v in
  let font_family  = match font_family  with None -> "" | Some v -> Printf.sprintf " font-family=\"%s\"" v in
  let font_size    = match font_size    with None -> "" | Some v -> Printf.sprintf " font-size=\"%g\"" v in
  let font_weight  = match font_weight  with None -> "" | Some v -> Printf.sprintf " font-weight=\"%s\"" v in
  let css          = match css          with None -> "" | Some v -> Printf.sprintf " class=\"%s\"" v in

  Printf.kprintf (Buffer.add_string b) {|
<text x="%d" y="%d"%s%s%s%s%s%s%s>%s</text>|}
  x y css text_anchor font_family font_size font_weight fill fill_opacity text;
;;


let add_line b ~x1 ~y1 ~x2 ~y2 ?css ?style ?stroke ?stroke_width ?stroke_opacity () =

  let css          = match css          with None -> "" | Some v -> Printf.sprintf " class=\"%s\"" v in
  let style        = match style        with None -> "" | Some v -> Printf.sprintf " style=\"%s\"" v in
  let stroke       = match stroke       with None -> "" | Some v -> Printf.sprintf " stroke=\"%s\"" v in
  let stroke_width = match stroke_width with None -> "" | Some v -> Printf.sprintf " stroke-width=\"%g\"" v in
  let stroke_opacity = match stroke_opacity with None -> "" | Some v -> Printf.sprintf " stroke-opacity=\"%g\"" v in

  Printf.kprintf (Buffer.add_string b) {|
<line x1="%d" y1="%d" x2="%d" y2="%d"%s%s%s%s%s />|}
  x1 y1 x2 y2 css style
  stroke stroke_width stroke_opacity;
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


(* don't use CSS because web-browsers don't read CSS into SVG yet *)
let use_css = false


let () =
  let year =
    try int_of_string Sys.argv.(1)
    with _ -> current_year ()
  in

  let svg = new_svg_document ~width:297 ~height:210 () in

  if use_css
  then begin
    (* CSS styles *)
    let css = new_css () in
    css_add css ~selector:".month_name" ~style:[
      text_anchor, "middle";
      font_family, "sans-serif";
      font_size, "14.8";
      font_weight, "bold";
      fill, "#444";
      fill_opacity, "0.8";
    ];
    css_add css ~selector:".day_name" ~style:[
      text_anchor, "middle";
      font_family, "sans-serif";
      font_size, "9.0";
      font_weight, "normal";
      fill, "#000";
    ];
    css_add css ~selector:".day_num" ~style:[
      text_anchor, "middle";
      font_family, "sans-serif";
      font_size, "14.2";
      font_weight, "normal";
      fill, "#222";
    ];
    css_add css ~selector:".sep_line" ~style:[
      stroke, "#FFF";
      stroke_width, "0.9";
      stroke_opacity, "0.5";
    ];
    add_css_to_svg css svg;
  end;

  (* Background *)
  let bg_color = "#FFF" in
  let fill = bg_color in
  add_rect svg ~x:0 ~y:0 ~width:297 ~height:210 ~fill ();

  (* Year and title *)
  let text = Printf.sprintf "%s %d" (String.capitalize_ascii cal) year in
  add_text svg ~x:14 ~y:16 ~text_anchor:"left" ~font_family:"sans-serif" ~font_size:8.8 ~font_weight:"bold" ~fill:"#666" ~text ();
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
    let h = (pred mon) * (360 / 12) in
    let fill = Printf.sprintf "hsl(%d,60%%,50%%)" h in
    let height = 24 + 14 + 6 * cell_height + 12 in
    add_rect svg ~x:0 ~y:6 ~width:225 ~height ~rx:14.0 ~ry:14.0 ~fill_opacity:0.6 ~fill ();

    (* Month label *)
    let text = String.capitalize_ascii months.(pred mon) in
    if use_css
    then add_text svg ~x:110 ~y:26 ~css:"month_name" ~text ()
    else add_text svg ~x:110 ~y:26 ~text_anchor:"middle" ~font_family:"sans-serif" ~font_size:14.8
                                   ~font_weight:"bold" ~fill:"#444" ~fill_opacity:0.8 ~text ();
    add_newline svg;

    (* Labels: days names *)
    for i = 0 to 6 do
      let x = 19 + i * days_h_spacing in
      let text = days_abbr.(days_order.(i)) in
      if use_css
      then add_text svg ~x ~y:44 ~css:"day_name" ~text ()
      else add_text svg ~x ~y:44 ~text_anchor:"middle" ~font_family:"sans-serif" ~font_size:9.0
                                 ~font_weight:"normal" ~fill:"#000" ~text ();
    done;
    add_newline svg;

    let y = 50 in
    if use_css
    then add_line svg ~x1:6 ~y1:y ~x2:(days_h_spacing * 7 + 2) ~y2:y ~css:"sep_line" ()
    else add_line svg ~x1:6 ~y1:y ~x2:(days_h_spacing * 7 + 2) ~y2:y
                      ~style:"stroke:rgb(255,255,255); stroke-width:0.9; stroke-opacity:0.5" ();
    add_newline svg;

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
          if use_css
          then add_text svg ~x:(x+15) ~y:(y+18) ~css:"day_num" ~text ()
          else add_text svg ~x:(x+15) ~y:(y+18) ~text_anchor:"middle" ~font_family:"sans-serif"
                                                ~font_size:14.2 ~font_weight:"normal" ~fill:"#222" ~text ();
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

