if [ $# -ne 2 ]; then
    echo
    echo "================================================================================================="
    echo Usage: deployProject.sh install_dir github_branch
    echo
    echo "e.g. sudo ./deployProject.sh pahmaNV pahma_4.0-1 > install.log 2>&1"
    echo
    echo "this will update the code in /var/www/pahmaNV with code from branch pahma_4.0-1 of the deployed"
    echo "repo in github.com. It does NOT restart Apache, which is required to pick up the change."
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
git checkout $2
git pull origin $2 -v
git branch
python manage.py collectstatic --noinput
git stash apply
echo
echo "don't forget to restart Apache!"
