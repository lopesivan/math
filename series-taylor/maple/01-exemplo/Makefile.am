texs = $(wildcard *.tex)
mpls = $(wildcard *.mpl)

EXT           = png dvi ps pdf log dvi aux out glo ist bak nav out snm toc jpeg
CONVERTE      = convert
CONVERTEFLAGS = -density 300 -quality 90

outFiles      = $(foreach tex,$(texs), $(addprefix $(tex:.tex=.), $(EXT)))\
				$(foreach tex,$(mpls), $(addprefix $(tex:.mpl=.), $(EXT)))
# -------------------------------------------------------------------------- #
# shell macro
# -------------------------------------------------------------------------- #
withpngtargets=\
	for d in $(texs); \
	do \
		echo $${d%.tex}.pdf; \
		echo $${d%.tex}.png; \
	done
targets=\
	for d in $(texs); \
	do \
		echo $${d%.tex}.pdf; \
	done
mapletargets=\
	for d in $(mpls); \
	do \
		echo $${d%.mpl}.out; \
	done
##############################################################################

# -------------------------------------------------------------------------- #
# rules
# -------------------------------------------------------------------------- #

# tex -> dvi
%.dvi:  %.tex
	$(LATEX) $(@:.dvi=)

# dvi -> ps
%.ps:   %.dvi
	$(DVIPS) $(@:.ps=)

# ps -> pdf
%.pdf:  %.ps
	$(PS2PDF) $^

# ps -> png

%.png:  %.ps
	$(CONVERTE) $(CONVERTEFLAGS) $^ $@
##############################################################################

# -------------------------------------------------------------------------- #
# -------------------------------------------------------------------------- #
# -------------------------------------------------------------------------- #

if HAS_TEX_TOOLS

all: $(shell $(targets))

endif

# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------

if HAS_MAPLE_CMD

maple: $(shell $(mapletargets))

%.out: %.mpl
	$(MAPLE) -q < $^ > $@
endif

# auto clean.
CLEANFILES = $(outFiles)
#
# END OF FILE
