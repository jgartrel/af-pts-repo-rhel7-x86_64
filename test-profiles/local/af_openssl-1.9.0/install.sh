#!/bin/sh

tar -zxvf openssl-1.0.1g.tar.gz

cd openssl-1.0.1g/
./config no-zlib
make
echo \$? > ~/install-exit-status
cd ~

(
cat <<'EOF'
#!/bin/sh

./openssl-1.0.1g/apps/openssl $@ > $LOG_FILE 2>&1
echo $? > ~/test-exit-status

EOF
) > af_openssl

chmod +x af_openssl
