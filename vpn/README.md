VPN SSH
=======

About
======
Makes a vpn tunnel with ssh


Install
=====
- Create a user named vpn on the server
  adduser vpn

- give it sudo rights:

  Cmnd_Alias VPN=/usr/sbin/pppd
  vpn ALL=NOPASSWD: VPN

- copy the public key over to the user

TODO: make it possible to hava a dedicated key pair for the tunnel.

