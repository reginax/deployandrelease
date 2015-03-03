Deploy and Release
==================

Tools to create releases of Django projects, to install them, and to deploy new releases.

Currently there are seven, unripe, raw, needy tools:

for Django projects:

* installProject.sh -- 1st time installation of a Django project (all that yucky permissions and SELinux stuff
* deployProject.sh -- update an existing project with fresh code from GitHub

So, typically, something like:

```
sudo ./installProject.sh pahma pahmaNV pahma_4.0-1 > install.log 2>&1"
```
will install the `pahma_4.0-1` branch of the `pahma_project` in GitHub into `/usr/local/share/django/pahmaNV_project`. This works fine on UCB VMs, but you'll want to read the code and make sure it does the right thing for your deployment.  For example, you may not care for or need the SELinux stuff; you may not need to run this as root; you may want a different WSGI configuration that what is shown. Etc.

Don't forget, you will probably need to do more customizing the installation, as the script will suggest.

Once deployed, you may be able to update the code with

```
sudo ./deployProject.sh pahmaNV pahma_4.0-1 > deploy.log 2>&1"
```

(You don't need to provide the name of the GitHub project to update an existing project...)

Depending on which CollectionSpace deployment you are deploying webapps for, you may need to create directories for uploads, install Solr and upload datasources, etc.

for Solr4:

* installSolr.sh -- fetch solr4 tarball and deploys it
* installsolrpy.sh -- tried to install the solrpy module so Python can talk to Solr
* installDatasource.sh -- NOT EXECUTABLE: example commands for installing a single core datasource
* configureMultiCoreSolr.sh -- installs and configures the "standard" multicore configuration

* loadAllDatasourcees.sh -- loads all the solr datasources, assuming you've downloaded the nightly .gz file.

Caveats:

* You should read and understand these scripts before using them!
* Mostly these expect the "standard" RHEL VM environment running at IS&T/RIT
* But they will mostly run on your Mac, perhaps with some tweaking.

Suggestions for getting Solr going (this will get the UCB Solr cores up and running; you'll need to get the ETL datafiles, which will require credentials or a request to the UCB CSpace team):

1. Install Solr and Python Solr bindings

 ```
./installSolr.sh
./installsolrpy.sh
```
2. Configure the Solr multicore deployment using configureMultiCoreSolr.sh, start Solr4

```
./configureMultiCoreSolr.sh
cd ....        # wherever you installed Solr and the multicores
./startSolr.sh # you did copy this script from this deployandrelease directory, didn't you?
```
3. Download all the current nightly dumps from dev.cspace
```
./scp4solr.py
gunzip *.gz
```
4. Execute the following script to load them. NB ...you have to have all the cores installed and running!
```
./loadAllDatasourcees.sh
```


