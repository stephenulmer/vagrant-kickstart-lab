##
##
##


all: ks.iso

ks.iso: $(shell find ks_iso)
	rm -f ks.iso
	hdiutil makehybrid -iso -joliet -default-volume-name OEMDRV -o ks.iso ks_iso

clean:
	rm -f ks.iso
