ROOT=`pwd`
install:
	echo "installing xquerydoc ................"
	mkdir -p /usr/local/bin
	ln -s $(ROOT)/bin/xquerydoc /usr/local/bin/xquerydoc
	java -jar $(ROOT)/deps/calabash-0.9.34.jar
clean:
	rm /usr/local/bin/xquerydoc
