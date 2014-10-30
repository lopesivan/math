SRCS      = $(shell ls *.hp50)

EXT       = hpprg
OUT       = $(foreach s,$(SRCS), $(addprefix $(s:.hp50=.), $(EXT)))

PROGRAM   = $(SRCS:.hp50=.hpprg)
TARGETS   = $(PROGRAM)

all: $(TARGETS)

build: join $(TARGETS)

join:
	./$(MOUNT)

%.hpprg: %.hp50
	./$(SCRIPT) $^ > $@
ide:
	wine $(IDE)
emu:
	wine $(EMU)
debug4x:
	wine $(DEBUG4X)
clean:
	/bin/rm -rf $(TARGETS) *~ $(OUT)
# END OF FILE
