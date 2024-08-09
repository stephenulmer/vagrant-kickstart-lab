##
##
##


all: ks.iso

ks.iso: $(shell find ks_iso)
	rm -f ks.iso
	if [ -f $$(which mkisofs) ] ; then \
	  mkisofs -quiet -J -R -iso-level 3 -no-hfs -V OEMDRV -o ks.iso ks_iso ; \
	elif [ -x $$(which hdiutil) ] ; then \
	  hdiutil makehybrid -iso -joliet -default-volume-name OEMDRV -o ks.iso ks_iso ; \
	else \
	  echo "No way to make an ISO image!" ; \
	fi

clean:
	rm -f ks.iso
