NAME = current-problems-2017
SOURCES = $(NAME).tex $(NAME).bib requirements.tex $(wildcard body/*.tex)
DOCUMENTS = $(NAME).pdf authors.pdf
PUB_SOURCES = $(addprefix pub/,$(SOURCES))

ZIP_LOCAL_CONTENTS = $(DOCUMENTS) $(SOURCES)
ZIP_PUB_CONTENTS = \
    $(PUB_SOURCES) \
    $(addprefix pub/,$(DOCUMENTS)) \
	pub/$(NAME).bbl
ZIP_CONTENTS = $(ZIP_PUB_CONTENTS) $(DOCUMENTS) $(SOURCES) 

# Local build commands
LTEX = xelatex
LBIB = biber
# Deployment environment commands
PTEX = pdflatex
PBIB = bibtex
OUTENC = cp1251

default: $(NAME)_local.zip

all: $(NAME).zip $(NAME)_pub.zip $(NAME)_local.zip

pub/$(NAME).bbl: $(PUB_SOURCES)
	rm -f $@
	cd pub ; $(PTEX) $(NAME).tex
	cd pub ; $(PBIB) $(NAME)

include Makefile.rules
