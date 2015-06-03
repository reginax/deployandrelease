#for t in bampfa botgarden pahma ucjeps
for t in bampfa botgarden ucjeps
do
   echo "============================================================================"
   echo "$t"
   cd
   ./deployandrelease/installManagedProject.sh ${t} ${t} master >> install.log 2>&1
   #git clone https://github.com/cspace-deployment/${t}.git ${t}
   #cp ${t}/*/*.cfg ${t}/config
   #cp ${t}/*/*.csv ${t}/config
   #cd ${t}/config
   #rm authn.cfg main.cfg
   #perl -i -pe 's/${t}_project/${t}/g' *
done
