.PHONY: main clean FORCE
.INTERMEDIATE: src/input.tex src/main.bib

SRC_DIR := src
OUTDIR := ..
AUXDIR := .build
LATEXMK := latexmk -e '$$max_repeat=8'
PDFLATEX := lualatex -interaction nonstopmode
COM_DIR := src/com
RESP_DIR := src/resp

COM_FILES := $(wildcard $(COM_DIR)/referee*/*)
RESP_FILES := $(wildcard $(RESP_DIR)/referee*/*)
BIB_FILES := $(wildcard src/bib/*)

main: natmat-response.pdf

natmat-response.pdf: FORCE src/input.tex src/main.bib
	cd "$(SRC_DIR)" && \
	$(LATEXMK) -lualatex="$(PDFLATEX)" -output-directory="$(OUTDIR)" -aux-directory="$(AUXDIR)" -pdf main.tex
	mv main.pdf natmat-response.pdf

src/input.tex: $(COM_FILES) $(RESP_FILES)
	rm -f src/input.tex && \
	bash src/build_input.sh

src/main.bib: $(BIB_FILES)
	cat "$(SRC_DIR)"/bib/* > src/main.bib

clean:
	cd "$(SRC_DIR)" && \
	$(LATEXMK) -output-directory="$(OUTDIR)" -aux-directory="$(AUXDIR)" -c -pdf main.tex
