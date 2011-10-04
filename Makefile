ROOT=`pwd`
install:
	echo "installing xquerydoc ................"
	mkdir -p /usr/local/bin
	ln -s $(ROOT)/bin/xquerydoc /usr/local/bin/xquerydoc
	java -jar $(ROOT)/deps/calabash-0.9.35.jar
clean:
	rm /usr/local/bin/xquerydoc
test:
	bin/run-saxon-tests.sh
