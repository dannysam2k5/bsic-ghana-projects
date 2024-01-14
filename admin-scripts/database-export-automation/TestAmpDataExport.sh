#SCRIPT:	TestAmpDataExport.sh
#AUTHOR:	Daniel Sam
#DATE:		16-March-2016
#REV:		1.1.P
#PLATFORM:	CENTOS 5.3
#
#PURPOSE:	Exports BSIC01 schema database from Test Environment periodically
#
#######################################################
#                                                     #
#######################################################
#
# Set ORACLE environment variable here
# ORACLE_HOME - ora_environment
# ORACLE_SID - Your Oracle System Identifier

 #ORACLE_BASE=/appli/oracle/
 #ORACLE_HOME=$ORACLE_BASE/11.2.0.3
 #ORACLE_SID=db11p15
 #export ORACLE_BASE ORACLE_HOME ORACLE_SID

 #Delete obsolete BSIC01 dump backup and export log
 rm -rf /xch/_bases/bsic01_*.dmp.bz2
 rm -rf /xch/_bases/bsic01_exp_*.log
 
 #Export the BSIC01 schema
 ORACLE_HOME=/appli/oracle/11.2.0.3
 export ORACLE_SID=db11p15
 $ORACLE_HOME/bin/expdp parfile=/xch/_bases/ExportParam.dat

 #Rename the export dump and log appending current date to dump
 FILEDATE=$(date +%Y%m%d)
 mv /xch/_bases/bsic01dump.dmp /xch/_bases/bsic01_$FILEDATE.dmp
 mv /xch/_bases/bsic_export.log /xch/_bases/bsic01_exp_$FILEDATE.log
 
 #Compress the export dump file
 bzip2 /xch/_bases/bsic01_$FILEDATE.dmp
 
 # Remote copy compressed export dump to test backup server (10.16.6.235)
 ssh testbackup "find /xch/_bases/ -name bsic01*.dmp -exec rm -rf {} \;"
 scp /xch/_bases/bsic01_$FILEDATE.dmp.bz2 oracle@testbackup:/xch/_bases/

# Remote Extraction of export dump
ssh testbackup 'export FILEDATE=$(date +%Y%m%d);  bunzip2 /xch/_bases/bsic01_$FILEDATE.dmp.bz2' 
 
 #Rename extracted dump for usage by Parameter File
 ssh testbackup 'export FILEDATE=$(date +%Y%m%d); mv /xch/_bases/bsic01_$FILEDATE.dmp /xch/_bases/bsic01dump.dmp'
 
 # Drop BSIC01 schema from test backup server
ssh testbackup 'export ORACLE_HOME=/appli/oracle/11.2.0.3;
export OPATH=$ORACLE_HOME/bin;
export ORACLE_SID=db11p15;
$OPATH/sqlplus -s /nolog <<EOF
connect system/oracle
drop user BSIC01 cascade;
quit
EOF'
 
 # Import the BSIC01 schema into the test backup server
 ssh testbackup 'export ORACLE_HOME=/appli/oracle/11.2.0.3;
 export OPATH=$ORACLE_HOME/bin;
 export ORACLE_SID=db11p15;
 $OPATH/impdp parfile=/xch/_bases/ImportParam.dat'

 
