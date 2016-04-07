#!/bin/sh

(
cat <<'EOF'
#!/bin/sh

ping $@ > $LOG_FILE 2>&1
echo $? > ~/test-exit-status

EOF
) > af_ping

chmod +x af_ping
