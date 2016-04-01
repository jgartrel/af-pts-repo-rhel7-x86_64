# af-pts-repo

This repo exists to store local test profiles for Phoronix Test Suite

Getting started with benchmarking:
```
yum install -y gcc gcc-c++ make autoconf automake glibc-static patch
yum install -y git
yum install -y php-cli php-xml bzip2 time numactl-devel

adduser pts
su - pts

git clone --recursive https://github.com/jgartrel/af-pts-repo.git .phoronix-test-suite
cd ~/.phoronix-test-suite/pts

./phoronix-test-suite enterprise-setup
./phoronix-test-suite detailed-system-info

./phoronix-test-suite install local/af-system-0.1.0

TEST_RESULTS_IDENTIFIER=$HOSTNAME-baseline TEST_RESULTS_NAME=$HOSTNAME-baseline MONITOR=all ./phoronix-test-suite batch-run pts/stream-1.2.0 local/af_speedtest-0.1.0 local/af_openssl-1.9.0

./phoronix-test-suite batch-run local/af-system-0.1.0
```
