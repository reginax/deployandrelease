Deploy, Release, Start, Stop
============================

Tools (mainly shell scripts) to:
 
* deploy solr4 on Unix-like systems (Mac, Linux, perhaps even Unix).
* load the existing UCB solr datastores into the solr4 deployment.
* start and stop the solr service.
* create releases of Django projects (in GitHub).
* do initial installs of Django projects (via git).
* deploy new releases to existing running projects (via git).

Currently there are 10 tools, some mature, but mostly unripe, raw, and needy:

for Django projects:

* installProject.sh -- 1st time installation of a Django project (all that yucky permissions and SELinux stuff
* deployProject.sh -- update an existing project with fresh code from GitHub

for Solr4:

* installSolr.sh -- fetch solr4 tarball and deploys it
* installsolrpy.sh -- tried to install the solrpy module so Python can talk to Solr
* installDatasource.sh -- NOT EXECUTABLE: example commands for installing a single core datasource
* configureMultiCoreSolr.sh -- installs and configures the "standard" multicore configuration

* loadAllDatasourcees.sh -- loads all the solr datasources, assuming you've downloaded the nightly .gz file.

To install solr4 on UCB VMs, from scratch, or to completely update the solr datastores,the following seems to work:

```bash
# stop solr4 if it is running...assumes solr4 is already installed as a service
sudo service solr4 stop
# we install solr and its datastore here
cd /usr/local/share/
# get rid of any existing solr4 install here
sudo rm -rf solr4/
# fetch the solr tarball
sudo curl -O http://mirror.symnds.com/software/Apache/lucene/solr/4.10.4/solr-4.10.4.tgz
# get the UCB solr4 deployment scripts if you haven't already (i.e. whats in this repo)
cd ~
git clone https://github.com/cspace-deployment/deployandrelease.git
# get the Tools repo from GitHub, if you haven't already
git clone https://github.com/cspace-deployment/Tools.git /home/developers/Tools
# install solr4 in solr4/ configure the multicore deployment for UCB CSpace tenants
sudo ~/deployandrelease/configureMultiCoreSolr.sh /home/developers/Tools/ solr4 solr-4.10.4
sudo chown -R jblowe:developers solr4
sudo chmod -R g+wrx solr4
# start solr4...assumes solr4 is already installed as a service
sudo service solr4 start
# now load the datastores (takes about 15 minutes or so, depending)
cd ~/deployandrelease/
# two ways to do this:
# 1. if you're running solr on a server which has the solrr ETL for UCB installed (i.e. in /home/developers)
#    you can just copy the compressed files
cp /home/developers/*/4solr*.gz .
gunzip *.gz
# 2. Otherwise, you can scp them from some other server that has them
scp dev.cspace.berkeley.edu:/home/developers/*/4solr*.gz .
# uncompress them and load them
gunzip 4solr*.gz
nohup loadAllDatasourcees.sh &
```

Caveats:

* You should read and understand these scripts before using them!
* Mostly these expect the "standard" RHEL VM environment running at IS&T/RIT
* But they will mostly run on your Mac, perhaps with some tweaking.

Suggestions for "local installs", e.g. on your Macbook

```bash
#
# 1. Install Python Solr bindings
#
# cd ~
# ~/deployandrelease/installsolrpy.sh
#
# 2. configure the Solr multicore deployment using configureMultiCoreSolr.sh
#
# NB: takes 3 arguments! Assumes you have cloned the Tools repo...use the full path please
#
# cd ~
# git clone https://github.com/cspace-deployment/Tools
# 
# ...you can run this script 
# which unpacks solr, makes the UCB cores in multicore, copies the customized files needed
#
# ~/deployandrelease/configureMultiCoreSolr.sh /User/myhomedir/Tools solr4 solr-4.10.4
#
# 3. Install the startup script and start solr (this script puts the process into the background)
#
# cd ~/solr4/ucb
# cp ~/deployandrelease/startSolr.sh .
# ./startSolr.sh
# 
# 4. download all the current nightly dumps from dev.cspace
#
# for tidiness, make a directory to hold the various dumps:
#
# mkdir ~/4solr
# cd ~/4solr
#
# ~/deployandrelease/scp4solr.sh
#
# 4 execute the script to load all the .csv dump files (take 15 mins or so...some biggish datasources!)
#
# ~/deployandrelease/loadAllDatasources.sh
#
```

Install solr4 as a service on UCB VMs

```bash
# install the solr4.service script in /etc/init.d
sudo cp solr4.service /etc/init.d/solr4
# check that the script works
sudo service solr4 status
# if solr is installed as described above, the following should work
sudo service solr4 start
# you can also check if the service is running this way:
ps aux | grep java
# the logs are in the following directory:
ls -ltr /usr/local/share/solr4/ucb/logs/
# e.g.
less  /usr/local/share/solr4/ucb/logs/solr.log 
less  /usr/local/share/solr4/ucb/logs/2015_03_21-085800651.start.log 
```