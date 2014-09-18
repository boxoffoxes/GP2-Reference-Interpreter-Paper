SECTIONS=01_introduction.tex 02_language.tex 03_implementation.tex 04_results.tex 05_discussion.tex
HEADER=_header.tex
FOOTER=_footer.tex
LATEX=pdflatex -halt-on-error -output-directory=tmp
BIBTEX=bibtex


paper.pdf : paper.tex $(HEADER) $(FOOTER)
	$(LATEX) $<
	$(BIBTEX) tmp/paper.aux
	$(LATEX) $<
	$(LATEX) $< && mv tmp/$@ ./

paper.tex : $(SECTIONS)
	cat $(HEADER) $^ $(FOOTER) > tmp/$@ && mv tmp/$@ ./

%.pdf : tmp/%.tex
	$(LATEX) $< && mv tmp/$@ ./

tmp/%.tex : %.tex
	cat $(HEADER) $^ $(FOOTER) > $@

%.tex :
	pandoc -t latex -o $@ $<
	
clean :
	rm -f tmp/* *.pdf paper.tex

view : paper.pdf
	evince $<

commit :
	git commit -a -m "Automatic commit by $(USER)" && git push

fetch :
	git pull

