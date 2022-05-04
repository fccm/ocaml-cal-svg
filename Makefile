YEAR = 2022

all: cal-$(YEAR).pdf

svg:
	ocaml cal_svg.ml $(YEAR)-01 > /tmp/cal-$(YEAR)-01.svg
	ocaml cal_svg.ml $(YEAR)-02 > /tmp/cal-$(YEAR)-02.svg
	ocaml cal_svg.ml $(YEAR)-03 > /tmp/cal-$(YEAR)-03.svg
	ocaml cal_svg.ml $(YEAR)-04 > /tmp/cal-$(YEAR)-04.svg
	ocaml cal_svg.ml $(YEAR)-05 > /tmp/cal-$(YEAR)-05.svg
	ocaml cal_svg.ml $(YEAR)-06 > /tmp/cal-$(YEAR)-06.svg
	ocaml cal_svg.ml $(YEAR)-07 > /tmp/cal-$(YEAR)-07.svg
	ocaml cal_svg.ml $(YEAR)-08 > /tmp/cal-$(YEAR)-08.svg
	ocaml cal_svg.ml $(YEAR)-09 > /tmp/cal-$(YEAR)-09.svg
	ocaml cal_svg.ml $(YEAR)-10 > /tmp/cal-$(YEAR)-10.svg
	ocaml cal_svg.ml $(YEAR)-11 > /tmp/cal-$(YEAR)-11.svg
	ocaml cal_svg.ml $(YEAR)-12 > /tmp/cal-$(YEAR)-12.svg

pdf: svg
	$(MAKE) /tmp/cal-$(YEAR)-01.pdf
	$(MAKE) /tmp/cal-$(YEAR)-02.pdf
	$(MAKE) /tmp/cal-$(YEAR)-03.pdf
	$(MAKE) /tmp/cal-$(YEAR)-04.pdf
	$(MAKE) /tmp/cal-$(YEAR)-05.pdf
	$(MAKE) /tmp/cal-$(YEAR)-06.pdf
	$(MAKE) /tmp/cal-$(YEAR)-07.pdf
	$(MAKE) /tmp/cal-$(YEAR)-08.pdf
	$(MAKE) /tmp/cal-$(YEAR)-09.pdf
	$(MAKE) /tmp/cal-$(YEAR)-10.pdf
	$(MAKE) /tmp/cal-$(YEAR)-11.pdf
	$(MAKE) /tmp/cal-$(YEAR)-12.pdf

cal-$(YEAR).pdf: pdf
	gs -q -sPAPERSIZE=a4 -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=cal-$(YEAR).pdf /tmp/cal-$(YEAR)-*.pdf

%.pdf: %.svg
	inkscape $< --export-pdf=$@

#%.pdf: %.svg
#	rsvg-convert -f pdf -o $@ $<

%.png: %.svg
	inkscape $< --export-background=white --export-png=$@

%.jpg: %.png
	convert $< -resize 360 $@
