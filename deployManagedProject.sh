if [ $# -ne 3 ]; then
    echo
    echo "================================================================================================="
    echo Usage: deployProject.sh install_dir github_remote github_branch
    echo
    echo "e.g. sudo ./deployProject.sh pahmaNV origin pahma_4.0-1 > install.log 2>&1"
    echo
    echo "this will update the code in /var/www/pahmaNV with code from branch pahma_4.0-1 of the "
    echo "remote named 'origin' in github.com. "
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
git stash
git checkout $2/$3
git pull $2 $3 -v
git branch
python manage.py syncdb
python manage.py collectstatic --noinput
#git stash apply
echo
echo "don't forget to restart Apache!"
