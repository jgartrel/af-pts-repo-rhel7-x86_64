#!/bin/bash

# Install required packages
yum install -y git php-cli php-xml bzip2 unzip nmap-netcat libtool

# Add the pts user
adduser pts

# Clone the benchmarking repo
su -c "git clone --recursive https://github.com/jgartrel/af-pts-repo-rhel7-x86_64.git .phoronix-test-suite2" -l pts

# Create crontab to run test every hour
(
cat <<'EOF'
1 * * * * /home/pts/.phoronix-test-suite/run-bench.sh
EOF
) > /var/spool/cron/pts

chmod 600 /var/spool/cron/pts
chown pts:pts /var/spool/cron/pts
