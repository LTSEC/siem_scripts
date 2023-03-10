# start service
systemctl start auditd 
# download rules
wget https://raw.githubusercontent.com/Neo23x0/auditd/master/audit.rules -O $HOME/audit.rules
# load rules
auditctl -R $HOME/audit.rules
# confirm rule additions
auditctl -l 

# TO READ THESE LOGS, LOCATED AT
# /var/log/audit.log