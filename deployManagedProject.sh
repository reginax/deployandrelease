# if [ $# -ne 3 ]; then
#     echo
#     echo "================================================================================================="
#     echo Usage: deployProject.sh install_dir github_remote github_branch
#     echo
#     echo "e.g. sudo ./deployProject.sh pahmaNV origin pahma_4.0-1 > install.log 2>&1"
#     echo
#     echo "this will update the code in /var/www/pahmaNV with code from branch pahma_4.0-1 of the "
#     echo "remote named 'origin' in github.com. "
#     echo "It does NOT restart Apache, which is required to pick up the change."
#     echo "================================================================================================="
#     exit
# fi

if [ $# -ne 4 ]; then
    echo
    echo "================================================================================================="
    echo Usage: deployManagedProject.sh install_dir github_remote github_branch server
    echo
    echo "e.g. sudo ./deployManagedProject.sh pahma origin master dev"
    echo
    echo "this will copy the code for prod or dev deployment to extra_settings.py"
    echo "It does NOT restart Apache, which is required to pick up the change."
    echo "================================================================================================="
    exit
fi

if [ ! -d  "/var/www/$1" ]; then
    echo "================================================================================================="
    echo "/var/www/$1 does't exist! Please install it using installProject.sh"
    echo "================================================================================================="
    exit
fi

cd /var/www/$1/
# we stash just in case, but we never apply
git stash
git checkout $2/$3
git pull $2 $3 -v
cp cspace_django_site/extra_$4.py cspace_django_site/extra_settings.py
git branch
python manage.py syncdb
python manage.py collectstatic --noinput
python manage.py loaddata fixtures/*
#git stash apply
echo
echo "don't forget to restart Apache!"
