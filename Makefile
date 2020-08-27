all: cal-2020.pdf

svg:
	ocaml cal_svg.ml 2020-01 > /tmp/cal-2020-01.svg
	ocaml cal_svg.ml 2020-02 > /tmp/cal-2020-02.svg
	ocaml cal_svg.ml 2020-03 > /tmp/cal-2020-03.svg
	ocaml cal_svg.ml 2020-04 > /tmp/cal-2020-04.svg
	ocaml cal_svg.ml 2020-05 > /tmp/cal-2020-05.svg
	ocaml cal_svg.ml 2020-06 > /tmp/cal-2020-06.svg
	ocaml cal_svg.ml 2020-07 > /tmp/cal-2020-07.svg
	ocaml cal_svg.ml 2020-08 > /tmp/cal-2020-08.svg
	ocaml cal_svg.ml 2020-09 > /tmp/cal-2020-09.svg
	ocaml cal_svg.ml 2020-10 > /tmp/cal-2020-10.svg
	ocaml cal_svg.ml 2020-11 > /tmp/cal-2020-11.svg
	ocaml cal_svg.ml 2020-12 > /tmp/cal-2020-12.svg

pdf: svg
	$(MAKE) /tmp/cal-2020-01.pdf
	$(MAKE) /tmp/cal-2020-02.pdf
	$(MAKE) /tmp/cal-2020-03.pdf
	$(MAKE) /tmp/cal-2020-04.pdf
	$(MAKE) /tmp/cal-2020-05.pdf
	$(MAKE) /tmp/cal-2020-06.pdf
	$(MAKE) /tmp/cal-2020-07.pdf
	$(MAKE) /tmp/cal-2020-08.pdf
	$(MAKE) /tmp/cal-2020-09.pdf
	$(MAKE) /tmp/cal-2020-10.pdf
	$(MAKE) /tmp/cal-2020-11.pdf
	$(MAKE) /tmp/cal-2020-12.pdf

cal-2020.pdf: pdf
	gs -q -sPAPERSIZE=a4 -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=cal-2020.pdf /tmp/cal-2020-*.pdf

%.pdf: %.svg
	inkscape $< --export-pdf=$@

%.png: %.svg
	inkscape $< --export-background=white --export-png=$@
