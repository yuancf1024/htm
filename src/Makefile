# --- Macros ----------------------------------------------------------

CCXX	=	g++
C		=   gcc
LD		=	g++
INCLUDE =	-I../include
CCFLAGS =	${INCLUDE} -O2 -DLINKAGE= -fPIC
ARFLAGS =	-rlcs
CP		=	cp
RM		=	rm -f
LIBNAME =	libSpatialIndex

LIBOBJS	=		SpatialIndex.o \
				SpatialConstraint.o \
				sqlInterface.o \
				SpatialVector.o \
				SpatialInterface.o \
				SpatialEdge.o \
				SpatialException.o \
				SpatialDomain.o \
				RangeConvex.o \
				Htmio.o \
				SkipListElement.o \
				SkipList.o \
				HtmRange.o \
				HtmRangeIterator.o \
				cc_aux.o 

LINKLIB	=	../lib/${LIBNAME}.a


# --- Targets----------------------------------------------------------

# Build and install the library

all	:	${LINKLIB} share
lib :	${LINKLIB}


${LINKLIB}	:	${LIBOBJS}
	${AR} ${ARFLAGS} $@ $?

share:
	$(LD) -shared -o ../lib/${LIBNAME}.so ${LIBOBJS}

# Clean without removing installed procedures.

tidy :
	- ${RM} ${LIBOBJS}

# Remove all files generated or installed by make.

clean : tidy
	- cd ../lib; ${RM} ${LIBNAME}.*; rm -rf Templates.DB
	- cd ../include; ${RM}
	#- cd ../doc/www; ${RM}

# --- Suffix Rules----------------------------------------------------------

# First clear out the default suffixes, then declare our own and
# define the Rules.

.SUFFIXES:
.SUFFIXES: .o .cpp .c

# Compiling C++ code. The command lines are so long as to be useless.
# Use 'sxmake -terse' to suppress the echo of the compile command.

.cpp.o:
	@ echo compiling $<
	${CCXX} -c ${CCFLAGS} $<

.c.o:
	@ echo compiling $<
	${C} -c ${CCFLAGS} $<