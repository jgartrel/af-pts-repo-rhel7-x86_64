#!/bin/sh

unzip 0.5.zip
cd sysbench-0.5
./autogen.sh
./configure --without-mysql
make && cp -p sysbench/sysbench ~/sysbench
echo $? > ~/install-exit-status
cd ~
rm -rf sysbench-0.5 0.5.zip

(
cat <<'EOF'
#!/bin/sh

./sysbench --num-threads=$NUM_CPU_CORES $@ > $LOG_FILE 2>&1
echo $? > ~/test-exit-status

EOF
) > af_sysbench_cpu

chmod +x af_sysbench_cpu
