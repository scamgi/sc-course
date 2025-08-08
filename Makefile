# Nome del file sorgente principale
SRC = main.tex

# Directory di output per i file generati
OUT_DIR = out

# Il file PDF finale che vogliamo creare
TARGET = $(OUT_DIR)/$(SRC:.tex=.pdf)

# Comando per la compilazione
LATEXMK = latexmk

# Opzioni per latexmk:
# -pdf: Genera un PDF
# -output-directory: Specifica dove salvare i file (log, aux, pdf, etc.)
# -interaction=nonstopmode: Evita che la compilazione si fermi per errori minori
LFLAGS = -pdf -output-directory=$(OUT_DIR) -interaction=nonstopmode

# Trova tutti i file .tex nelle sottocartelle per le dipendenze
PROBLEM_FILES = $(wildcard problems/*.tex)
SOLUTION_FILES = $(wildcard solutions/*.tex)

# Il target di default, invocato eseguendo 'make'
all: $(TARGET)

# Regola per creare il PDF
# Il target dipende dal file main, dal preambolo e da tutti i file di esercizi/soluzioni
$(TARGET): $(SRC) preamble.tex $(PROBLEM_FILES) $(SOLUTION_FILES)
	@echo "Compilando il progetto LaTeX..."
	$(LATEXMK) $(LFLAGS) $(SRC)
	@echo "Compilazione completata. PDF disponibile in $(TARGET)"

# Comando per pulire i file ausiliari generati da LaTeX
clean:
	@echo "Pulendo i file ausiliari..."
	$(LATEXMK) -c -output-directory=$(OUT_DIR)

# Comando per pulire tutto, inclusa la cartella di output
clean-all:
	@echo "Rimuovendo la cartella di output..."
	rm -rf $(OUT_DIR)

# Dichiara i target che non corrispondono a nomi di file
.PHONY: all clean clean-all