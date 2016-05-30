 #!/bin/bash
 

 sudo mkdir -p /etc/udev/rules.d/
 sudo echo "SUBSYSTEM==”tty”, ATTRS{idVendor}==”0403”, ATTRS{idProduct}==”6015”, ATTRS{serial}==”DA013NVR”,SYMLINK+=”xbee”" > /etc/udev/rules.d/rules.rules


