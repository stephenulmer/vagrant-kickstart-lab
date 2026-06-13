##
##
##

.POSIX:

MKISOFS := $(shell command -v mkisofs)
HDIUTIL := $(shell command -v hdituil)

all: ks.iso

ks.iso: $(shell find ks_iso) ks_iso/ks.cfg
ifneq ($(MKISOFS), "")
	${MKISOFS} -quiet -J -R -iso-level 3 -no-hfs -V OEMDRV -o ks.iso ks_iso
else ifneq ($(HDIUTIL), "")
	${HDIUTIL} makehybrid -iso -joliet -default-volume-name OEMDRV -o ks.iso ks_iso
else
	$(error No way to make an ISO image.)
endif

clean:
	rm -f ks.iso

realclean: clean
	rm -f ks_iso/ks.cfg

ks_iso/ks.cfg:
	$(warning No $@ file... using ks-dvd.cfg.)
	make dvd

dvd bootc:
	cp ks_iso/ks-$@.cfg ks_iso/ks.cfg

