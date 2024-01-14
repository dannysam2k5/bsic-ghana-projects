--==================================================
-- Storage Migration for Amplitude E-Banking Server
-- Authour: Daniel Sam aka Cold-Fire
-- Date: 12-Apr-2019
--==================================================

--Purpose: To Migrate /usr on /dev/mapper/vg_prdghaweb-lv_root  to /usr on /dev/mapper/vg_prdghaweb-lv_home


1. backup files in /home

2. unmount the home directory /home
	$ umount /home
	
3. Create new home directory /home on /dev/mapper/vg_prdghaweb-lv_root
	$ mkdir /home
	
3. rename /usr to /usr2
	$ mv /usr /usr2
	
4. create directory /usr on /dev/mapper/vg_prdghaweb-lv_root
	$ mkdir /usr
	
5. Edit fstab and map /usr to mapper/vg_prdghaweb-lv_home

6. Copy all folders & files from /usr2 to /usr

	$ cp -vrp /usr2 /usr
	
7. Verify all components are working correctly.

8. Delete the /usr2 after all confirmation -- preferable after a week


