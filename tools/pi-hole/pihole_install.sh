#!/bin/bash
curl -sSL https://install.pi-hole.net | bash
echo 'https://raw.githubusercontent.com/flarebrow/public/master/Adhost/hosts' | tee -a /etc/pihole/adlists.list
pihole -g
