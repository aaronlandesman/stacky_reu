TeX_sources := $(wildcard *.tex)

.PHONY: all clean distclean junk

all: spin-cring.pdf

spin_cring.pdf: $(TeX_sources) bibliography.bib
	pdflatex spin-cring
	bibtex spin-cring
	pdflatex spin-cring
	pdflatex spin-cring 

junk: # remove junk files
	@- $(RM) $(TeX_sources:.tex=.aux) $(TeX_sources:.tex=.log) $(TeX_sources:.tex=.out) $(TeX_sources:.tex=.toc) $(TeX_sources:.tex=.bbl) $(TeX_sources:.tex=.blg)

clean: junk
	@- $(RM) spin-cring.pdf

distclean: clean
