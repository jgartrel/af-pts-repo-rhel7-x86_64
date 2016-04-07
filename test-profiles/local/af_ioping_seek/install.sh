#!/bin/sh

tar -zxvf ioping-0.9.tar.gz

cd ioping-0.9
make && cp -p ioping ~/ioping
echo $? > ~/install-exit-status
cd ~
rm -rf ioping-0.9 ioping-0.9.tar.gz

(
cat <<'EOF'
#!/bin/sh

./ioping $@ > $LOG_FILE 2>&1
echo $? > ~/test-exit-status

EOF
) > af_ioping_seek

chmod +x af_ioping_seek
