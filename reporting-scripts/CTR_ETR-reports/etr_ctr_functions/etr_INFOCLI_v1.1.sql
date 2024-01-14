create or replace function infocli
(eve_code char,
dat_hist date,
inf char,
flag char,
nat_tran char)
return char as resultat char(100) :='';

cli_dest char(50);
cli_src char(50);
ncp_dest char(50);
ncp_src char(50);
v_dev char(50);
t_cli char(1);
nation char(100);
resid char(100);
num_tel char(100);
num_tel_v char(100);
num_tel_v2 char(100);
id_typ char(100);
iss_date char(100);
exp_date char(100);
iss_by char(100);
iss_ct char(100);
var_1 char(100);
var_2  char(100);
bd_date char(100) ;
v_tcli_dest char(100) ;
v_tcli_src char(100) ;
v_nump char(100) ;
v_tdir_dest char(100);
v_tdir_src char(100);
v_cli_src char(50);
v_cli_dest char(50);
v_count number;
v_age char(50);
v_nomb char(100);
v_comb char(50);
v_branch char(50);
v_age1 char(50);
v_dev1 char(50);
v_age2 char(50);
v_dev2 char(50);



begin



case when eve_code = '000818' THEN 
select trim(cli1) into v_cli_src from bkheve where eve = eve_code and dateh = dat_hist  and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') AND OPE ='446'
union all
select ' ' from dual where not exists (select trim(cli1)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') AND OPE ='446');
else 
select trim(cli1) into v_cli_src from bkheve where eve = eve_code and dateh = dat_hist  and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') 
union all
select ' ' from dual where not exists (select trim(cli1)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') );
end case ;
CASE when trim(v_cli_src) is null then 
   case when eve_code = '000818' THEN
    select trim(cli) into v_cli_src from bkcom where ncp||age||dev = (select ncp1||age1||dev1 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and ope ='446' )
    union all
    select ' ' from dual where not exists (select trim(cli) from bkcom where ncp||age||dev = (select ncp1||age1||dev1 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and ope ='446' ));
   else
    select trim(cli) into v_cli_src from bkcom where ncp||age||dev = (select ncp1||age1||dev1 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran)
    union all
    select ' ' from dual where not exists (select trim(cli) from bkcom where ncp||age||dev = (select ncp1||age1||dev1 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran));
   end case ;
else cli_src := v_cli_src;
end case;
if cli_src = ' ' then cli_src := null; end if;
case when eve_code = '000818' THEN 
select trim(cli2) into v_cli_dest from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and(select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') AND OPE ='446'
union all
select ' ' from dual where not exists (select trim(cli2) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and(select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') AND OPE ='446');
else  
select trim(cli2) into v_cli_dest from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and(select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')
union all
select ' ' from dual where not exists (select trim(cli2) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and(select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100'));
end case ;
CASE when trim(v_cli_dest) is null then 
   case when eve_code = '000818' THEN
       select trim(cli) into v_cli_dest from bkcom where ncp||age||dev = (select ncp2||age2||dev2 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and ope ='446')
        union all
       select ' ' from dual where not exists (select trim(cli) from bkcom where ncp||age||dev = (select ncp2||age2||dev2 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and ope ='446'));

   else
       select trim(cli) into v_cli_dest from bkcom where ncp||age||dev = (select ncp2||age2||dev2 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran)
        union all
        select ' ' from dual where not exists (select trim(cli) from bkcom where ncp||age||dev = (select ncp2||age2||dev2 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran));

   end case ;
else cli_dest := v_cli_dest;
end case;
case when eve_code = '000818' THEN 
select DISTINCT trim(ncp1) into ncp_src from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran  and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') AND OPE ='446'
UNION ALL 
SELECT ' ' from dual where not exists (select DISTINCT trim(ncp1)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran  and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')AND OPE ='446');

else 
select DISTINCT trim(ncp1) into ncp_src from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran  and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') 
UNION ALL 
SELECT ' ' from dual where not exists (select DISTINCT trim(ncp1)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran  and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100'));
end case ;

case when eve_code = '000818' THEN 
select DISTINCT trim(age1) into v_age1 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') AND OPE ='446'
union all
select ' ' from dual where not exists (select DISTINCT trim(age1) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') AND OPE ='446'); 

else 
select DISTINCT trim(age1) into v_age1 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')
union all
select ' ' from dual where not exists (select DISTINCT trim(age1) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')); 
end case ;

case when eve_code = '000818' THEN 
select DISTINCT trim(dev1) into v_dev1 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') AND OPE ='446'
union all
select ' ' from dual where not exists (select DISTINCT trim(dev1) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') AND OPE ='446');

else 
select DISTINCT trim(dev1) into v_dev1 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')
union all
select ' ' from dual where not exists (select DISTINCT trim(dev1) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100'));
end case ;

case when eve_code = '000818' THEN 
select DISTINCT trim(ncp2) into ncp_dest from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446'
union all
select ' ' from dual where not exists (select DISTINCT trim(ncp2)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446');

else 
select DISTINCT trim(ncp2) into ncp_dest from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')
union all
select ' ' from dual where not exists (select DISTINCT trim(ncp2)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100'));
end case ;

case when eve_code = '000818' THEN 
select DISTINCT trim(age2) into v_age2 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran   and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446'
union all
select ' ' from dual where not exists (select DISTINCT trim(age2)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran   and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446');
else 
select DISTINCT trim(age2) into v_age2 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran   and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')
union all
select ' ' from dual where not exists (select DISTINCT trim(age2)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran   and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100'));
end case ;
case when eve_code = '000818' THEN 
select DISTINCT trim(dev2) into v_dev2 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran   and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446'
union all 
select ' ' from dual where not exists (select DISTINCT trim(dev2)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran   and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446');
else 
select DISTINCT trim(dev2) into v_dev2 from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran   and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')
union all 
select ' ' from dual where not exists (select DISTINCT trim(dev2)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran   and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100'));
end case ;

if  trim(ncp_src) is not null then 
case when eve_code = '000818' THEN 
select trim(nomb) into v_nomb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') and OPE ='446' 
union all
select ' ' from dual where not exists (select trim(nomb) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') and OPE ='446');
ELSE
select trim(nomb) into v_nomb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select trim(nomb) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') );
END CASE ;
else 
case when eve_code = '000818' THEN 
select trim(nomb) into v_nomb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446'  
union all
select ' ' from dual where not exists (select trim(nomb)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446' );
else
select trim(nomb) into v_nomb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select trim(nomb)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  );
end case ;
end if ;

if  trim(ncp_src) is not null then 
case when eve_code = '000818' THEN 
select  trim(comb) into v_comb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')  and OPE ='446' 
union all
select ' ' from dual where not exists (select trim(comb) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') and OPE ='446'  );
else 
select  trim(comb) into v_comb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select trim(comb) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') );
end case ;
else 
case when eve_code = '000818' THEN 
select  trim(comb) into v_comb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446'   
union all
select ' ' from dual where not exists (select trim(comb)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446'   );
else
select  trim(comb) into v_comb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select trim(comb)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  );
end case ;
end if ;


if  trim(ncp_src) is not null then 
case when eve_code = '000818' THEN 
select  trim(nump) into v_nump from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') and OPE ='446' 
union all
select ' ' from dual where not exists (select trim(nump) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') and OPE ='446' );

else
select  trim(nump) into v_nump from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select trim(nump) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') );
end case ;
else 
case when eve_code = '000818' THEN 
select trim(nump) into v_nump from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446' 
union all
select ' ' from dual where not exists (select trim(nump)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446' );

else
select trim(nump) into v_nump from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select trim(nump)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  );
end case ;
end if ;

if  trim(ncp_src) is not null then 
case when eve_code = '000818' THEN 
select case when trim(nome) is not null then trim(nome) else trim(nomb) end into v_nomb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') and OPE ='446' 
union all
select ' ' from dual where not exists (select case when trim(nome) is not null then trim(nome) else trim(nomb) end  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') and OPE ='446');

else
select case when trim(nome) is not null then trim(nome) else trim(nomb) end into v_nomb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select case when trim(nome) is not null then trim(nome) else trim(nomb) end  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') );
end case ;
else 
case when eve_code = '000818' THEN 
select case when trim(nome) is not null then trim(nome) else trim(nomb) end into v_nomb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  and OPE ='446'
union all
select ' ' from dual where not exists (select case when trim(nome) is not null then trim(nome) else trim(nomb) end  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446' );

else
select case when trim(nome) is not null then trim(nome) else trim(nomb) end into v_nomb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select case when trim(nome) is not null then trim(nome) else trim(nomb) end  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  );
end case ;
end if ;

if  trim(ncp_src) is not null then 
case when eve_code = '000818' THEN 
select case when trim(domi) is null then '-' else trim(domi) end into v_branch from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')  and OPE ='446'
union all
select ' ' from dual where not exists (select case when trim(domi) is null then '-' else trim(domi) end  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') and OPE ='446' );
else
select case when trim(domi) is null then '-' else trim(domi) end into v_branch from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select case when trim(domi) is null then '-' else trim(domi) end  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') );
end case ;
else
case when eve_code = '000818' THEN 
select case when trim(domi) is null then '-' else trim(domi) end into v_branch from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  and OPE ='446'
union all
select ' ' from dual where not exists (select case when trim(domi) is null then '-' else trim(domi) end  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100') and OPE ='446' );

else 
select case when trim(domi) is null then '-' else trim(domi) end into v_branch from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select case when trim(domi) is null then '-' else trim(domi) end  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  );
end case ;
end if ;



if cli_dest = ' ' then cli_dest := null; end if;
if cli_src = ' ' then cli_src := null; end if;
if inf ='FN' THEN GOTO first_name ; end if ;
if inf ='LN' THEN GOTO last_name ;  end if ;
if inf ='BD' THEN GOTO birth_date ;  end if ;
if inf ='SN' THEN GOTO ssn_id ; end if ;
if inf ='NA' THEN GOTO nationality ;  end if ;
if inf ='RS' THEN GOTO residence ; end if ;
if inf ='TL' THEN GOTO tel_number ;  end if ;
if inf ='PF' THEN GOTO prefixe_number ;  end if ;
if inf ='OC' THEN GOTO occupation ; end if ;
if inf ='IT' THEN GOTO id_type ;  end if ;
if inf ='ID' THEN GOTO issue_date ;  end if ;
if inf ='ED' THEN GOTO expiry_date ;  end if ;
if inf ='IB' THEN GOTO issue_by ;  end if ;
if inf ='IC' THEN GOTO issue_country ;  end if ;
if inf ='AC' THEN GOTO account_number ;  end if ;
if inf ='BR' THEN GOTO account_branch ;  end if ;
if inf ='CU' THEN GOTO account_currency ;  end if ;
if inf ='IN' THEN GOTO institution_name ;  end if ;
if inf ='CN' THEN GOTO account_name ;  end if ;
if inf ='CC' THEN GOTO account_dev ;  end if ;
if inf ='EN' THEN GOTO entity_name ;  end if ;


<<first_name>>
--variables

select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then 
						select trim(pre) into resultat from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest <> ' ' then
 								select trim(pre) into resultat  from bkdircli where cli = cli_dest and rownum = 1
 								union all
 								select '-' from dual where not exists (select trim(pre) from bkdircli where cli = cli_dest and rownum = 1);
 							else resultat := '-';
 							end case;
		end case ;
	
	when cli_dest is null and v_comb is not null  -- nomb
		then resultat := v_nomb;
	else resultat := '-';
/*		
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select trim(pre) into resultat from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src <> ' ' then
								select trim(pre) into resultat  from bkdircli where cli = cli_src and rownum = 1
								union all
								select '-' from dual where not exists (select trim(pre) from bkdircli where cli = cli_src and rownum = 1 );
							else resultat := '-';
 							end case; 							
		end case ;
/**/
	end case;

when flag ='S' then 
	case when cli_src is not null then -- cli2			
		case when v_tcli_src = 1 then 
						select trim(pre) into resultat from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src <> ' ' then
								select trim(pre) into resultat  from bkdircli where cli = cli_src and rownum = 1 
								union all
								select '-' from dual where not exists (select trim(pre) from bkdircli where cli = cli_src and rownum = 1 );
							else resultat := '-';
 							end case;
		end case ;
	
	when cli_src is null and v_comb is not null  -- nomb
		then resultat := v_nomb;
	else resultat := 'External Customer';
/*		
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select trim(pre) into resultat from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest <> ' ' then
								select trim(pre) into resultat  from bkdircli where cli = cli_dest and rownum = 1 
								union all
								select '-' from dual where not exists (select trim(pre) from bkdircli where cli = cli_dest and rownum = 1 );
							else resultat := '-';
 							end case;
		end case ;
/**/
	end case;

end case ; --end cas flag

case when resultat is null then resultat := '-'; else resultat := resultat; end case;
					
return resultat ;

<<last_name>>

--variables

select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then 
						select trim(nom) into resultat from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest <> ' ' then
								select trim(nom) into resultat  from bkdircli where cli = cli_dest and rownum = 1 
								union all
								select '-' from dual where not exists (select trim(nom) from bkdircli where cli = cli_dest and rownum = 1 );
							else resultat := '-';
 							end case;
		end case ;
	
	when cli_dest is null and v_comb is not null  -- nomb
		then resultat := v_nomb;
	else resultat := '-';

/*
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select trim(nom) into resultat from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src <> ' ' then
								select trim(nom) into resultat  from bkdircli where cli = cli_src and rownum = 1 
								union all
								select '-' from dual where not exists (select trim(nom) from bkdircli where cli = cli_src and rownum = 1 );
							else resultat := '-';
 							end case;
		end case ;
/**/
	end case;

when flag ='S' then 
	case when cli_src is not null then -- cli2			
		case when v_tcli_src = 1 then 
						select trim(nom) into resultat from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src <> ' ' then
								select trim(nom) into resultat  from bkdircli where cli = cli_src and rownum = 1 
								union all
								select '-' from dual where not exists (select trim(nom) from bkdircli where cli = cli_src and rownum = 1 );
							else resultat := '-';
 							end case;
		end case ;
	
	when cli_src is null and v_comb is not null  -- nomb
		then resultat := v_nomb;	
	else resultat := '-';

/*	
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select trim(nom) into resultat from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest <> ' ' then
								select trim(nom) into resultat  from bkdircli where cli = cli_dest and rownum = 1 
								union all
								select '-' from dual where not exists (select trim(nom) from bkdircli where cli = cli_dest and rownum = 1 );
							else resultat := '-';
 							end case;
		end case ;
/**/
	end case;

end case ; --end cas flag

case when resultat is null then resultat := '-'; else resultat := resultat; end case;
					
return resultat ;

<<birth_date>>
--variables


select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then
					    select case when trim(dna) is null then (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00') else substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),11,18) end into bd_date from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest = 'T' then
								select  case when trim(dna) is null then (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00') else substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),11,18) end into bd_date  from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1) ;
							when v_tdir_dest = 'C' then
								select case when trim(dna) is null then (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00') else substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),11,18) end into bd_date  from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1) ;
							else bd_date := (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00');
							end case;
		end case ;

	when cli_dest is null and v_comb is not null  -- nomb
		then bd_date := (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00');
	else bd_date := (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00');
/*
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select case when trim(dna) is null then (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00') else substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),11,18) end into bd_date from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src <> ' ' then
								select case when trim(dna) is null then (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00') else substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),11,18) end into bd_date from bktier where  ctie =( select cdir  from bkdircli where cli = cli_src and rownum = 1) ;
							else resultat := '-';
 							end case;
		end case ;
/**/
	end case ;
when flag ='S' then 
	case when cli_src is not null then -- cli1			
		case when v_tcli_src = 1 then
					   select case when trim(dna) is null then (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00') else substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),11,18) end into bd_date from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src = 'T' then
								select case when trim(dna) is null then (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00') else substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),11,18) end into bd_date  from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1) ;
							when v_tdir_src = 'C' then
								select case when trim(dna) is null then (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00') else substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),11,18) end into bd_date  from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1) ;
							else bd_date := (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00');
							end case;
		end case ;
	when cli_src is null and v_comb is not null  -- nomb
		then bd_date := (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00');
	else bd_date := (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00');
/*		
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select case when trim(dna) is null then (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00') else substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),11,18) end into bd_date from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest = 'T' then
								select case when trim(dna) is null then (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00') else substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),11,18) end into bd_date  from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1) ;
							when v_tdir_dest = 'C' then
								select case when trim(dna) is null then (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00') else substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(dna,'YYYY-MM-DDHH:MI:SS'),11,18) end into bd_date  from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1) ;
							else bd_date := (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00');
							end case;
		end case ;
/**/
	end case ;
								
end case ; -- FLag

				case when bd_date is not null then resultat := bd_date;
							else resultat := (substr(to_char(sysdate-12410,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00');
				end case ;

return resultat ;


<<ssn_id>>
--variables

select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then 
						select trim(nid) into resultat from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest = 'T' then
					   			select case when trim(nid) is null then '-' else trim(nid) end into resultat  from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1) ;
					   		when v_tdir_dest = 'C' then
					   			select case when trim(nid) is null then '-' else trim(nid) end into resultat  from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1) ;
					   		else resultat := '-' ;
					   		end case;
		end case ;
	
	when cli_dest is null and v_comb is not null  -- nomb
		then 
--				case when v_nump is not null then 
--					resultat := v_nump ;
--				else --resultat := '2324684533' ;
				resultat := '-' ;
--				end case ;
	/*
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select trim(nid) into resultat from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src = 'T' then
								select case when trim(nid) is null then '-' else trim(nid) end into resultat  from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1) 
								union all
								select '-' from dual where not exists (select trim(nid) from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1) );
							when v_tdir_dest = 'C' then
								select case when trim(nid) is null then '-' else trim(nid) end into resultat  from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1) 
								union all
								select '-' from dual where not exists (select trim(nid) from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1) );
							else resultat := '-' ;
							end case;
		end case ;
	/**/
	else resultat := '-';
	end case;

when flag ='S' then 
	case when cli_src is not null then -- cli1			      
        
        case when v_tcli_src = 1 then 
						select trim(nid) into resultat from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src = 'T' then
					   			select case when trim(nid) is null then '-' else trim(nid) end into resultat  from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1) ;
					   		when v_tdir_src = 'C' then
					   			select case when trim(nid) is null then '-' else trim(nid) end into resultat  from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1) ;
					   		else resultat := '-' ;
					   		end case;
		end case ;
	
	when cli_src is null and v_comb is not null  -- nomb
		then 
--				case when v_nump is not null then 
--					resultat := v_nump ;
--				else --resultat := '2324684533' ;
				resultat := '-' ;
--				end case ;
	/*
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select case when trim(nid) is null then '-' else trim(nid) end into resultat from bkcli where cli = cli_dest ;
					else 
						select case when trim(nid) is null then '-' else trim(nid) end into resultat  from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1) 
						union all
						select '-' from dual where not exists (select trim(nid) from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1));
		end case ;
	/**/
	else resultat := '-';
	end case;

end case ; --end cas flag

					
return resultat ;


<<nationality>>
--variables
select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then
						select case when trim(nat) is null then '288' else trim(nat) end into nation  from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest = 'T' then
								select case when trim(nat) is null then '288' else trim(nat) end into nation  from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1) ;
							when v_tdir_dest = 'C' then
								select case when trim(nat) is null then '288' else trim(nat) end into nation  from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1) ;
							else nation := '288'	;
							end case;
		end case ;
	when cli_dest is null and v_comb is not null  -- nomb
		then nation := '288';
	/*
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select case when trim(nat) is null then '288' else trim(nat) end into nation from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src <> ' ' then
								select case when trim(nat) is null then '288' else trim(nat) end into nation from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1) ;
							else resultat := '288';
 							end case;
		end case ;	
	/**/
	else nation := '288';	
	end case ;
when flag ='S' then 
	case when cli_src is not null then -- cli1			
		case when v_tcli_src = 1 then
						select case when trim(nat) is null then '288' else trim(nat) end into nation  from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src = 'T' then
								select case when trim(nat) is null then '288' else trim(nat) end into nation  from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1) ;
							when v_tdir_dest = 'C' then
								select case when trim(nat) is null then '288' else trim(nat) end into nation  from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1) ;
							else nation := '288'	;
							end case;
		end case ;
	when cli_src is null and v_comb is not null  -- nomb
		then nation := '288';
	/*
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select case when trim(nat) is null then '288' else trim(nat) end into nation from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest <> ' ' then
								select case when trim(nat) is null then '288' else trim(nat) end into nation  from bkdircli where cli = cli_dest and rownum = 1 ;
							else resultat := '-';
 							end case;
		end case ;
	/**/
	else nation := '288';
		
	end case ;
			
						
end case ;						
												
		select trim(lib2) into resultat from bknom where ctab = '040' and cacc = nation;

	case when resultat is null then resultat :='GH'; else resultat := resultat; end case; 

return resultat ;

<<residence>>

--variables

select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then
						select trim(res) into resid  from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest = 'T' then
								select case when trim(res) is null then '288' else trim(res) end into resid  from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1) ;
							when v_tdir_dest = 'C' then
								select case when trim(res) is null then '288' else trim(res) end into resid  from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1) ;
							else resid := '288'	;
							end case;
		end case ;
	when cli_dest is null and v_comb is not null  -- nomb
		then resid := '288';
	/*
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select case when trim(res) is null then '288' else trim(nat) end into resid from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src <> ' ' then
								select case when trim(res) is null then '288' else trim(nat) end into resid from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1) ;
							else resultat := '288';
 							end case;
		end case ;		
	/**/
	else resid := '288';
		
	end case ;
when flag ='S' then 
	case when cli_src is not null then -- cli1			
		case when v_tcli_src = 1 then
						select trim(res) into resid  from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src = 'T' then
								select case when trim(res) is null then '288' else trim(res) end into resid  from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1) ;
							when v_tdir_dest = 'C' then
								select case when trim(res) is null then '288' else trim(res) end into resid  from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1) ;
							else resid := '288'	;
							end case;
		end case ;
	when cli_src is null and v_comb is not null  -- nomb
		then resid := '288';
	/*
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select case when trim(res) is null then '288' else trim(nat) end into resid from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest <> ' ' then
								select case when trim(res) is null then '288' else trim(nat) end into resid from bktier where  ctie =( select cdir  from bkdircli where cli = cli_dest and rownum = 1) ;
							else resultat := '-';
 							end case;
		end case ;
	/**/
	else resid := '288';	
	end case ;
			
						
end case ;						
												
		select trim(lib2) into resultat from bknom where ctab = '040' and cacc = resid;

case when resultat is null then resultat :='GH'; else resultat := resultat; end case; 

return resultat ;

<<prefixe_number>>
--variables
if  trim(ncp_src) is not null then 
select  trim(ad2p) into v_nump from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select trim(ad2p) from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100') );
else 
select trim(ad2p) into v_nump from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  
union all
select ' ' from dual where not exists (select trim(ad2p)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')  );

end if ;

--select trim(ad2p) into v_nump from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran;

select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then 
						select trim(num) into num_tel  from bktelcli where cli = cli_dest and rownum = 1 ;
					else 
							case when v_tdir_dest = 'T' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bkteltie where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1) and rownum = 1;
							when v_tdir_dest = 'C' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bktelcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1) and rownum = 1;
							else resultat := '-';
							end case;
		end case ;
	
	when cli_dest is null and v_comb is not null  -- nomb
		then 
--				case when v_nump is not null then 
--					resultat := v_nump ;
--				--else resultat := '+233542003841' ;
				resultat := '-';
--				end case ;
	/*
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select trim(num) into num_tel  from bktelcli where cli = cli_src and rownum = 1 ;
					else 
							case when v_tdir_src = 'T' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bkteltie where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1) and rownum = 1;
							when v_tdir_dest = 'C' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bktelcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1) and rownum = 1;
							else resultat := '-';
							end case;
		end case ;
	/**/
	else resultat := '-';
	end case;

when flag ='S' then 
	case when cli_src is not null then -- cli2			
		case when v_tcli_src = 1 then 
						select trim(num) into num_tel  from bktelcli where cli = cli_src and rownum = 1 ;
					else 
							case when v_tdir_src = 'T' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bkteltie where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1) and rownum = 1;
							when v_tdir_dest = 'C' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bktelcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1) and rownum = 1;
							else resultat := '-';
							end case;
		end case ;
	
	when cli_src is null and v_comb is not null  -- nomb
		then 
--				case when v_nump is not null then 
--					resultat := v_nump ;
--				else --resultat := '+233542003841' ;
				resultat := '+NA' ;
--				end case ;
	/*
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select trim(num) into num_tel  from bktelcli where cli = cli_dest and rownum = 1 ;
					else 
							case when v_tdir_dest = 'T' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bkteltie where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1) and rownum = 1;
							when v_tdir_dest = 'C' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bktelcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1) and rownum = 1;
							else resultat := '-';
							end case;
		end case ;
	/**/
	else resultat := '+NA';
	end case;

end case ; --end cas flag

select substr(num_tel,1,4) into num_tel_v  from dual ;
select  substr(num_tel ,1,1) into num_tel_v2 from dual ;
    			
    			case when num_tel is null then resultat := '-'; 
    			else
    				case when num_tel_v2 = '+' then resultat := num_tel_v ; 
    				else resultat := '+233' ; 
    				end case ;
				end case;
	
return resultat ;


<<tel_number>>

--variables

select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then 
						select trim(num) into num_tel  from bktelcli where cli = cli_dest and rownum = 1 ;
					else 
							case when v_tdir_dest = 'T' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bkteltie where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1) and rownum = 1;
							when v_tdir_dest = 'C' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bktelcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1) and rownum = 1;
							else resultat := '-' ;
							end case;
		end case ;
	
	when cli_dest is null and v_comb is not null  -- nomb
		then 
--				case when v_nump is not null then 
--					resultat := v_nump ;
--				else --resultat := '+233542003841' ;
				resultat := '-' ;
--				end case ;
	/*
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bktelcli where cli = cli_src and rownum = 1 ;
					else 
							case when v_tdir_src = 'T' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bkteltie where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1) and rownum = 1;
							when v_tdir_dest = 'C' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bktelcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1) and rownum = 1;
							else resultat := '-' ;
							end case;
		end case ;
	/**/
	else resultat := '-' ;
	end case;

when flag ='S' then 
	case when cli_src is not null then -- cli2			
		case when v_tcli_src = 1 then 
						select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bktelcli where cli = cli_src and rownum = 1 ;
					else 
							case when v_tdir_src = 'T' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bkteltie where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1) and rownum = 1;
							when v_tdir_dest = 'C' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bktelcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1) and rownum = 1;
							else resultat := '-' ;
							end case;
		end case ;
	
	when cli_src is null and v_comb is not null  -- nomb
		then 
--				case when v_nump is not null then 
--					resultat := v_nump ;
--				else --resultat := '+233542003841' ;
				resultat := '-' ;
--				end case ;
	/*
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bktelcli where cli = cli_dest and rownum = 1 ;
					else 
							case when v_tdir_dest = 'T' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bkteltie where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1) and rownum = 1;
							when v_tdir_dest = 'C' then
								select case  when trim(num) is null then '-' else trim(num) end into num_tel  from bktelcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1) and rownum = 1;
							else resultat := '-' ;
							end case;
		end case ;
	/**/
	else resultat := '-' ;
	end case;

end case ; --end cas flag
				case when num_tel is null then resultat := '-' ;
				else		
					case when substr(num_tel ,1,1) = '+' then resultat := substr(num_tel,5,length(num_tel)) ; 
					else resultat := num_tel ; 
					end case;
				end case;
	
return resultat ;


<<occupation>>
	--variables

select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then
						select count(prf) into v_count from bkprfcli where cli = cli_dest and demp = (select max(demp) from bkprfcli where cli = cli_dest);
					   	case when v_count = 0 then resultat := 'OTHER';
					   	else
					   	select trim(lib1) into resultat from bknom where ctab='045' and cacc = (select trim(prf) from bkprfcli where cli = cli_dest and demp = (select max(demp) from bkprfcli where cli = cli_dest)) ;
						end case;
					else 
							case when v_tdir_dest = 'T' then
								select (case when trim(fdir) is null then 'OTHER' else trim(fdir) end ) into resultat  from bkdircli where cli = cli_dest and rownum = 1;
							when v_tdir_dest = 'C' then
								select count(prf) into v_count from bkprfcli where cli = (select cdir from bkdircli where cli = cli_dest and rownum = 1) and demp = (select max(demp) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_dest and rownum = 1));
								case when v_count = 0 then resultat := 'OTHER';
								else
								select trim(lib1) into resultat from bknom where ctab='045' and cacc = (select trim(prf) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_dest and rownum = 1) and demp = (select max(demp) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_dest and rownum = 1))) ;
								end case;
							else resultat := '-';
							end case;
		end case ;
	when cli_dest is null and v_comb is not null  -- nomb
		then resultat := 'OTHER';
	/*	
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select count(prf) into v_count from bkprfcli where cli = cli_src and demp = (select max(demp) from bkprfcli where cli = cli_src);
						case when v_count = 0 then resultat := 'OTHER';
						else
						select trim(lib1) into resultat from bknom where ctab='045' and cacc = (select trim(prf) from bkprfcli where cli = cli_src and demp = (select max(demp) from bkprfcli where cli = cli_src)) ;
						end case;
					else 
							case when v_tdir_src = 'T' then
								select (case when trim(fdir) is null then 'OTHER' else trim(fdir) end ) into resultat  from bkdircli where cli = cli_src and rownum = 1;
							when v_tdir_src = 'C' then
								select count(prf) into v_count from bkprfcli where cli = (select cdir from bkdircli where cli = cli_src and rownum = 1) and demp = (select max(demp) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_src and rownum = 1));
								case when v_count = 0 then resultat := 'OTHER';
								else
								select trim(lib1) into resultat from bknom where ctab='045' and cacc = (select trim(prf) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_src and rownum = 1) and demp = (select max(demp) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_src and rownum = 1))) ;
								end case;
							else resultat := '-';
							end case;
		end case ;
	/**/
	else resultat := 'OTHER';		
	end case ;
when flag ='S' then 
	case when cli_src is not null then -- cli1			
		case when v_tcli_src = 1 then
						select count(prf) into v_count from bkprfcli where cli = cli_src and demp = (select max(demp) from bkprfcli where cli = cli_src);
					  	case when v_count = 0 then resultat := 'OTHER';
					  	else
					  	select lib1 into resultat from bknom where ctab='045' and cacc = (select trim(prf) from bkprfcli where cli = cli_src and demp = (select max(demp) from bkprfcli where cli = cli_src)) ;
						end case;
					else 
							case when v_tdir_src = 'T' then
								select (case when trim(fdir) is null then 'OTHER' else trim(fdir) end ) into resultat  from bkdircli where cli = cli_src and rownum = 1;
							when v_tdir_dest = 'C' then
								select count(prf) into v_count from bkprfcli where cli = (select cdir from bkdircli where cli = cli_src and rownum = 1) and demp = (select max(demp) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_src and rownum = 1));
								case when v_count = 0 then resultat := 'OTHER';
					  			else
								select trim(lib1) into resultat from bknom where ctab='045' and cacc = (select trim(prf) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_src and rownum = 1) and demp = (select max(demp) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_src and rownum = 1))) ;
								end case;
							else resultat := '-';
							end case;
		end case ;
	when cli_src is null and v_comb is not null  -- nomb
		then resultat := 'OTHER';
	/*	
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select count(prf) into v_count from bkprfcli where cli = cli_dest and demp = (select max(demp) from bkprfcli where cli = cli_dest);
						case when v_count = 0 then resultat := 'OTHER';
					  	else
						select lib1 into resultat from bknom where ctab='045' and cacc = (select trim(prf) from bkprfcli where cli = cli_dest and demp = (select max(demp) from bkprfcli where cli = cli_dest)) ;
						end case;
					else 
							case when v_tdir_dest = 'T' then
								select (case when trim(fdir) is null then 'OTHER' else trim(fdir) end ) into resultat  from bkdircli where cli = cli_dest and rownum = 1;
							when v_tdir_dest = 'C' then
								select count(prf) into v_count from bkprfcli where cli = (select cdir from bkdircli where cli = cli_dest and rownum = 1) and demp = (select max(demp) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_dest and rownum = 1));
								case when v_count = 0 then resultat := 'OTHER';
					  			else
								select trim(lib1) into resultat from bknom where ctab='045' and cacc = (select trim(prf) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_dest and rownum = 1) and demp = (select max(demp) from bkprfcli where cli = (select cdir from bkdircli where cli = cli_dest and rownum = 1))) ;
								end case;
							else resultat := '-';
							end case;
		end case ;
	/**/
	else resultat := 'OTHER';
	end case ;
			
						
end case ; -- FLag
	
if resultat is null then resultat := '-' ; 
else resultat := resultat ;
end if;
	
return resultat ;

<<id_type>>
	--variables

select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then
					    select trim(tid) into id_typ from bkcli where cli = cli_dest  ;
					else 
							case when v_tdir_dest = 'T' then
						  		select trim(tid) into id_typ from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select trim(tid) into id_typ from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	else id_typ := '-';
						  	end case;
		end case ;
	when cli_dest is null and v_comb is not null  -- nomb
		then id_typ := '-';
	/*	
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select case when trim(dna) is null then '288' else trim(nat) end into nation from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src = 'T' then
						  		select trim(tid) into id_typ from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	when v_tdir_src = 'C' then
						  		select trim(tid) into id_typ from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	else id_typ := '-';
						  	end case;
		end case ;
	/**/
	else id_typ := '-';
	end case ;
when flag ='S' then 
	case when cli_src is not null then -- cli1			
		case when v_tcli_src = 1 then
					  select trim(tid) into id_typ from bkcli where cli = cli_src  ;
					else 
							case when v_tdir_src = 'T' then
						  		select trim(tid) into id_typ from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	when v_tdir_src = 'C' then
						  		select trim(tid) into id_typ from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	else id_typ := '-';
						  	end case;
		end case ;
	when cli_src is null and v_comb is not null  -- nomb
		then id_typ := '-';
	/*
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select trim(tid) into id_typ from bkcli where cli = cli_src  ;
					else 
							case when v_tdir_dest = 'T' then
						  		select trim(tid) into id_typ from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select trim(tid) into id_typ from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	else id_typ := '-';
						  	end case;
		end case ;
	/**/
	else id_typ := '-';
	end case ;
			
						
end case ; -- FLag

		case 
					 when id_typ = '00009' then resultat :='A' ; -- Driver's License
                     when id_typ = '00011' then resultat :='AA'; -- Voters ID
					 when id_typ = '00001' then resultat :='B'; -- National ID
                     when id_typ = '00002' then resultat :='C'; -- Passport
                     
					else resultat :='D'; -- Others
          end case ;
return resultat ;


<<issue_date>>
--variables
select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then
					    select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end into iss_date from bkcli where cli = cli_dest  ;
					else 
							case when v_tdir_dest = 'T' then
						  		select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end  into iss_date from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end into iss_date from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	else resultat := substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' ;
						  	end case;
		end case ;
	when cli_dest is null and v_comb is not null  -- nomb
		then iss_date := substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00';
	/*	
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end into iss_date from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src = 'T' then
						  		select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end into iss_date from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	when v_tdir_src = 'C' then
						  		select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end into iss_date from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	else resultat := substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' ;
						  	end case;
		end case ;
	/**/
	else iss_date := substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00';	
	end case ;
when flag ='S' then 
	case when cli_src is not null then -- cli1			
		case when v_tcli_src = 1 then
					   select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end into iss_date from bkcli where cli = cli_src  ;
					else 
							case when v_tdir_src = 'T' then
						  		select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end into iss_date from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end into iss_date from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	else resultat := substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' ;
						  	end case;
		end case ;
	when cli_src is null and v_comb is not null  -- nomb
		then iss_date := substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00';
	/*	
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end into iss_date from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest = 'T' then
						  		select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end into iss_date from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select case when trim(did) is null then substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(did,'YYYY-MM-DDHH:MI:SS'),11,18) end into iss_date from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	else resultat := substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' ;
						  	end case;
		end case ;
	/**/
	else iss_date := substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00';
	end case ;
								
end case ; -- FLag

				case when iss_date is not null then resultat := iss_date;
							else resultat := substr(to_char(sysdate-1460,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' ;
				end case ;
	
return resultat ;

<<expiry_date>>
--variables

select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then
					    select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bkcli where cli = cli_dest  ;
					else 
							case when v_tdir_dest = 'T' then
						  		select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	else resultat := substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00';
						  	end case;
		end case ;
	when cli_dest is null and v_comb is not null  -- nomb
		then exp_date := substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00';
	/*	
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bkcli where cli = cli_src ;
					else 
							case when v_tdir_src = 'T' then
						  		select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	when v_tdir_src = 'C' then
						  		select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	else resultat := substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' ;
						  	end case;
		end case ;
	/**/
	else exp_date := substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00';
	end case ;
when flag ='S' then 
	case when cli_src is not null then -- cli1			
		case when v_tcli_src = 1 then
					   select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bkcli where cli = cli_src  ;
					else 
							case when v_tdir_src = 'T' then
						  		select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	else resultat := substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00';
						  	end case;
		end case ;
	when cli_src is null and v_comb is not null  -- nomb
		then iss_date := substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00';
	/*	
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bkcli where cli = cli_dest ;
					else 
							case when v_tdir_dest = 'T' then
						  		select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select case when trim(vid) is null then substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' else substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||substr(to_char(vid,'YYYY-MM-DDHH:MI:SS'),11,18) end into exp_date from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	else resultat := substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00' ;
						  	end case;
		end case ;
	/**/
	else exp_date := substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00';
	end case ;
								
end case ; -- FLag
				
				case when exp_date is not null then resultat := exp_date;
							else resultat := substr(to_char(sysdate+5840,'YYYY-MM-DDHH:MI:SS'),1,10)||'T'||'00:00:00';
				end case ;
	
return resultat ;

<<issue_by>>
--variables

select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then
					    select trim(oid) into iss_by from bkcli where cli = cli_dest  ;
					else 
							case when v_tdir_dest = 'T' then
						  		select trim(oid) into iss_by from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select trim(oid) into iss_by from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	else iss_by := '-';
						  	end case;
		end case ;
	when cli_dest is null and v_comb is not null  -- nomb
		then iss_by := '-';
	/*
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select trim(oid) into iss_by from bkcli where cli = cli_src  ;
					else 
							case when v_tdir_src = 'T' then
						  		select trim(oid) into iss_by from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	when v_tdir_src = 'C' then
						  		select trim(oid) into iss_by from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	else iss_by := '-';
						  	end case;
		end case ;
	/**/
	else iss_by := '-';
		
	end case ;
when flag ='S' then 
	case when cli_src is not null then -- cli1			
		case when v_tcli_src = 1 then
					   select trim(oid) into iss_by from bkcli where cli = cli_src  ;
					else 
							case when v_tdir_src = 'T' then
						  		select trim(oid) into iss_by from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select trim(oid) into iss_by from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	else iss_by := '-';
						  	end case;
		end case ;
	when cli_src is null and v_comb is not null  -- nomb
		then iss_by := '-';
	/*
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select trim(oid) into iss_by from bkcli where cli = cli_dest  ;
					else 
							case when v_tdir_dest = 'T' then
						  		select trim(oid) into iss_by from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select trim(oid) into iss_by from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	else iss_by := '-';
						  	end case;
		end case ;
	/**/
	else iss_by := '-';
	end case ;
								
end case ; -- FLag

						case when iss_by is not null then resultat := iss_by ; else resultat := 'ELECTORAL COMMISSION OF GHANA'  ; end case ;
						
	
return resultat ;


<<issue_country>>
--variables

select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
select trim(typ) into v_tdir_dest from bkdircli where cli = cli_dest and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_dest and rownum = 1);
select trim(typ) into v_tdir_src from bkdircli where cli = cli_src and rownum = 1
union all
select ' ' from dual where not exists(select trim(typ) from bkdircli where cli = cli_src and rownum = 1);
--cases
case when flag ='D' then 
	case when cli_dest is not null then -- cli2			
		case when v_tcli_dest = 1 then
					    select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bkcli where cli = cli_dest  ;
					else 
							case when v_tdir_dest = 'T' then
						  		select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	else iss_ct := 'GHANA';
						  	end case;
		end case ;
	when cli_dest is null and v_comb is not null  -- nomb
		then iss_ct := 'GHANA';
	/*
	when cli_dest is null and v_comb is null then
		case when v_tcli_src = 1 then 
						select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bkcli where cli = cli_src  ;
					else 
							case when v_tdir_src = 'T' then
						  		select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	when v_tdir_src = 'C' then
						  		select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	else iss_ct := 'GHANA';
						  	end case;
		end case ;
	/**/
	else iss_ct := 'GHANA';
	end case ;
when flag ='S' then 
	case when cli_src is not null then -- cli1			
		case when v_tcli_src = 1 then
					   select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bkcli where cli = cli_src  ;
					else 
							case when v_tdir_src = 'T' then
						  		select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bktier where  ctie =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	when v_tdir_src = 'C' then
						  		select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bkcli where  cli =( select cdir from bkdircli where cli = cli_src and rownum = 1);
						  	else iss_ct := 'GHANA';
						  	end case;
		end case ;
	when cli_src is null and v_comb is not null  -- nomb
		then iss_ct := 'GHANA';
	/*
	when cli_src is null and v_comb is null then
		case when v_tcli_dest = 1 then 
						select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bkcli where cli = cli_dest  ;
					else 
							case when v_tdir_dest = 'T' then
						  		select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bktier where  ctie =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	when v_tdir_dest = 'C' then
						  		select case when trim(lid) is null then 'GHANA' else trim(lid) end into iss_ct from bkcli where  cli =( select cdir from bkdircli where cli = cli_dest and rownum = 1);
						  	else iss_ct := 'GHANA';
						  	end case;
		end case ;
	/**/
	else iss_ct := 'GHANA';
	end case ;
								
end case ; -- FLag
 
  
select trim(lib2) into resultat from bknom where ctab ='040' and lib1 = iss_ct
union all
select null from dual where not exists (select trim(lib2) from bknom where ctab ='040' and lib1 = iss_ct);
 	/*
				case when 
							var_1  is not null then resultat := var_2 ;
              else resultat := 'GH' ;
				end case ;
	/**/					
case when resultat is null then resultat :='GH'; else resultat := resultat ; end case ; 	
return resultat ;



<<account_number>>


case when flag ='D' then 
	case when trim(ncp_dest) is not null then resultat := trim(ncp_dest);
	when trim(ncp_dest) is null and v_comb is not null then resultat := v_comb;
	--when trim(ncp_dest) is null and v_comb is null then resultat := trim(ncp_src);
	else resultat := '-';
	end case;

	case when nat_tran in ('AGEBAN') then resultat := '27220000002'; 
	else resultat := resultat;
	end case;

when flag = 'S' then
	case when trim(ncp_src) is not null then resultat := trim(ncp_src);
	when trim(ncp_src) is null and v_comb is not null then resultat := v_comb;
	--when trim(ncp_src) is null and v_comb is null then resultat := trim(ncp_dest);
	else resultat := '-';
	end case;

	case when nat_tran in ('SAIRPT') then resultat := '39100000001'; 
	else resultat := resultat;
	end case;
end case;


return resultat ;

<<account_branch>>



case when flag ='D' then 
	case when trim(ncp_dest) is not null then 
		SELECT case when trim(lib1) is null then '-' else trim(lib1) end INTO resultat from bknom where ctab='001' and cacc = v_age2;
	when trim(ncp_dest) is null and v_comb is not null then resultat := v_branch;
	--when trim(ncp_dest) is null and v_comb is null then
	--	SELECT trim(lib1) INTO resultat from bknom where ctab='001' and cacc = (select trim(age1)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran);
	else resultat := '-';
	end case;
when flag = 'S' then
	case when trim(ncp_src) is not null then 
		SELECT case when trim(lib1) is null then '-' else trim(lib1) end INTO resultat from bknom where ctab='001' and cacc = v_age1;
	when trim(ncp_src) is null and v_comb is not null then resultat := v_branch;
	--when trim(ncp_src) is null and v_comb is null then
	--	SELECT trim(lib1) INTO resultat from bknom where ctab='001' and cacc = (select trim(age2)  from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran);
	else resultat := '-';
	end case;
end case;

case when resultat is null then resultat := '-'; else resultat := resultat; end case;

return resultat;

<<account_currency>>



case when flag ='D' then 
	case when trim(ncp_dest) is not null then 
		 v_dev := trim(v_dev2);
	when trim(ncp_dest) is null and v_comb is not null then v_dev := '-';
	--when trim(ncp_dest) is null and v_comb is null then
	--	select trim(dev1) into v_dev from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran;
	else v_dev := '-';
	end case;
when flag = 'S' then
	case when trim(ncp_src) is not null then 
		 v_dev := trim(v_dev1);
	when trim(ncp_src) is null and v_comb is not null then v_dev := '-';
	--when ncp_src is null and v_comb is null then
	--	select trim(dev2) into v_dev from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran;
	else v_dev := '-';
	end case;
end case;

case when v_dev is null or v_dev = '-' then resultat :='GHS';
else
	select trim(lib2) into resultat from bknom where ctab = '005' and cacc = v_dev;	
end case;
return resultat;

<<institution_name>>
select tcli into v_tcli_dest from bkcli where cli = cli_dest
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_dest );
select tcli into v_tcli_src from bkcli where cli =cli_src 
union all
select ' ' from dual where not exists (select tcli from bkcli where cli =cli_src );
case when flag ='D' then 
	case when cli_dest is not null then 
		case when v_tcli_dest <> '1' then 
			select trim(nomrest) into resultat from bkcli where cli = cli_dest;
		else resultat := '-';
		end case;
	when cli_dest is null and v_comb is not null then
		resultat := v_nomb;
	/*
	when cli_dest is null and v_comb is null then
		case when v_tcli_src <> '1' then
			select trim(nomrest) into resultat from bkcli where cli = cli_src;
		else resultat := '-';
		end case;
	/**/
	else resultat := '-';
	end case;

	case when nat_tran in ('AGEBAN') then resultat := 'BSIC GH LTD'; 
	else resultat := resultat;
	end case;
when flag = 'S' then
	case when cli_src is not null then 
		case when v_tcli_src <> '1' then 
			select trim(nomrest) into resultat from bkcli where cli = cli_src;
		else resultat := '-';
		end case;
	when cli_src is null and v_comb is not null then
		resultat := v_nomb;
	/*
	when cli_src is null and v_comb is null then
		case when v_tcli_dest <> '1' then
			select trim(nomrest) into resultat from bkcli where cli = cli_dest;
		else resultat := '-';
		end case;
	/**/
	else resultat := '-';
	end case;

	case when nat_tran in ('SAIRPT') then resultat := 'BSIC GH LTD'; 
	else resultat := resultat;
	end case;
end case;
return resultat;




<<account_name>>

case when flag = 'D' then
	case when trim(ncp_dest) is not null then
		select trim(inti) into resultat from bkcom where trim(ncp) = trim(ncp_dest) and trim(age) = trim(v_age2) and trim(dev) = trim(v_dev2) ;
	else resultat := '-';
	end case;
when flag = 'S' then 
	case when trim(ncp_src) is not null then
		select trim(inti) into resultat from bkcom where trim(ncp) = trim(ncp_src) and trim(age) = trim(v_age1) and trim(dev) = trim(v_dev1) ;
	else resultat := '-';
	end case;
end case;
return resultat;

<<account_dev>>

--select trim(comb) into v_comb from bkheve where eve = eve_code and dateh = dat_hist and nat = nat_tran;
case when flag = 'D' then
	case when trim(ncp_dest) is not null then
		select trim(lib2) into resultat from bknom where ctab = '005' and  trim(cacc) = trim(v_dev2);
	else resultat := 'GHS';
	end case;
when flag = 'S' then 
	case when trim(ncp_src) is not null then
		select trim(lib2) into resultat from bknom where ctab = '005' and  trim(cacc) = trim(v_dev1);
	else resultat := 'GHS';
	end case;
end case;
return resultat;

<<entity_name>>
case when flag ='D' then 
	case when cli_dest is not null then 
			select case when trim(nomrest) is null then '-' else trim(nomrest) end into resultat from bkcli where cli = cli_dest;
	when cli_dest is null and v_comb is not null then
		resultat := v_nomb;
	/*
	when cli_dest is null and v_comb is null then
			select case when trim(nomrest) is null then '-' else trim(nomrest) end into resultat from bkcli where cli = cli_src;
	/**/
	else resultat := '-';
	end case;
when flag = 'S' then
	case when cli_src is not null then 
			select case when trim(nomrest) is null then '-' else trim(nomrest) end into resultat from bkcli where cli = cli_src;
	when cli_src is null and v_comb is not null then
		resultat := v_nomb;
	/*
	when cli_src is null and v_comb is null then
			select case when trim(nomrest) is null then '-' else trim(nomrest) end into resultat from bkcli where cli = cli_dest;
	/**/
	else resultat := '-';
	end case;
end case;

case when resultat is null then resultat := '-'; else resultat := resultat; end case;
return resultat;


end;