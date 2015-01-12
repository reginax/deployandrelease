
if [ $# -ne 3 ]; then
    echo
    echo "================================================================================================="
    echo Usage: installProject.sh institution install_dir github_branch
    echo
    echo "e.g. sudo ./installProject.sh pahma pahmaNV pahma_4.0-1 > install.log 2>&1"
    echo
    echo "this will install pahma_project branch pahma_4.0-1 from github.com/cspace-deployment"
    echo "into /usr/local/share/django/pahmaNV_project and configure it to run, except for Apache conf.d"
    echo "================================================================================================="
    exit
fi

if [ -e "/usr/local/share/django/$2_project" ]; then
    echo "================================================================================================="
    echo "/usr/local/share/django/$2_project already exists. Please remove it and retry."
    echo "================================================================================================="
    exit
fi

cd /usr/local/share/django/

git clone https://github.com/cspace-deployment/$1_project $2_project

chmod -R g+w $2_project/
chown -R apache:apache $2_project
chcon -t httpd_sys_rw_content_t $2_project/
 
cd $2_project/
git pull origin $3 -v
git checkout $3

python manage.py syncdb --noinput 
python manage.py collectstatic --noinput

chmod g+w db.sqlite3
chown apache:apache db.sqlite3
chcon -t httpd_sys_rw_content_t db.sqlite3

chown -R apache:apache static_root
chcon -t httpd_sys_rw_content_t static_root
chown -R apache:apache static_root/*
chcon -t httpd_sys_rw_content_t static_root/*

chown -R apache:apache logs
chown apache:apache logs/*
chmod g+w logs
chmod g+w logs/*
chcon -t httpd_sys_rw_content_t logs
chcon -t httpd_sys_rw_content_t logs/*

cp */*.cfg config/

echo vi /etc/httpd/conf.d/django.conf
echo
echo add the following lines, and restart Apache
echo
echo    Alias /$2_project_static/ /usr/local/share/django/$2_project/static_root/
echo 
echo    WSGIDaemonProcess $2_project_wsgi user=apache group=apache
echo    WSGIScriptAlias /$2_project /usr/local/share/django/$2_project/cspace_django_site/wsgi.py
echo    "<Location /$2_project>"
echo      WSGIProcessGroup $2_project_wsgi
echo    "</Location>"
#
echo
echo  and you may need to customize the following for this deployment:
echo
echo  vi config/*.cfg
echo  cd cspace_django_site/
echo  vi wsgi.py 
echo  vi settings.py
echo  vi main.cfg 
echo
echo  "Don't forget to restart Apache:"
echo
echo  service httpd graceful

