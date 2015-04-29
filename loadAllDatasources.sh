#
#
# curl commands to reload all the solr datasources
# (these clean out the cores and reload them)
#
# if you:
#
# 1. Install Solr
#
# ./installSolr.py
#
# 2. configure the Solr multicore deployment using configureMultiCoreSolr.sh 
#
# ./configureMultiCoreSolr.sh
# 
# 3. download all the current nightly dumps from dev.cspace
#
# ./scp4solr.py
#
# gunzip *.gz
#
# 4 execute this script
#
# ./loadAllDatasourcees.sh
#
# ...you have all the cores installed and running.
#
# Notes:
# 
# * you can repeat steps 2-4 at will, to update your data; note that you may have to update
#   solr schema and restart solr if there have been changes to the schema.)
#
# * you can also get the same effect by running each of the ETL scripts in Tools/datasources 
#   to execute the sql and data munging that is done nightly on dev.cspace.
#
curl http://localhost:8983/solr/ucjeps-metadata/update --data '<delete><query>*:*</query></delete>' -H 'Content-type:text/xml; charset=utf-8'
curl http://localhost:8983/solr/ucjeps-metadata/update --data '<commit/>' -H 'Content-type:text/xml; charset=utf-8'
curl 'http://localhost:8983/solr/ucjeps-metadata/update/csv?commit=true&header=true&trim=true&separator=%09&f.collector_ss.split=true&f.collector_ss.separator=%7C&f.previousdeterminations_ss.split=true&f.previousdeterminations_ss.separator=%7C&f.otherlocalities_ss.split=true&f.otherlocalities_ss.separator=%7C&f.associatedtaxa_ss.split=true&f.associatedtaxa_ss.separator=%7C&f.typeassertions_ss.split=true&f.typeassertions_ss.separator=%7C&f.othernumber_ss.split=true&f.othernumber_ss.separator=%7C&f.blobs_ss.split=true&f.blobs_ss.separator=,&encapsulator=\' --data-binary @4solr.ucjeps.metadata.csv -H 'Content-type:text/plain; charset=utf-8'
#
curl http://localhost:8983/solr/pahma-metadata/update --data '<delete><query>*:*</query></delete>' -H 'Content-type:text/xml; charset=utf-8'
curl http://localhost:8983/solr/pahma-metadata/update --data '<commit/>' -H 'Content-type:text/xml; charset=utf-8'
curl 'http://localhost:8983/solr/pahma-metadata/update/csv?commit=true&header=true&separator=%09&f.objaltnum_ss.split=true&f.objaltnum_ss.separator=%7C&f.objfilecode_ss.split=true&f.objfilecode_ss.separator=%7C&f.objdimensions_ss.split=true&f.objdimensions_ss.separator=%7C&f.objmaterials_ss.split=true&f.objmaterials_ss.separator=%7C&f.objinscrtext_ss.split=true&f.objinscrtext_ss.separator=%7C&f.objcollector_ss.split=true&f.objcollector_ss.separator=%7C&f.objaccno_ss.split=true&f.objaccno_ss.separator=%7C&f.objaccdate_ss.split=true&f.objaccdate_ss.separator=%7C&f.objacqdate_ss.split=true&f.objacqdate_ss.separator=%7C&f.objassoccult_ss.split=true&f.objassoccult_ss.separator=%7C&f.objculturetree_ss.split=true&f.objculturetree_ss.separator=%7C&f.blob_ss.split=true&f.blob_ss.separator=,&encapsulator=\' --data-binary @4solr.pahma.metadata.csv -H 'Content-type:text/plain; charset=utf-8'
#
curl http://localhost:8983/solr/botgarden-propagations/update --data '<delete><query>*:*</query></delete>' -H 'Content-type:text/xml; charset=utf-8'
curl http://localhost:8983/solr/botgarden-propagations/update --data '<commit/>' -H 'Content-type:text/xml; charset=utf-8'
curl 'http://localhost:8983/solr/botgarden-propagations/update/csv?commit=true&header=true&trim=true&separator=%09&encapsulator=\' --data-binary @4solr.botgarden.propagations.csv -H 'Content-type:text/plain; charset=utf-8'
#
curl http://localhost:8983/solr/botgarden-metadata/update --data '<delete><query>*:*</query></delete>' -H 'Content-type:text/xml; charset=utf-8'
curl http://localhost:8983/solr/botgarden-metadata/update --data '<commit/>' -H 'Content-type:text/xml; charset=utf-8'
curl 'http://localhost:8983/solr/botgarden-metadata/update/csv?commit=true&header=true&trim=true&separator=%09&f.collcounty_ss.split=true&f.collcounty_ss.separator=%7C&f.collstate_ss.split=true&f.collstate_ss.separator=%7C&f.collcountry_ss.split=true&f.collcountry_ss.separator=%7C&f.conservationinfo_ss.split=true&f.conservationinfo_ss.separator=%7C&f.conserveorg_ss.split=true&f.conserveorg_ss.separator=%7C&f.conservecat_ss.split=true&f.conservecat_ss.separator=%7C&f.voucherlist_ss.split=true&f.voucherlist_ss.separator=%7C&f.blobs_ss.split=true&f.blobs_ss.separator=,&encapsulator=\' --data-binary @4solr.botgarden.metadata.csv -H 'Content-type:text/plain; charset=utf-8'
#
curl http://localhost:8983/solr/bampfa-metadata/update --data '<delete><query>*:*</query></delete>' -H 'Content-type:text/xml; charset=utf-8'
curl http://localhost:8983/solr/bampfa-metadata/update --data '<commit/>' -H 'Content-type:text/xml; charset=utf-8'
curl 'http://localhost:8983/solr/bampfa-metadata/update/csv?commit=true&header=true&trim=true&separator=%7C&f.othernumbers_ss.split=true&f.othernumbers_ss.separator=;&f.blob_ss.split=true&f.blob_ss.separator=,&encapsulator=\' --data-binary @4solr.bampfa.metadata.csv -H 'Content-type:text/plain; charset=utf-8'

