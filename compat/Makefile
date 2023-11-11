LIB  = libcompat.a
SRCS = explicit_bzero.c freezero.c imsg-buffer.c imsg.c reallocarray.c \
       recallocarray.c setresgid.c setresuid.c strlcat.c strlcpy.c vis.c
OBJS = ${SRCS:.c=.o}

CC      = cc
CFLAGS  = -I. -I.. -O2 -std=c99 -D_GNU_SOURCE -Wall -Wextra \
	-fstack-protector-all -fPIE 
LDFLAGS = 

.PHONY: all clean

all: ${LIB}

.c.o:
	${CC} ${CFLAGS} -c $<

${LIB}: ${OBJS}
	${AR} -crsD $@ ${OBJS}

clean:
	rm -f ${LIB} ${OBJS}
