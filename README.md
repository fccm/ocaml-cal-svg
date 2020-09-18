Generates a calendar, one month by page with `cal_svg.ml`.

Generates a black and white calendars with `cal_svg12.ml`.

Generates calendars with color headers with `cal_svg12_col.ml`.

Produce the page for January 2021, in English, in SVG with:
```
ocaml cal_svg.ml 2021-01 en > cal-2021-01-en.svg
```

Produce a calendar for the year 2021, in French, in SVG with:
```
ocaml cal_svg12.ml 2021 fr > cal-2021-fr.svg
```

You can then convert to PDF with your favorite program.

An example Makefile is provided to generate all months of 2020
and joining every months into a single PDF.

