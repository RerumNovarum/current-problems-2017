NAME = current-problems-2017
SOURCES = $(NAME).tex $(NAME).bib requirements.tex $(wildcard body/*.tex)
DOCUMENTS = $(NAME).pdf authors.pdf

ZIP_LOCAL_CONTENTS = $(DOCUMENTS) $(SOURCES)
ZIP_PUB_CONTENTS = \
    $(addprefix pub/,$(SOURCES)) \
    $(addprefix pub/,$(DOCUMENTS))
ZIP_CONTENTS = $(ZIP_PUB_CONTENTS) $(DOCUMENTS) $(SOURCES) 
PUB_SOURCES = $(addprefix pub/,$(SOURCES))

# Local build commands
LTEX = xelatex
LBIB = biber
# Deployment environment commands
PTEX = pdflatex
PBIB = bibtex
OUTENC = cp1251

all: $(NAME)_local.zip

PUB_SOURCES += pub/$(NAME).bbl

include Makefile.rules
