SECTIONS=01_introduction.tex 02_language.tex benchmark.tex usesrequirements.tex 03_implementation.tex architecture.tex 04_results.tex 05_discussion.tex
LATEX=latex -halt-on-error -output-directory=tmp
BIBTEX=bibtex

paper.pdf : tmp/paper.ps
	ps2pdf $< $@
	cp tmp/paper.ps ./

tmp/%.ps : tmp/%.dvi
	dvips $< -o $@

tmp/paper.dvi : paper.tex $(SECTIONS)
	$(LATEX) $<
	$(BIBTEX) tmp/paper.aux
	$(LATEX) $<
	$(LATEX) $<

%.pdf : tmp/%.tex
	$(LATEX) $< && mv tmp/$@ ./

%.tex : %.txt
	pandoc -t latex -o $@ $<

clean :
	rm -f tmp/* *.pdf

view : paper.pdf
	evince $<

commit :
	git commit -a -m "Automatic commit by $(USER)" && git push

fetch :
	git pull

.PHONY: paper.tex
