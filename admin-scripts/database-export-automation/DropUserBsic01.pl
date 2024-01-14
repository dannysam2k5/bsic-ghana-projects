#SCRIPT:	DropUserBsic01.pl
#AUTHOR:	Daniel Sam
#DATE:		16-March-2016
#REV:		1.1.P
#PLATFORM:	CENTOS 5.3
#
#PURPOSE:	Drop BSIC01 schema database for TestAmpDataExport.sh
#
#######################################################
ORACLE_HOME=/appli/oracle/11.2.0.3
OPATH="$ORACLE_HOME/bin"
ORACLE_SID=db11p15

export ORACLE_HOME OPATH ORACLE_SID

# set username
SUSER="system"
# set password
SPASS="oracle"
#

 $OPATH/sqlplus -s /nolog <<EOF
 connect $SUSER/$SPASS
 drop user test cascade;
 quit
 EOF
 