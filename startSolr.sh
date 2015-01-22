if [ -d start.jar ];
then
   echo start.jar must be in the directory where you run this script!
   exit 1
fi
if [ -d nohup.out ];
then
   rm nohup.out
fi
# start solr and run it in the background...
nohup java -Dsolr.solr.home=multicore -Xmx512m -jar start.jar &

