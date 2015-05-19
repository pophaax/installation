 #!/bin/bash
 

 ##sudo mkdir -p /bash/bash.bashrc
echo "Are you running this with sudo?"
echo "If not you totally should"
echo >> /etc/bash.bashrc
echo >> /etc/bash.bashrc
echo "export SAILINGROBOTS_HOME=/home/sailbot/sailingrobot\${SAILINGROBOTS_HOME}" >>  /etc/bash.bashrc
echo >> /etc/bash.bashrc
echo "Created environment variable: \$SAILINGROBOTS_HOME - please restart terminal before calling it."



