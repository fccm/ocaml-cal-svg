Generates a calendar, one month by page.

Produce the page for January 2021, in English, in SVG with:
```
ocaml cal_svg.ml 2021-01 en > cal-2021-01-en.svg
```

You can then convert to PDF with your favorite program.

An example Makefile is provided to generate all months of 2020
and joining every months into a single PDF.

