.PHONY: main clean FORCE

SRC_DIR := src
OUTDIR := ..
AUXDIR := .build
LATEXMK := latexmk
PDFLATEX := lualatex -interaction nonstopmode

BIB_FILES := $(wildcard src/bib/*)

main: natmat-response.pdf

natmat-response.pdf: FORCE main.bib
	cd "$(SRC_DIR)" && \
	$(LATEXMK) -lualatex="$(PDFLATEX)" -output-directory="$(OUTDIR)" -aux-directory="$(AUXDIR)" -pdf main.tex && \
	mv ../main.pdf ../natmat-response.pdf

clean:
	cd "$(SRC_DIR)" && \
	$(LATEXMK) -output-directory="$(OUTDIR)" -aux-directory="$(AUXDIR)" -c -pdf main.tex

main.bib: $(BIB_FILES)
	cat "$(SRC_DIR)"/bib/* > src/main.bib
