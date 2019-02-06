#!/bin/bash
#######
#set up virtual ethernet port so that the next hecking thing works
#run as root
modprobe dummy
ip li add dummy0 type dummy
ip link set name eth10 dev dummy0
ifconfig eth10 hw ether 00:22:22:ff:ff:ff
ifconfig eth10 192.168.8.4

#################################
# Set up Ethernet bridge on Linux
# Set up Ethernet bridge on Linux
# Requires: bridge-utils
#################################

# Define Bridge Interface
br="br0"

# Define list of TAP interfaces to be bridged,
# for example tap="tap0 tap1 tap2".
tap="tap0"

# Define physical ethernet interface to be bridged
# with TAP interface(s) above.
eth="eth10"
eth_ip="192.168.8.4"
eth_netmask="255.255.255.0"
eth_broadcast="192.168.8.255"

for t in $tap; do
    openvpn --mktun --dev $t
done

brctl addbr $br
brctl addif $br $eth

for t in $tap; do
    brctl addif $br $t
done

for t in $tap; do
    ifconfig $t 0.0.0.0 promisc up
done

ifconfig $eth 0.0.0.0 promisc up

ifconfig $br $eth_ip netmask $eth_netmask broadcast $eth_broadcast

##endof bridgestart

echo 1 > /proc/sys/net/ipv4/ip_forward   #allow network forwarding

#allow network flow over bridged interface
iptables -A input -i tap0 -j ACCEPT
iptables -A input -i br0 -j ACCEPT
iptables -A FORWARD -i br0 -j ACCEPT

openvpn server.conf
