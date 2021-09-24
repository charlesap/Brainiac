# Brainiac
biologically inspired neural networks

Derived from Numenta's research and directly influenced by the Nupic code base

To run every example of te Brainiac algorithm you will need compilers or interpreters for C, Fortran, Java, Go, Oberon, and Python.

To obtain the compilers and interpreters for Debian 11 Bullseye you may do the following:

(as root)
 * apt install git wget build-essential fortran-compiler default-jre default-jdk libgc-dev libsdl1.2-dev
 * cd /usr/local; wget https://golang.org/dl/go1.17.1.linux-amd64.tar.gz; tar xvzf golang.org/dl/go1.17.1.linux-amd64.tar.gz
 * echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile.d/go.sh
 * cd /root/
 * wget http://miasap.se/obnc/downloads/obnc_0.16.1.tar.gz; tar xvzf obnc_0.16.1.tar.gz
 * wget http://miasap.se/obnc/downloads/obnc-libext_0.7.0.tar.gz; tar xvzf obnc-libext_0.7.0.tar.gz
 * cd obnc-0.16.1; ./build; ./install
 * cd ../obnc-libext-0.7.0; ./build; ./install

(as a user in a new shell, you may have to log out and log back in again)
 * git clone https://github.com/charlesap/Brainiac
 * cd Brainiac
 * make clean; make all

(as the user)
 * ./cbrainiac foo
 * ./fbrainiac foo
 * ./obrainiac foo
 * ./gobrainiac foo
 * python3 brainiac.py foo
 * java Brainiac foo

