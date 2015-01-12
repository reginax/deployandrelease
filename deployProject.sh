if [ $# -ne 2 ]; then
    echo
    echo "================================================================================================="
    echo Usage: deployProject.sh install_dir github_branch
    echo
    echo "e.g. sudo ./deployProject.sh pahmaNV pahma_4.0-1 > install.log 2>&1"
    echo
    echo "this will deploy the code in pahma_project branch pahma_4.0-1 from github.com/cspace-deployment"
    echo "into /usr/local/share/django/pahmaNV_project, and gracefully restart Apache"
    echo "================================================================================================="
    exit
fi

if [ ! -d  "/usr/local/share/django/$1_project" ]; then
    echo "================================================================================================="
    echo "/usr/local/share/django/$1_project does't exist! Please install it using installProject.sh"
    echo "================================================================================================="
    exit
fi

cd /usr/local/share/django/$1_project/
git stash
git checkout $2
git pull origin $2 -v
git branch
python manage.py collectstatic --noinput
git stash apply
service httpd graceful
