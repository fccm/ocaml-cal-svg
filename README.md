Generates a calendar, one month by page.

Produce the page for January 2020, in SVG with:
```
ocaml cal_svg.ml 2020-01 > cal-2020-01.svg
```

You can then convert to PDF with your favorite program.

An example Makefile is provided to generate all months of 2020
and joining every months into a single PDF.

