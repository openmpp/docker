## Additional build scripts for RedHat 7

RedHat 7 is NO longer supported by openM++ team.
Therefore RedHat 7 build may not work.


To build openM++ do:

  cd openm/dir/ompp-docker/redhat-7-build/
  ./build-redhat-7.sh


Environment variables and default values:

  SQLITE_PATH = ${HOME}/sqlite
                        sqlite/bin
  BISON_PATH  = ${HOME}/bison
                        bison/bin
                        bison/lib
  GOROOT      = ${HOME}/go
                        go/bin
  NODE_PATH   = ${HOME}/node
                        node/bin

Output directory:
   OUT_BUILD_PATH = ${HOME}/build

Also you can use ompp-docker/ompp-build-redhat environment variables


Required to be installed:

  yum install devtoolset-9
  yum install git

Required to be dowloaded and unpacked into any directory:

  Go language
    recommended:     1.20 and after
    minimal version: 1.17

  Node.js
    recommended:     16.xx
    minimal version: 14.xx
    maximum version  17.xx
    version 18.yy and above not working

Required to be build from sources:

  SQLite command line tool: sqlite3
    minimal version: 3.8.3
    recommended:     year 2020 and after
  
    cd ~
    curl -o sqlite-src.tar.gz https://www.sqlite.org/2023/sqlite-autoconf-3420000.tar.gz
    tar xzf sqlite-src.tar.gz
    cd sqlite-autoconf-3420000
    ./configure --prefix=$HOME/sqlite
    make
    make install

  Bison
    minimal version: 3.3
    recommended:     3.7.5

    cd ~
    curl -o bison-setup.tar.gz https://ftp.gnu.org/gnu/bison/bison-3.7.5.tar.gz
    tar -xzf /tmp/bison-setup.tar.gz
    cd bison-3.7.5
    ./configure --prefix=$HOME/bison
    make
    make install

