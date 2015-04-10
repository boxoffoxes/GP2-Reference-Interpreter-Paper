talk.pdf : talk.tex slides.tex

%.pdf : %.tex
	pdflatex -output-directory=tmp $< && mv tmp/$@ ./

slides.tex : slides.txt
	pandoc -t beamer -o $@ $<

