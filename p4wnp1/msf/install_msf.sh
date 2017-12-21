#!/bin/sh

sudo apt-get update
sudo apt-get -y install build-essential zlib1g zlib1g-dev libxml2 libxml2-dev libxslt-dev locate libreadline6-dev libcurl4-openssl-dev git-core libssl-dev libyaml-dev openssl autoconf libtool ncurses-dev bison curl wget postgresql postgresql-contrib libpq-dev libapr1 libaprutil1 libsvn1 libpcap-dev libsqlite3-dev git-core postgresql curl gem ruby-dev ruby nmap
sudo gem install wirble sqlite3 bundler

sudo systemctl start postgresql
sudo -u postgres bash -c "psql -c \"CREATE USER msfgit WITH PASSWORD 'msf';\""
sudo -u postgres createdb -O msfgit msf

mkdir -p ~/.msf4/plugins
cd ~/.msf4/plugins
curl -O https://raw.githubusercontent.com/jeffbryner/kinectasploit/master/db_autopwn.rb

cat > ~/.msf4/database.yml << EOF
production:
 adapter: postgresql
 database: msf
 username: msfgit
 password: msf
 host: 127.0.0.1
 port: 5432
 pool: 75
 timeout: 5
EOF

cat > ~/.msf4/msfconsole.rc << EOF
db_connect -y ~/.msf4/database.yml
EOF

cd /home/pi/P4wnP1
git clone https://github.com/rapid7/metasploit-framework.git
cd metasploit-framework
bundle install

