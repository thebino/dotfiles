# Port Forwarding
#
# used when no port forwarding is possible on the router
# forward 'localhost:8080' to '172.22.5.1:9092'
alias forward='ssh home -L localhost:9090:172.22.5.1:8989'


# Reverse Port Forwarding
#
# used to publish a webpage to the internet
alias backward='ssh -R 80:localhost:3000 serveo.net'


# Dynamic Port Forwarding
#
# used when a web blocker is used
# Enter 'localhost:8181' as socks proxy in your browser
# needs 'AllowTcpForwarding' & 'PermitOpen' enabled in /etc/sshd_config
#
# -C (compression)
# -N (no remote commands)
# -f (background process)
alias socks='ssh home -fNC -D 9090'


# Reverse
#
# used to access a computer connected from remote
# needs 'AllowTcpForwarding' & 'GatewayPorts' enabled in /etc/sshd_config
#
# -C (compression)
# -N (no remote commands)
# -f (background process)
alias tunnel='ssh home -fNC -R 9000:localhost:80'
