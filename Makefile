DEBUG = -g
CFLAGS = -Wall -c $(DEBUG)
SRC = 'proposal'

html: prep-gen
	cp -r ./css ./gen/
	cp -r ./img ./gen/
	pandoc -s -S ./content/${SRC}.md\
	  --biblio=./content/${SRC}.bib\
	  --csl=./acm-sigchi-proceedings.csl\
	  --to=html5\
	  --template=./template-html5-bootstrap.html\
	  --section-divs\
	  --toc\
	  --toc-depth=2\
	  --css=./css/normalize.css\
	  --css=./css/bootstrap.min.css\
	  --css=./css/letterpress.css\
	  -o gen/${SRC}.html

docx: prep-gen
	pandoc ./content/${SRC}.md\
	  --biblio=./content/${SRC}.bib\
	  --csl=./acm-sigchi-proceedings.csl\
	  -o gen/${SRC}.docx

pdf: prep-gen
ifneq (,$(wildcard ./content/${SRC}-appendix.md))
	pandoc ./content/${SRC}-appendix.md\
	  -o gen/${SRC}-appendix.tex
	pandoc ./content/${SRC}.md\
	  --biblio=./content/${SRC}.bib\
	  --csl=./acm-sigchi-proceedings.csl\
	  --latex-engine=xelatex\
	  --include-after-body=./gen/${SRC}-appendix.tex\
	  -o gen/${SRC}.pdf
else
	pandoc ./content/${SRC}.md\
	  --biblio=./content/${SRC}.bib\
	  --csl=./acm-sigchi-proceedings.csl\
	  --latex-engine=xelatex\
	  -o gen/${SRC}.pdf
endif

prep-gen:
	mkdir -p ./gen

clean:
	rm -rf ./gen
