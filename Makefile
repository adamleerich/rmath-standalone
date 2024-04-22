#-*- Makefile -*-
include MkRules

CFLAGS = -O3 -Wall -pedantic $(EOPTS)
ifdef DEBUG
 CFLAGS += $(G_FLAG)
 DLLFLAGS =
else
 DLLFLAGS = -s
endif

.PHONY: cpy test

SOURCES_NMATH = $(wildcard ./src/nmath/*.c)
DEPENDS_NMATH = $(SOURCES_NMATH:.c=.d)
OBJECTS_NMATH = $(SOURCES_NMATH:.c=.o)


all: shared

static:
	$(MAKE) cpy
	$(MAKE) makeMakedeps
	$(MAKE) libRmath.a

shared: static
	$(MAKE) Rmath.dll

implib: libRmath.dll.a

cpy: stamp-src

stamp-src: $(SOURCES_NMATH)
	touch $@

ifdef USE_IMPLIBS
test: test-static.exe
else
test: test-static.exe test.exe
endif


## see R-admin for alternatives
test.exe: src/nmath/test.c
	$(CC) -I./include -DRMATH_DLL -o $@ $< -L. Rmath.dll
	./$@
test-static.exe: src/nmath/test.c
	$(CC) -I./include -o $@ $< -L. libRmath.a
	./$@

##	check: distclean
##		@rm -f check.log
##		@if test -n "${TEST_MC_CORES}"; then \
##		  echo "using ${TEST_MC_CORES} cores" > check.log; \
##		  $(MAKE) -j ${TEST_MC_CORES} all >> check.log 2>&1; \
##		  $(MAKE) test >> check.log 2>&1; \
##		else \
##		  $(MAKE) all test > check.log 2>&1; \
##		fi
##		@$(ECHO) "check output can be found in src/nmath/standalone/check.log"

clean:
	@$(RM) $(DEPENDS_NMATH) $(OBJECTS_NMATH) *.def Makedeps stamp-src
distclean: clean
	@$(RM) *.a Rmath.dll test*.exe check.log

DEFS = -DHAVE_CONFIG_H -DMATHLIB_STANDALONE
CPPFLAGS = -I./include $(DEFS)


libRmath.a: $(OBJECTS_NMATH)
Rmath.def: $(OBJECTS_NMATH)
	$(ECHO) EXPORTS > $@
	$(NM) $^ | $(SED) -n $(SYMPAT) >> $@
Rmath.dll: libRmath.a Rmath.def
	$(DLL) $(DLLFLAGS) --shared -o $@ Rmath.def $^
libRmath.dll.a: Rmath.def

# Dependencies
makeMakedeps: $(DEPENDS_NMATH)
	@$(RM) Makedeps
	@cat $(DEPENDS_NMATH) >> Makedeps

-include Makedeps
