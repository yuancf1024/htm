#
#
# PACKAGE:		SpatialIndex
#

# --- Targets ------------------------------------------------------

default: all

all clean :
	mkdir -p lib
	@ cd src; ${MAKE} $@

libs :
	@ cd src; ${MAKE} all

apps : libs
	@ cd app; ${MAKE} all

linux :
	@ cd src; cp Makefile.linux Makefile

make tidy :
	@ cd src; ${MAKE} $@
	@ cd app; ${MAKE} $@