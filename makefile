all:

install:
	bash ./make_helpers/install_helper.sh

uninstall:
	bash ./make_helpers/uninstall_helper.sh

.PHONY: all install uninstall
