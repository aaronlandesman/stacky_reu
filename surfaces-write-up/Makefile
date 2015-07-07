TeX_sources := $(wildcard *.tex)

.PHONY: all clean distclean junk

all: surface-write-up.pdf

surface-write-up.pdf: $(TeX_sources) bibliography-stacky-surface.bib
	pdflatex surface-write-up.tex
	bibtex surface-write-up.tex
	pdflatex surface-write-up.tex
	pdflatex surface-write-up.tex

junk: # remove junk files
	@- $(RM) $(TeX_sources:.tex=.aux) $(TeX_sources:.tex=.log) $(TeX_sources:.tex=.out) $(TeX_sources:.tex=.toc) $(TeX_sources:.tex=.bbl) $(TeX_sources:.tex=.blg)

clean: junk
	@- $(RM) surface-write-up.pdf

distclean: clean
