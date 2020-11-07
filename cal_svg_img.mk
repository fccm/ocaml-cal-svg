YEAR = 2021
_LANG = en
TITLE = dogs
B64DIR = $(shell ocamlfind query base64)

all: cal-$(YEAR)-all-$(TITLE)-$(_LANG).pdf

svg:
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-01 $(_LANG) > /tmp/cal-$(YEAR)-01-$(_LANG).svg
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-02 $(_LANG) > /tmp/cal-$(YEAR)-02-$(_LANG).svg
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-03 $(_LANG) > /tmp/cal-$(YEAR)-03-$(_LANG).svg
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-04 $(_LANG) > /tmp/cal-$(YEAR)-04-$(_LANG).svg
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-05 $(_LANG) > /tmp/cal-$(YEAR)-05-$(_LANG).svg
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-06 $(_LANG) > /tmp/cal-$(YEAR)-06-$(_LANG).svg
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-07 $(_LANG) > /tmp/cal-$(YEAR)-07-$(_LANG).svg
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-08 $(_LANG) > /tmp/cal-$(YEAR)-08-$(_LANG).svg
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-09 $(_LANG) > /tmp/cal-$(YEAR)-09-$(_LANG).svg
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-10 $(_LANG) > /tmp/cal-$(YEAR)-10-$(_LANG).svg
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-11 $(_LANG) > /tmp/cal-$(YEAR)-11-$(_LANG).svg
	ocaml -I $(B64DIR) base64.cma cal_svg_img.ml $(YEAR)-12 $(_LANG) > /tmp/cal-$(YEAR)-12-$(_LANG).svg

pdf: svg
	$(MAKE) /tmp/cal-$(YEAR)-01-$(_LANG).pdf
	$(MAKE) /tmp/cal-$(YEAR)-02-$(_LANG).pdf
	$(MAKE) /tmp/cal-$(YEAR)-03-$(_LANG).pdf
	$(MAKE) /tmp/cal-$(YEAR)-04-$(_LANG).pdf
	$(MAKE) /tmp/cal-$(YEAR)-05-$(_LANG).pdf
	$(MAKE) /tmp/cal-$(YEAR)-06-$(_LANG).pdf
	$(MAKE) /tmp/cal-$(YEAR)-07-$(_LANG).pdf
	$(MAKE) /tmp/cal-$(YEAR)-08-$(_LANG).pdf
	$(MAKE) /tmp/cal-$(YEAR)-09-$(_LANG).pdf
	$(MAKE) /tmp/cal-$(YEAR)-10-$(_LANG).pdf
	$(MAKE) /tmp/cal-$(YEAR)-11-$(_LANG).pdf
	$(MAKE) /tmp/cal-$(YEAR)-12-$(_LANG).pdf

png: svg
	$(MAKE) /tmp/cal-$(YEAR)-01-$(_LANG).png
	$(MAKE) /tmp/cal-$(YEAR)-02-$(_LANG).png
	$(MAKE) /tmp/cal-$(YEAR)-03-$(_LANG).png
	$(MAKE) /tmp/cal-$(YEAR)-04-$(_LANG).png
	$(MAKE) /tmp/cal-$(YEAR)-05-$(_LANG).png
	$(MAKE) /tmp/cal-$(YEAR)-06-$(_LANG).png
	$(MAKE) /tmp/cal-$(YEAR)-07-$(_LANG).png
	$(MAKE) /tmp/cal-$(YEAR)-08-$(_LANG).png
	$(MAKE) /tmp/cal-$(YEAR)-09-$(_LANG).png
	$(MAKE) /tmp/cal-$(YEAR)-10-$(_LANG).png
	$(MAKE) /tmp/cal-$(YEAR)-11-$(_LANG).png
	$(MAKE) /tmp/cal-$(YEAR)-12-$(_LANG).png

jpg: png
	$(MAKE) /tmp/cal-$(YEAR)-01-$(_LANG).jpg
	$(MAKE) /tmp/cal-$(YEAR)-02-$(_LANG).jpg
	$(MAKE) /tmp/cal-$(YEAR)-03-$(_LANG).jpg
	$(MAKE) /tmp/cal-$(YEAR)-04-$(_LANG).jpg
	$(MAKE) /tmp/cal-$(YEAR)-05-$(_LANG).jpg
	$(MAKE) /tmp/cal-$(YEAR)-06-$(_LANG).jpg
	$(MAKE) /tmp/cal-$(YEAR)-07-$(_LANG).jpg
	$(MAKE) /tmp/cal-$(YEAR)-08-$(_LANG).jpg
	$(MAKE) /tmp/cal-$(YEAR)-09-$(_LANG).jpg
	$(MAKE) /tmp/cal-$(YEAR)-10-$(_LANG).jpg
	$(MAKE) /tmp/cal-$(YEAR)-11-$(_LANG).jpg
	$(MAKE) /tmp/cal-$(YEAR)-12-$(_LANG).jpg

cal-$(YEAR)-all-$(TITLE)-$(_LANG).pdf: _pdf
	gs -q -sPAPERSIZE=a4 -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=$@ /tmp/cal-$(YEAR)-*.pdf
	@echo "Done: $@"

%.pdf: %.svg
	inkscape $< --export-pdf=$@

_pdf: svg
	(echo /tmp/cal-$(YEAR)-01-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-01-$(_LANG).pdf; \
	 echo /tmp/cal-$(YEAR)-02-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-02-$(_LANG).pdf; \
	 echo /tmp/cal-$(YEAR)-03-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-03-$(_LANG).pdf; \
	 echo /tmp/cal-$(YEAR)-04-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-04-$(_LANG).pdf; \
	 echo /tmp/cal-$(YEAR)-05-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-05-$(_LANG).pdf; \
	 echo /tmp/cal-$(YEAR)-06-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-06-$(_LANG).pdf; \
	 echo /tmp/cal-$(YEAR)-07-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-07-$(_LANG).pdf; \
	 echo /tmp/cal-$(YEAR)-08-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-08-$(_LANG).pdf; \
	 echo /tmp/cal-$(YEAR)-09-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-09-$(_LANG).pdf; \
	 echo /tmp/cal-$(YEAR)-10-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-10-$(_LANG).pdf; \
	 echo /tmp/cal-$(YEAR)-11-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-11-$(_LANG).pdf; \
	 echo /tmp/cal-$(YEAR)-12-$(_LANG).svg --export-pdf=/tmp/cal-$(YEAR)-12-$(_LANG).pdf) | \
	   DISPLAY= inkscape --shell

#%.pdf: %.svg
#	rsvg-convert -f pdf -o $@ $<

%.png: %.svg
	inkscape $< --export-background=white --export-png=$@
#	mogrify -resize 360 $@

%.jpg: %.png
	convert $< -resize 360 $@

