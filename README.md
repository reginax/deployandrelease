Deploy and Release
==================

Tools to create releases of Django projects, to install them, and to deploy new releases.

Currently there are seven, unripe, raw, needy tools:

for Django projects:

* installProject.sh -- 1st time installation of a Django project (all that yucky permissions and SELinux stuff
* deployProject.sh -- update an existing project with fresh code from GitHub

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
