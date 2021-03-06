# ebml

EBML_VERSION := 1.3.4
EBML_URL := http://dl.matroska.org/downloads/libebml/libebml-$(EBML_VERSION).tar.bz2

$(TARBALLS)/libebml-$(EBML_VERSION).tar.bz2:
	$(call download_pkg,$(EBML_URL),ebml)

.sum-ebml: libebml-$(EBML_VERSION).tar.bz2

libebml: libebml-$(EBML_VERSION).tar.bz2 .sum-ebml
	$(UNPACK)
	$(MOVE)

# libebml requires exceptions
EBML_EXTRA_FLAGS = CXXFLAGS="${CXXFLAGS} -fexceptions -fvisibility=hidden" \
					CPPFLAGS=""

.ebml: libebml
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(EBML_EXTRA_FLAGS)
	cd $< && $(MAKE) install
	touch $@
