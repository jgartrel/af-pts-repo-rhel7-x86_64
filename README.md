# af-pts-repo

This repo exists to store local test profiles for Phoronix Test Suite

Getting started with benchmarking on Vagrant (easier):
```
vagrant up --provider virtualbox
vagrant ssh

cd ~/.phoronix-test-suite/pts
TEST_RESULTS_IDENTIFIER=$HOSTNAME-baseline TEST_RESULTS_NAME=$HOSTNAME-baseline MONITOR=all ./phoronix-test-suite batch-run pts/stream local/af_speedtest local/af_openssl
```

Getting started with benchmarking on generic CentOS 7 hosted instance:
```
yum install -y gcc gcc-c++ make autoconf automake glibc-static patch
yum install -y git
yum install -y php-cli php-xml bzip2 unzip nmap-netcat

adduser pts
su - pts

git clone --recursive https://github.com/jgartrel/af-pts-repo.git .phoronix-test-suite
cd ~/.phoronix-test-suite/pts

./phoronix-test-suite enterprise-setup
./phoronix-test-suite detailed-system-info

./phoronix-test-suite install local/af-system

TEST_RESULTS_IDENTIFIER=$HOSTNAME-baseline TEST_RESULTS_NAME=$HOSTNAME-baseline MONITOR=all ./phoronix-test-suite batch-run pts/stream local/af_speedtest local/af_openssl

./phoronix-test-suite batch-run local/af-system
```
