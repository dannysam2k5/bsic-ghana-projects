/*
# Script Name: sp_User_Access_File
# Description: Used to generate users access file from AMPLITUDE database
# Author Name: Daniel Sam
# Date: 31-Jul-2017
*/



SQL> CREATE DIRECTORY UTL_DIR AS '/home/oracle/UserAccessAudit';
SQL> GRANT READ, WRITE ON DIRECTORY UTL_DIR TO PRDGHAAMP;



CREATE OR REPLACE PROCEDURE sp_User_Access_File
AS

	user_file utl_file.file_type;
	file_name VARCHAR2(500);

			
	v_branchID bkage.age%TYPE;
	
	
	CURSOR branch_cur IS (SELECT age, lib FROM bkage);
		branch_rec branch_cur%ROWTYPE;
	
	CURSOR user_access_cur IS (SELECT
						a.cuti userid
						,a.lib user_name
                        ,a.puti a_id
						,b.lib1 a_level
				from evuti a, bknom b
					where a.puti=b.cacc
					and b.ctab='994'
					and substr(a.cuti,1,2) like 'GH%'
					and a.age = v_branchID);
	
	user_access_rec user_access_cur%ROWTYPE;
	
	v_text VARCHAR2(500);
	
BEGIN
	
		
	-- Fetch all branches from database
	OPEN branch_cur;
		LOOP
			FETCH branch_cur INTO branch_rec;
			EXIT WHEN branch_cur%NOTFOUND;
			
	
		file_name := branch_rec.age||'_'||trim(branch_rec.lib)||'.txt';
		
		-- Open file
		user_file := UTL_FILE.FOPEN('UTL_DIR',file_name,'W',32767);
	
		v_branchID := branch_rec.age;
	
	-- Fetch all user access for respective branches	
	OPEN user_access_cur;
		LOOP
			FETCH user_access_cur INTO user_access_rec;
			EXIT WHEN user_access_cur%NOTFOUND;
			v_text := RPAD(user_access_rec.userid,15,' ')||LPAD(user_access_rec.user_name,30,' ')||LPAD(user_access_rec.a_id,6,' ')||LPAD(user_access_rec.a_level,30,' ');
			
		-- Write to file
		UTL_FILE.PUT_LINE(user_file,v_text);
		
		END LOOP;

	CLOSE user_access_cur;
	
	-- Close file
		UTL_FILE.FCLOSE(user_file);		
		
		END LOOP;
		

	CLOSE branch_cur;

END;
/


-- Run The Stored Procedure to Generate the Files
EXEC sp_User_Access_File ();