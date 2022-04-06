SHELL	= /bin/sh
MAKE	= make
RPCGEN	= rpcgen
#LIBS	= -lsocket -lnsl

what:
	@echo "Usage: make system-type. Known types are:"
	@echo " "
	@echo "	aix		IBM AIX 3.x"
	@echo "	bsd		Generic 4.3 BSD"
	@echo "	bsd-no-rpcgen	same, without 'rpcgen' utility"
	@echo "	bsdi1		BSD/OS 1.x"
	@echo "	bsdi2		BSD/OS 2.x"
	@echo "	dgux		DG/UX 5.x"
	@echo "	freebsd		FreeBSD 2.x"
	@echo "	hpux9 		HP/UX 9.x"
	@echo "	irix4		IRIX 4.x"
	@echo "	irix5		IRIX 5.x"
	@echo "	linux 		(needs patches from the net)"
	@echo "	osf 		aka Digital UNIX"
	@echo "	sco		SCO UNIX"
	@echo "	sunos4		SunOS 4.1.x"
	@echo "	sunos5		SunOS 5.x"
	@echo "	sysv4 		Generic System V.4"
	@echo "	sysv4-no-rpcgen	same, without 'rpcgen' utility"
	@echo "	ultrix4		Ultrix 4.x"
	@echo " "
	@exit 1;

aix osf bsd sunos4:
	@$(MAKE) all LIBS= XFLAGS="-DAUTH_GID_T=int"

hpux9:
	@$(MAKE) all LIBS= XFLAGS="-DAUTH_GID_T=int" "RPCGEN=rpcgen 2>/dev/null"

ultrix4 bsd-no-rpcgen:
	@$(MAKE) rpcgen all LIBS= XFLAGS="-DAUTH_GID_T=int" \
		RPCGEN="../../bin/rpcgen"

bsdi1:
	@$(MAKE) all LIBS="-lrpc" \
		XFLAGS="-DAUTH_GID_T=int -I`pwd`/include/$@"

bsdi2:
	@$(MAKE) all LIBS="-lrpc" \
		XFLAGS="-DAUTH_GID_T=int -DSYS_ERRLIST_DECLARED" 

freebsd:
	@$(MAKE) all LIBS= XFLAGS="-DAUTH_GID_T=int -DSYS_ERRLIST_DECLARED"

linux:
	@echo The LINUX rules are untested and may be wrong
	@set +e; test -f include/netinet/ip.h || {\
		echo Please copy the 44BSD /usr/include/netinet include files; \
		echo to `pwd`/include/netinet and try again.;\
		exit 1; \
	}
	@$(MAKE) all LIBS= XFLAGS="-I`pwd`/include -DAUTH_GID_T=int"

irix4:
	@$(MAKE) all LIBS="-lXm_s -lXt_s -lX11_s -lPW -lc_s -lsun" \
		XFLAGS="-DAUTH_GID_T=int"

irix5:
	@$(MAKE) all LIBS= XFLAGS="-DAUTH_GID_T=gid_t"

dgux:
	@$(MAKE) all LIBS="-lnsl" XFLAGS="-DAUTH_GID_T=gid_t -DTIRPC"

sunos5 sysv4:
	@$(MAKE) all LIBS="-lsocket -lnsl" XFLAGS="-DAUTH_GID_T=gid_t -DTIRPC"

sysv4-no-rpcgen:
	@$(MAKE) rpcgen all LIBS="-lsocket -lnsl" \
		XFLAGS="-DAUTH_GID_T=gid_t -DTIRPC" \
		RPCGEN="../../bin/rpcgen"

sco:
	@$(MAKE) all LIBS="-lrpc -lsocket" XFLAGS="-DAUTH_GID_T=gid_t"

rpcgen:
	cd src/rpcgen; $(MAKE) "LIBS=$(LIBS)" "XFLAGS=$(XFLAGS)"

all:
	cd src/misc; $(MAKE) "LIBS=$(LIBS)" "XFLAGS=$(XFLAGS)" "RPCGEN=$(RPCGEN)"
	cd src/boot; $(MAKE) "LIBS=$(LIBS)" "XFLAGS=$(XFLAGS)" "RPCGEN=$(RPCGEN)"
	cd src/port_scan; $(MAKE) "LIBS=$(LIBS)" "XFLAGS=$(XFLAGS)"
	cd src/nfs-chk; $(MAKE) "LIBS=$(LIBS)" "XFLAGS=$(XFLAGS)" "RPCGEN=$(RPCGEN)"
	cd src/yp-chk; $(MAKE) "LIBS=$(LIBS)" "XFLAGS=$(XFLAGS)" "RPCGEN=$(RPCGEN)"
	cd src/fping; $(MAKE) "LIBS=$(LIBS)" "CFLAGS=$(XFLAGS)"

checksums:
	@find * -type f -print | sort | xargs md5

clean: 
	cd src/misc; $(MAKE) clean
	cd src/boot; $(MAKE) clean
	cd src/port_scan; $(MAKE) clean
	cd src/nfs-chk; $(MAKE) clean
	cd src/yp-chk; $(MAKE) clean
	cd src/fping; $(MAKE) clean
	cd src/rpcgen; $(MAKE) clean
	rm -f html/satan.html html/satan_documentation.html status_file \
	bit_bucket

tidy:	clean
	rm -f *.old *.bak *.orig */*.old */*.bak */*.orig tmp_file* core
	rm -rf results
	chmod -x satan
