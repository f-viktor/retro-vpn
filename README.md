# retro-vpn
A short script that allows a raspberry pi zero W, to become a bridged openVPN withouth an actual ethernet interface.

The script first creates a virtual ethernet port eth10
then it bridges that adapter with openVPN's bridging script
this allows old games to use udp broadcast for finding servers.

Be sure to change network adapter metrics in windows.
