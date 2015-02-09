#!/bin/bash -x
# scps all the csv files for the UCB Solr4 deployments
# run this before you run loadAllDatasourcees.sh
scp dev.cspace.berkeley.edu:/home/developers/*/4solr*.gz .
gunzip 4solr*.gz
