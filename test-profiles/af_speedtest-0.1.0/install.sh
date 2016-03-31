#!/bin/sh

chmod a+x speedtest_cli.py
echo \$? > ~/install-exit-status
cd ~

(
cat <<'EOF'
#!/bin/sh

./speedtest_cli.py --simple > $LOG_FILE 2>&1
echo $? > ~/test-exit-status

EOF
) > af_speedtest

chmod +x af_speedtest
