# retro-vpn
A short script that allows a raspberry pi zero W, to become a bridged openVPN withouth an actual ethernet interface.

The script first creates a virtual ethernet port eth10
then it bridges that adapter with openVPN's bridging script
this allows old games to use udp broadcast for finding servers.

Be sure to change network adapter metrics in windows.


## openvpn brief guide

start your thing  
`systemctl start openvpn-server@server.service`  
`systemctl status openvpn-server@server.service`

go to easyrsa folder (obviously isntall openvpn and easyrsa beforehand) 
`cd /etc/openvpn/easyrsa`  
clean up anything that might be there    
`easyrsa clean-all`  
build a ca  
`easyrsa build-ca nopass`   
generate a diffie-hellmann, set a pw (remember it)  
`easyrsa gen-dh`   
generate a cert for the server   
`easyrsa build-server-full 3srv14 nopass`  
generate certs for clients     
`easyrsa build-client-full randomclient nopass`   

distribute client.conf, client.key, client.crt, ca.crt to clients

run startserver.sh, if you wannna revert the bridging run bridgestop.

