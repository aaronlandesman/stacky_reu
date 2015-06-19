TeX_sources := $(wildcard *.tex)

.PHONY: all clean distclean junk

all: master.pdf

master.pdf: $(TeX_sources) bibliography.bib
	pdflatex master
	bibtex master
	pdflatex master
	pdflatex master

junk: # remove junk files
	@- $(RM) $(TeX_sources:.tex=.aux) $(TeX_sources:.tex=.log) $(TeX_sources:.tex=.out) $(TeX_sources:.tex=.toc) $(TeX_sources:.tex=.bbl) $(TeX_sources:.tex=.blg)

clean: junk
	@- $(RM) master.pdf

distclean: clean
