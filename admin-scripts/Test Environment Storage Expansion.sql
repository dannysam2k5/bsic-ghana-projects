-- Test Environment Storage Expansion
=====================================

-- Partition sdd hard disk (400gb) and format.

$ fdisk /dev/sdd

$ mkfs.ext4 /dev/sdd1

$ mkdir /datadir1

- fstab


-- Move the datafiles to the new location 
==========================================

DATADBS		/bases/oradata/db12utf8/DATADBS02.dbf
DATADBS		/bases/oradata/db12utf8/DATADBS03.dbf
DATADBS		/bases/oradata/db12utf8/DATADBS04.dbf
DATADBS		/datadir/dbfiles/DATADBS07.dbf
DATADBS		/datadir/dbfiles/DATADBS08.dbf
DATADBS		/datadir/dbfiles/DATADBS09.dbf
DATADBS		/bases/oradata/db12utf8/DATADBS10.dbf


-- Perform COLD backup of datafiles
====================================
SQL> shutdown immediate;

move all the datafiles to the new location /datadir1/dbfiles/


mv  /bases/oradata/db12utf8/DATADBS02.dbf /datadir1/dbfiles/DATADBS02.dbf
mv  /bases/oradata/db12utf8/DATADBS03.dbf /datadir1/dbfiles/DATADBS03.dbf
mv  /bases/oradata/db12utf8/DATADBS04.dbf /datadir1/dbfiles/DATADBS04.dbf
mv  /datadir/dbfiles/DATADBS07.dbf /datadir1/dbfiles/DATADBS07.dbf
mv  /datadir/dbfiles/DATADBS08.dbf /datadir1/dbfiles/DATADBS08.dbf
mv  /datadir/dbfiles/DATADBS09.dbf /datadir1/dbfiles/DATADBS09.dbf
mv  /bases/oradata/db12utf8/DATADBS10.dbf /datadir1/dbfiles/DATADBS10.dbf

-- Use the rename operation to change the location of the datafiles.

-- mount the databaase

SQL> startup mount;


SQL>

ALTER DATABASE RENAME FILE  '/bases/oradata/db12utf8/DATADBS02.dbf' TO '/datadir1/dbfiles/DATADBS02.dbf';
ALTER DATABASE RENAME FILE  '/bases/oradata/db12utf8/DATADBS03.dbf' TO '/datadir1/dbfiles/DATADBS03.dbf';
ALTER DATABASE RENAME FILE  '/bases/oradata/db12utf8/DATADBS04.dbf' TO '/datadir1/dbfiles/DATADBS04.dbf';
ALTER DATABASE RENAME FILE  '/datadir/dbfiles/DATADBS07.dbf' TO '/datadir1/dbfiles/DATADBS07.dbf';
ALTER DATABASE RENAME FILE  '/datadir/dbfiles/DATADBS08.dbf' TO '/datadir1/dbfiles/DATADBS08.dbf';
ALTER DATABASE RENAME FILE  '/datadir/dbfiles/DATADBS09.dbf' TO '/datadir1/dbfiles/DATADBS09.dbf';
ALTER DATABASE RENAME FILE  '/bases/oradata/db12utf8/DATADBS10.dbf' TO '/datadir1/dbfiles/DATADBS10.dbf';

SQL> alter database open;


-- Extend the DataFiles 

SQL> 
alter database datafile '' resize 30g;

alter database datafile  '/datadir1/dbfiles/DATADBS07.dbf' resize 30g;
alter database datafile  '/datadir1/dbfiles/DATADBS08.dbf' resize 30g;

--
alter database datafile  '/datadir1/dbfiles/DATADBS09.dbf' resize 30g;
alter database datafile  '/datadir1/dbfiles/DATADBS10.dbf' resize 30g;








