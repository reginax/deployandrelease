PWD=`pwd`
if [ $# -ne 3 ]; then
    echo
    echo "================================================================================================="
    echo Usage: installProject.sh institution install_dir github_branch
    echo
    echo "e.g. sudo ./installProject.sh pahma pahmaNV pahma_4.0_1 > install.log 2>&1"
    echo
    echo "this will install pahma_project branch pahma_4.0-1 from github.com/cspace-deployment"
    echo "into pahmaNV and configure it to run, except for Apache conf.d"
    echo "================================================================================================="
    exit
fi

if [ -e "$2" ]; then
    echo "================================================================================================="
    echo "$2 already exists. Please remove it and retry."
    echo "================================================================================================="
    exit
fi

git clone https://github.com/cspace-deployment/$1_project $2

cd $2/
git pull origin $3 -v
git checkout $3

python manage.py syncdb --noinput 
python manage.py collectstatic --noinput
#python manage.py loaddata ...

cp */*.cfg config/
cp */*.csv config/
cd config
rm authn.cfg main.cfg
perl -i -pe 's/${t}_project/${t}/g' *

cd
cat >> wsgi.conf <<EOM

# $2
   
Alias /$2_project_static ${PWD}/$2/static_root

WSGIDaemonProcess $2_wsgi python-path=${PWD}/$2:${PWD}/venv/lib/python2.6/site-packages user=app_pahma group=app_pahma
WSGIProcessGroup $2_wsgi

WSGIScriptAlias /$2 ${PWD}/$2/cspace_django_site/wsgi.py process-group=$2_wsgi

<Directory "${PWD}/$2">
    Order deny,allow
    Allow from all
</Directory>

EOM
