CFLAGS=-g -Isrc

all: build/mongrel2

OBJS=src/http11/http11_parser.o src/server.o src/adt/tst.o src/b64/b64.o src/task/libtask.a src/adt/hash.o src/proxy.o src/register.o src/listener.o

build/mongrel2: $(OBJS)
	if [ ! -d build ]; then mkdir build; fi
	$(CC) $(CLAGS) -o build/mongrel2 -lzmq -pthread -lsqlite3 $(OBJS)

build/mqshell: src/mqshell.o
	$(CC) $(CFLAGS) -o build/mqshell -lzmq -pthread src/mqshell.o

src/task/libtask.a:
	cd src/task && make clean && make

clean:
	find . -name "*.o" -exec rm {} \;
	cd src/task && make clean
	rm -f build/*

