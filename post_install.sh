#!/bin/sh -x
IP_ADDRESS=$(ifconfig | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}')

cd /usr/local/share
git clone https://github.com/FlareSolverr/FlareSolverr.git
cd FlareSolverr

export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=/usr/local/bin/chrome

npm install
node node_modules/puppeteer/install.js
npm install puppeteer@1.2.0
npm install puppeteer
npm run build

sysrc flaresolverr_enable=YES

service flaresolverr start

echo -e "FlareSolveer now installed.\n" > /root/PLUGIN_INFO
echo -e "\nPoint your Jackett or arr to $IP_ADDRESS:8191\n" >> /root/PLUGIN_INFO