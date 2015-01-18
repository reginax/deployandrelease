# mostly untested!
set -e
if [ $# -lt 3 ]; then
  echo 1>&2 "$0: call with three arguments:"
  echo 1>&2 "$0 toolsdir solr4dir solrversion"
  echo 1>&2 "$0 e.g."
  echo 1>&2 "$0 ~/Tools solr4 solr-4.10.3"
  echo 1>&2 "(toolsdir and solrversion.tgz must exist; solr4dir must not)"
  exit 2
fi
TOOLS=$1
SOLR4=$2
TAR=$3
if [ ! -d $TOOLS];
then
   echo "Tools directory $TOOLS not found. Please clone from GitHub and provide it as the first argument."
   exit 1
fi
if [ -d $SOLR4 ];
then
   echo "$SOLR4 directory exists, please remove (e.g. rm -rf solr4/), then try again."
   exit 1
fi
if [ ! -e $SOLRTAR ];
then
   echo "$SOLR4 directory exists, please remove (e.g. rm -rf solr4/), then try again."
   exit 1
fi
tar xzf $TAR.tgz
mv $TAR $SOLR4
cd $SOLR4
mv example ucb

cd ucb/multicore/

rm -rf core0/
rm -rf core1/
rm -rf examplecdocs/

mkdir pahma
mkdir botgarden
mkdir ucjeps
mkdir cinefiles
mkdir bampfa

cp -r ../example-schemaless/solr/collection1 pahma/metadata
cp -r ../example-schemaless/solr/collection1 botgarden/metadata
cp -r ../example-schemaless/solr/collection1 botgarden/propagations
cp -r ../example-schemaless/solr/collection1 ucjeps/metadata
cp -r ../example-schemaless/solr/collection1 cinefiles/metadata
cp -r ../example-schemaless/solr/collection1 bampfa/metadata

#cp -r ../example-DIH/solr/solr pahma/metadata
#cp -r ../example-DIH/solr/solr botgarden/metadata
#cp -r ../example-DIH/solr/solr botgarden/propagations
#cp -r ../example-DIH/solr/solr ucjeps/metadata
#cp -r ../example-DIH/solr/solr cinefiles/metadata
#cp -r ../example-DIH/solr/solr bampfa/metadata

cp $TOOLS/datasources/ucb/multicore/solr.xml .
perl -i -pe 's/collection1/pahma-metadata/' pahma/metadata/core.properties
perl -i -pe 's/collection1/botgarden-metadata/' botgarden/metadata/core.properties
perl -i -pe 's/collection1/botgarden-propations/' botgarden/propagations/core.properties
perl -i -pe 's/collection1/ucjeps-metadata/' ucjeps/metadata/core.properties
perl -i -pe 's/collection1/cinefiles-metadata/' cinefiles/metadata/core.properties
perl -i -pe 's/collection1/bampfa-metadata/' bampfa/metadata/core.properties

perl -i -pe 's/example-schemaless/pahma-metadata/' pahma/metadata/conf/schema.xml
perl -i -pe 's/example-schemaless/botgarden-metadata/' botgarden/metadata/conf/schema.xml
perl -i -pe 's/example-schemaless/botgarden-propations/' botgarden/propagations/conf/schema.xml
perl -i -pe 's/example-schemaless/ucjeps-metadata/' ucjeps/metadata/conf/schema.xml
perl -i -pe 's/example-schemaless/cinefiles-metadata/' cinefiles/metadata/conf/schema.xml
perl -i -pe 's/example-schemaless/bampfa-metadata/' bampfa/metadata/conf/schema.xml

cp  ~/solrconfig.xml pahma/metadata/conf
cp  ~/solrconfig.xml botgarden/metadata/conf
cp  ~/solrconfig.xml botgarden/propagations/conf
cp  ~/solrconfig.xml ucjeps/metadata/conf
cp  ~/solrconfig.xml cinefiles/metadata/conf
cp  ~/solrconfig.xml bampfa/metadata

