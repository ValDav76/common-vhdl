# Nom du testbench
TB = testbench

# Fichiers VHDL
VHDL_SRCS = alu_addsub.vhd full_adder.vhd ripple_carry_adder.vhd testbench.vhd

# Commandes
GHDL = ghdl

# Paramètres simulation
SIM_TIME = 2us
VCD_FILE = wave.vcd

# Règle par défaut
all: sim

# Analyse tous les fichiers VHDL
analyze:
	$(GHDL) -a full_adder.vhd
	$(GHDL) -a ripple_carry_adder.vhd
	$(GHDL) -a alu_addsub.vhd
	$(GHDL) -a testbench.vhd

# Élaboration du testbench
elaborate: analyze
	$(GHDL) -e $(TB)

# Simulation avec génération du fichier VCD
sim: elaborate
	$(GHDL) -r $(TB) --vcd=$(VCD_FILE) --stop-time=$(SIM_TIME)
	$(GTK) $(VCD_FILE) &

# Nettoyage des fichiers générés par GHDL
clean:
	$(GHDL) --clean
	rm -f $(VCD_FILE)

.PHONY: all analyze elaborate sim clean
