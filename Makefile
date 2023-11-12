PROG = file
SRCS = file.c magic-dump.c magic-load.c magic-test.c magic-common.c text.c xmalloc.c
OBJS = ${SRCS:.c=.o}

CFLAGS  = -Icompat -O2 -std=c99 -D_GNU_SOURCE -Wall -Wextra -Wno-unused-parameter \
	-fstack-protector-all -fPIE `./have-pledge.sh`
LDFLAGS = compat/libcompat.a

MAGIC     = /etc/magic

.PHONY: all clean install

all: ${PROG} magic

compat/libcompat.a:
	@${MAKE} -C compat

.c.o:
	${CC} ${CFLAGS} -c $<

magic: ./magdir/*
	for i in ./magdir/*; do echo $$i; done | sort | xargs -n 1024 grep -Ehv '(^#|^$$)' >magic

${PROG}: compat/libcompat.a ${OBJS}
	${CC} ${CFLAGS} -o $@ ${OBJS} ${LDFLAGS}

clean:
	rm -f ${PROG} ${OBJS} magic
	@${MAKE} -C compat clean

install: all
	@mkdir -p ${DESTDIR}/bin
	install -m755 ${PROG} ${DESTDIR}/bin/${PROG}
	@strip ${DESTDIR}/bin/${PROG}

	@mkdir -p ${DESTDIR}/usr/share/man/man1
	install -m644 ${PROG}.1 ${DESTDIR}/usr/share/man/man1/${PROG}.1
	install -m644 magic.5 ${DESTDIR}/usr/share/man/man5/magic.5
	install -m444 magic ${DESTDIR}${MAGIC}

#syscall-linux.txt:
#	echo "#include <sys/syscall.h>" | cpp -dM | grep '^#define __NR_' | \
#		LC_ALL=C sed -r -n -e 's/^\#define[ \t]+__NR_([a-z0-9_]+)[ \t]+([0-9]+)(.*)/ [\2] = "\1",/p' >> $@ ;\
