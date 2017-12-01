NAME = current-problems-2017
SOURCES = $(NAME).tex $(NAME).bib requirements.tex $(wildcard body/*.tex)
DOCUMENTS = $(NAME).pdf authors.pdf
PUB_SOURCES = $(addprefix pub/,$(SOURCES)) \
			  pub/$(NAME).bbl

ZIP_LOCAL_CONTENTS = $(DOCUMENTS) $(SOURCES)
ZIP_PUB_CONTENTS = \
    $(PUB_SOURCES) \
    $(addprefix pub/,$(DOCUMENTS))
ZIP_CONTENTS = $(ZIP_PUB_CONTENTS) $(DOCUMENTS) $(SOURCES) 
ZIP_FLAT_CONTENTS = \
	pub/$(NAME)_flat.tex \
	pub/$(NAME)_flat.pdf \
	authors.pdf

# Local build commands
LTEX = xelatex
LBIB = bibtex
# Deployment environment commands
PTEX = pdflatex
PBIB = bibtex
OUTENC = cp1251

default: $(NAME)_local.zip

all: $(NAME).zip $(NAME)_flat.zip $(NAME)_pub.zip $(NAME)_local.zip

pub/$(NAME).bbl: $(NAME).bbl
	iconv -t $(OUTENC)//TRANSLIT $< -o $@

new.tex: $(SOURCES) $(NAME).bbl
	python flatten.py pub_$(NAME).tex > new.tex

diff.tex: old.tex new.tex
	latexdiff old.tex new.tex > $@

diff.pdf: diff.tex
	pdflatex $<
	pdflatex $<
	pdflatex $<
	pdflatex $<

include Makefile.rules
