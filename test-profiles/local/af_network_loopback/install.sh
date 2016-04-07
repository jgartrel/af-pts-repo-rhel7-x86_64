#!/bin/sh

(
cat <<'EOF'
#!/bin/sh

nc -l 9999 > /dev/null &
sleep 3
dd if=/dev/zero bs=1M count=10000 | nc localhost 9999
echo $? > ~/test-exit-status

EOF
) > af_network_loopback

chmod +x af_network_loopback
