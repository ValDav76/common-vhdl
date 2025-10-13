# Nom du testbench
TB = testbench

# Fichiers VHDL
VHDL_SRCS = D_flip_flop.vhd register.vhd testbench.vhd

# Commandes
GHDL = ghdl

# Paramètres simulation
SIM_TIME = 2us
VCD_FILE = wave.vcd

# Règle par défaut
all: sim

# Analyse tous les fichiers VHDL
analyze:
	$(GHDL) -a $(VHDL_SRCS)

# Élaboration du testbench
elaborate: analyze
	$(GHDL) -e $(TB)

# Simulation avec génération du fichier VCD
sim: elaborate
	$(GHDL) -r $(TB) --vcd=$(VCD_FILE) --stop-time=$(SIM_TIME)

# Nettoyage des fichiers générés par GHDL
clean:
	$(GHDL) --clean
	rm -f $(VCD_FILE)

.PHONY: all analyze elaborate sim clean
