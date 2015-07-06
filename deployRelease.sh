if [ $# -ne 2 ]; then
    echo
    echo "================================================================================================="
    echo Usage: deployProject.sh install_dir tag
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
# cd ~/PyCharmProjects/$1_project/
# git stash
# git pull origin $2 -v

found_tag=0
while read i; do
    if [ "$i" == "$2" ]; then
        found_tag=1
        break
    fi
done < <(git tag -l)

if [ "$found_tag" -eq "1" ]; then
    git checkout tags/$2
    python manage.py syncdb --noinput
    python manage.py collectstatic --noinput
else 
    echo "================================================================================================="
    echo "Tag $2 does not exist"
    echo "================================================================================================="
fi
# git stash apply
echo
echo "don't forget to restart Apache!"
