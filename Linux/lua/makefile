WRAPPER=rtimu_wrap.cxx
OBJS=$(WRAPPER:.cxx=.o)
CFLAGS=-c
LDFLAGS=-shared
LIBS=-lRTIMULib
LUAV=5.2
INC=-I/usr/include/lua$(LUAV) -I../..
LIBDIR=-L/usr/local/lib
IFILE=rtimu.i
TARGET=rtimu.so
SHAREDIR=/usr/local/share/sense_hat
LUALIBDIR=/usr/local/lib/lua/$(LUAV)

.SUFFIXES: .cxx .o .so

.cxx.o:
	g++ $(CFLAGS) $(INC) -o $@ $<

$(TARGET): $(OBJS)
	g++ $(LDFLAGS) $(LIBDIR) $(LIBS) -o $@ $<

$(OBJS): $(WRAPPER)

$(WRAPPER): $(IFILE)
	swig -c++ -lua $(IFILE)

clean:
	rm -f $(TARGET) $(OBJS)

uclean:
	$(MAKE) clean
	rm -f $(WRAPPER)

install:
	mkdir -p $(LUALIBDIR) && cp -f $(TARGET) $(LUALIBDIR)

uninstall:
	rm -rf $(LUALIBDIR)/$(TARGET)
