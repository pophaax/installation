 #!/bin/bash
 

 ##sudo mkdir -p /bash/bash.bashrc
echo "Are you running this with sudo?"
echo "If not you totally should"
echo >> /home/sailbot/.bashrc
echo >> /home/sailbot/.bashrc
echo "export SAILINGROBOTS_HOME=/home/sailbot/sailingrobot\${SAILINGROBOTS_HOME}" >>  /etc/bash.bashrc
echo >> /home/sailbot/.bashrc
echo "Created environment variable: \$SAILINGROBOTS_HOME - please restart terminal before calling it."



