if [ $(command -v ufw) ]; then 
cp /etc/ufw/user.rules ufw-rules.pre
ufw disable
for port in $(ss -tulnp | grep LISTEN | tr -s ' '| cut -f 5 -d ' ' | rev | cut -f 1 -d ':' | rev); do ufw allow $port; echo lol allowed $port; done
ufw enable
ufw status verbose
fi