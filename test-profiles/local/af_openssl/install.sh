#!/bin/sh

tar -zxvf openssl-1.0.1g.tar.gz

cd openssl-1.0.1g/
./config no-zlib
make && cp -p apps/openssl ~/openssl
echo $? > ~/install-exit-status
cd ~
rm -rf openssl-1.0.1g.tar.gz openssl-1.0.1g

(
cat <<'EOF'
#!/bin/sh

./openssl $@ > $LOG_FILE 2>&1
echo $? > ~/test-exit-status

EOF
) > af_openssl

chmod +x af_openssl
