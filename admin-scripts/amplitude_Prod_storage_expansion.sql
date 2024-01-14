-- Amplitude Storage Expansion
===============================
-- Check All available spaces on all diskgroups <refer to DB monitor script folder>

============
-- amplibk
============
1. Enable RMAN backup (banking application) -- cold backup


-- configure automatic backups of the control file & SPFILE

RMAN> configure controlfile autobackup on;

-- Backup controlfile

SQL> alter database backup controlfile to '/backup/amplibk/controlfile_backup/control.bkp';

-- Perform the cold backup of amplibk


$ rman target /

RMAN> shutdown immediate;
RMAN> startup mount;
RMAN> backup database;
RMAN> sql 'alter database open';

-- verify the backups
RMAN> list backup summary;

============
--amplisig
============
-- change db_recovery_file_dest_size size to 150 GB

SQL> alter system set db_recovery_file_dest_size = 150G;

-- Perform the cold backup of amplisig


$ rman target /

RMAN> shutdown immediate;
RMAN> startup mount;
RMAN> backup database;
RMAN> sql 'alter database open';

-- verify the backups
RMAN> list backup summary;



2. Add 200GB HDD each and prepare ASM disk (DATA02 & DATA03) for External

login with grid user
$ . oraenv (+ASM)

-- Partition the HDD : sdh sdi

-- Create the asm disk (DATA02)
$ oracleasm createdisk DATA02 /dev/sdh1
$ oracleasm createdisk DATA03 /dev/sdi1

Verify the created disk.

column path format a20
set lines 132
set pages 50
select path, group_number group_#, disk_number disk_#, mount_status,
header_status, state, total_mb, free_mb
from v$asm_disk
order by group_number;



3. Add the disk to the diskgroup DATA :- sdh sdi

SQL> ALTER DISKGROUP DATA ADD DISK
  '/dev/oracleasm/disks/DATA02',
  '/dev/oracleasm/disks/DATA03';
  

4. Expand the Tablespaces for both the banking application and Signature.
Identify all datafiles to be expanded and fix.

+DATA/AMPLIBK/DATAFILE/datadbs.284.987520175	: from 5g to 30gb


+DATA/AMPLIBK/DATAFILE/geddbs.283.987519345     : from 5g to 30gb




SQL> alter database datafile '+DATA/AMPLIBK/DATAFILE/datadbs.284.987520175' resize 30g;


-- Add 30gb datafile DATADBS

SQL> alter tablespace DATADBS add datafile '+DATA' size 30g; -- To be done




SQL> alter database datafile '+DATA/AMPLIBK/DATAFILE/geddbs.283.987519345' resize 30g;


-- Add 30gb datafile GEDDBS

SQL> alter tablespace GEDDBS  add datafile '+DATA' size 30g; -- To be done







============================================
Error Resolution : Diskgroup space exhausted
=============================================

ORA-15041 “Diskgroup space exhausted” after adding disk


-- Check for rebalancing of disk

column path format a20
set lines 132
set pages 50
select path, group_number group_#, disk_number disk_#, mount_status,
header_status, state, total_mb, free_mb
from v$asm_disk 
where group_number = 1
order by group_number;






