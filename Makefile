#
# UDFclient toolkit
#
# Copyright 2003,2004,2005 Reinoud P.Zandijk
#
#
# File $Id: Makefile.in,v 1.24 2017/01/10 09:52:30 reinoud Exp $ $Name:  $
#

srcdir=		.

prefix=		/usr/local
exec_prefix=	${prefix}
sbindir=	${exec_prefix}/sbin
mandir=		${datarootdir}/man
bindir=		${exec_prefix}/bin
datarootdir=	${prefix}/share

CC=		gcc
LD=		$(CC)
CPPFLAGS=	 -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=500 -D__USE_BSD -D_FILE_OFFSET_BITS=64   -DNO_INT_FMTIO -Dst_atimespec=st_atim -Dst_ctimespec=st_ctim -Dst_mtimespec=st_mtim -DNO_STAT_BIRTHTIME  -DNO_DIRENT_NAMLEN -DSCSI -DUSCSI_LINUX_SCSI -DPACKAGE_NAME=\"udfclient\" -DPACKAGE_TARNAME=\"udfclient\" -DPACKAGE_VERSION=\"0.8.11\" -DPACKAGE_STRING=\"udfclient\ 0.8.11\" -DPACKAGE_BUGREPORT=\"reinoud@NetBSD.org\" -DPACKAGE_URL=\"\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_ENDIAN_H=1 -DHAVE_SYS_ENDIAN_H=1 -DHAVE_STRUCT_STAT_ST_ATIM=1 -DHAVE_SCSI_SG_H=1 -I$(srcdir)
CFLAGS=		-g -O2
LDFLAGS=	

INSTALL=	/data/data/com.termux/files/usr/bin/install -c

# NetBSD
#CFLAGS+= -Wall \
#	 -Wuninitialized \
#	 -fno-strict-aliasing \
#	 -Wextra -Werror
#	 -Werror ${COPTS} \
#	 -DNDEBUG

# Anonymising this client (for comformity)
#CFLAGS+= -D__ANONYMOUSUDF__

#CFLAGS+= -fPIC -DPIC
POSTOBJ+=  -lpthread -lc


# For use with the cpuflags package
#CPROCFLAGS != cpuflags
CFLAGS+= ${CPROCFLAGS}


# Main programs
APPS=		udfdump udfclient newfs_udf cd_sessions
SCSI_APPS=	cd_disect mmc_format
LIB=		osta.o udf.o udf_bmap.o udf_allocentries.o udf_discop.o uio.o
LIB+=		udf_verbose.o udf_readwrite.o udf_unix.o vfs_dirhash.o
USCSILIB=	uscsi_sense.o uscsi_subr.o

CFLAGS+= -DNEEDS_ISPRINT $(CPPFLAGS)

all: $(APPS) $(SCSI_APPS)

install: $(APPS) $(SCSI_APPS)
	$(INSTALL) -d $(DESTDIR)/$(bindir)
	for app in $(APPS) $(SCSI_APPS); do \
		echo "$(INSTALL) $$app $(DESTDIR)/$(bindir)/$$app"; \
		$(INSTALL) $$app $(DESTDIR)/$(bindir)/$$app; \
	done

depend:
	mkdep $(CFLAGS) *.c

clean:
	rm -f *.o *.a *.core core.* core .depend *~ *.bak $(APPS) $(SCSI_APPS)
	rm -fr autom*.cache config.log config.status configure.lineno

cleandir: clean
	rm -f Makefile

libuscsi.a: $(USCSILIB)
	ar -rsc libuscsi.a $(USCSILIB)

libudf.a: $(LIB)
	ar -rsc libudf.a $(LIB)

$(SCSI_APPS): $@.o libuscsi.a
	$(LD) -o $@ $(LDFLAGS) $@.c libuscsi.a $(POSTOBJ)

$(APPS): $@.o libuscsi.a libudf.a
	$(LD) -o $@ $(CPPFLAGS) $(LDFLAGS) $@.c libudf.a libuscsi.a $(POSTOBJ)


# DO NOT DELETE
