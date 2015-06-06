#!/usr/bin/env bash
PWD=`pwd`
if [ $# -ne 3 ]; then
    echo
    echo "================================================================================================="
    echo Usage: installProject.sh institution install_dir github_branch
    echo
    echo "e.g. sudo ./installProject.sh pahma pahmaNV pahma_4.0_1 > install.log 2>&1"
    echo
    echo "this will install pahma_project repo, branch pahma_4.0-1, from github.com/cspace-deployment"
    echo "into /var/www/pahmaNV and configure it to run, except for Apache conf.d"
    echo "================================================================================================="
    exit
fi

if [ -e "/var/www/$2" ]; then
    echo "================================================================================================="
    echo "$2 already exists. Please remove it and retry."
    echo "================================================================================================="
    exit
fi

# start at home
cd ~
# clean out what was there, if anything
rm -rf /var/www/$2
mkdir /var/www/$2
ln -s /var/www/$2 $2
cd /var/www/$2
git clone https://github.com/cspace-deployment/$1_project .

git pull origin $3 -v
git checkout $3

python manage.py syncdb --noinput 
python manage.py collectstatic --noinput
#python manage.py loaddata ...

cp */*.cfg config/
cp */*.csv config/
cd config
rm authn.cfg main.cfg
# get rid of the old names, if there are any
perl -i -pe 's/${t}_project/${t}/g' *

cd
cat >> wsgi.conf <<EOM

# $2
   
Alias /$2_static ${PWD}/$2/static_root

WSGIDaemonProcess $2_wsgi python-path=/var/www/$2:${PWD}/venv/lib/python2.6/site-packages user=app_pahma group=app_pahma
WSGIProcessGroup $2_wsgi

WSGIScriptAlias /$2 $/var/www/$2/cspace_django_site/wsgi.py process-group=$2_wsgi

<Directory "/var/www/$2">
    Order deny,allow
    Allow from all
</Directory>

EOM
