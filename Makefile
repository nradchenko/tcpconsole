VERSION=0.9

# www.vanheusden.com

DEBUG=-g -D_DEBUG
LDFLAGS+=$(DEBUG)
CFLAGS+=-O2 -Wall -Wextra -DVERSION=\"$(VERSION)\" $(DEBUG)

OBJS=error.o tc.o

all: tcpconsole

tcpconsole: $(OBJS)
	$(CC) -Wall -W $(OBJS) $(LDFLAGS) -o tcpconsole

install: tcpconsole
	mkdir -p $(DESTDIR)$(PREFIX)/sbin
	cp tcpconsole $(DESTDIR)$(PREFIX)/sbin
	mkdir -p $(DESTDIR)$(PREFIX)/etc/systemd/system
	cp tcpconsole.service $(DESTDIR)$(PREFIX)/etc/systemd/system

uninstall:
	rm /sbin/tcpconsole /etc/systemd/system/tcpconsole.service

clean:
	rm -f $(OBJS) core tcpconsole

package: clean
	# source package
	rm -rf tcpconsole-$(VERSION)*
	mkdir tcpconsole-$(VERSION)
	cp *.c *.h Makefile* README.md *service tcpconsole-$(VERSION)
	tar cf - tcpconsole-$(VERSION) | gzip -9 > tcpconsole-$(VERSION).tgz
	rm -rf tcpconsole-$(VERSION)
