VERSION = 5.19
PN = profile-sync-daemon

DESTDIR =
PREFIX = /usr
CONFDIR = /etc
CRONDIR = /etc/cron.hourly
INITDIR = /usr/lib/systemd/system
BINDIR = $(PREFIX)/bin
DOCDIR = $(PREFIX)/share/doc/$(PN)-$(VERSION)
MANDIR = $(PREFIX)/share/man/man1

install-bin:
	@echo -e '\033[1;32minstalling main script, initd and config...\033[0m'
	install -Dm755 common/$(PN) "$(DESTDIR)$(BINDIR)/$(PN)"
	install -Dm644 common/psd.conf "$(DESTDIR)$(CONFDIR)/psd.conf"
	install -Dm644 init/psd.service "$(DESTDIR)$(INITDIR)/psd.service"
	@sed -i -e 's/@VERSION@/'$(VERSION)'/' "$(DESTDIR)$(BINDIR)/$(PN)"
	ln -s $(PN) "$(DESTDIR)$(BINDIR)/psd"

install-man:
	@echo -e '\033[1;32minstalling manpage...\033[0m'
	install -Dm644 doc/psd.1 "$(DESTDIR)$(MANDIR)/psd.1"
	gzip -9 "$(DESTDIR)$(MANDIR)/psd.1"
	ln -s psd.1.gz "$(DESTDIR)$(MANDIR)/$(PN).1.gz"

install-cron:
	@echo -e '\033[1;32minstalling cronjob...\033[0m'
	install -Dm755 common/psd.cron.hourly "$(DESTDIR)$(CRONDIR)/psd-update"

install: install-bin install-man install-cron
