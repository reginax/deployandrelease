# mostly untested!
set -e
if [ $# -lt 3 ]; then
  echo 1>&2 ""
  echo 1>&2 "call with three arguments:"
  echo 1>&2 "$0 toolsdir solr4dir solrversion"
  echo 1>&2 ""
  echo 1>&2 "e.g."
  echo 1>&2 "$0  ~/Tools solr4 solr-4.10.3"
  echo 1>&2 ""
  echo 1>&2 ""
  echo 1>&2 "- path to Tool git repo"
  echo 1>&2 "- directory to create with all Solr goodies in it"
  echo 1>&2 "- solr4 download"
  echo 1>&2 "(toolsdir and solrversion.tgz must exist; solr4dir must not)"
  echo 1>&2 ""
  exit 2
fi
TOOLS=$1
SOLR4=$2
TAR=$3
if [ ! -d $TOOLS ];
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

#perl -i -pe 's/example-schemaless/pahma-metadata/' pahma/metadata/conf/schema.xml
#perl -i -pe 's/example-schemaless/botgarden-metadata/' botgarden/metadata/conf/schema.xml
#perl -i -pe 's/example-schemaless/botgarden-propagations/' botgarden/propagations/conf/schema.xml
#perl -i -pe 's/example-schemaless/ucjeps-metadata/' ucjeps/metadata/conf/schema.xml
#perl -i -pe 's/example-schemaless/cinefiles-metadata/' cinefiles/metadata/conf/schema.xml
#perl -i -pe 's/example-schemaless/bampfa-metadata/' bampfa/metadata/conf/schema.xml

cp $TOOLS/datasources/ucb/multicore/botgarden/metadata/conf/solrconfig.xml botgarden/metadata/conf/
cp $TOOLS/datasources/ucb/multicore/cinefiles/metadata/conf/solrconfig.xml cinefiles/metadata/conf/
cp $TOOLS/datasources/ucb/multicore/bampfa/metadata/conf/solrconfig.xml bampfa/metadata/conf/
cp $TOOLS/datasources/ucb/multicore/pahma/metadata/conf/solrconfig.xml pahma/metadata/conf/
cp $TOOLS/datasources/ucb/multicore/botgarden/propagations/conf/solrconfig.xml botgarden/propagations/conf/
cp $TOOLS/datasources/ucb/multicore/ucjeps/metadata/conf/solrconfig.xml ucjeps/metadata/conf/

cp $TOOLS/datasources/ucb/multicore/botgarden/metadata/conf/schema.xml botgarden/metadata/conf/
cp $TOOLS/datasources/ucb/multicore/cinefiles/metadata/conf/schema.xml cinefiles/metadata/conf/
cp $TOOLS/datasources/ucb/multicore/bampfa/metadata/conf/schema.xml bampfa/metadata/conf/
cp $TOOLS/datasources/ucb/multicore/pahma/metadata/conf/schema.xml pahma/metadata/conf/
cp $TOOLS/datasources/ucb/multicore/botgarden/propagations/conf/schema.xml botgarden/propagations/conf/
cp $TOOLS/datasources/ucb/multicore/ucjeps/metadata/conf/schema.xml ucjeps/metadata/conf/
