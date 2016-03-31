# af-pts-repo

This repo exists to store local test profiles for Phoronix Test Suite

Getting started with benchmarking:
```
yum install -y gcc gcc-c++ make autoconf automake glibc-static patch
yum install -y git
yum install -y php-cli php-xml bzip2 time numactl-devel

git clone https://github.com/jgartrel/phoronix-test-suite.git
cd phoronix-test-suite
git checkout af
./install-sh
phoronix-test-suite detailed-system-info

cd /var/lib/phoronix-test-suite
git clone https://github.com/jgartrel/af-pts-repo.git

pushd test-profiles
rm -rf local
ln -s ../af-pts-repo/test-profiles local
popd

pushd test-suites
rm -rf local
ln -s ../af-pts-repo/test-suites local
popd

phoronix-test-suite batch-setup

phoronix-test-suite install local/af-system-0.1.0
phoronix-test-suite batch-run local/af-system-0.1.0

## Removed
##phoronix-test-suite list-available-tests |grep ^local/af |awk '{print $1}'|xargs -n1 phoronix-test-suite install

```
