-- V_ETR View REPORT
--============================
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PRDGHAAMP"."V_ETR" ("CLI_ID", "BRANCH", "CLI_NAT", "CUSTOMER_TYPE", "OCCUP_BUSINESS_LIB", "RESIDENTAL_ADRESS", "POSTAL_ADRESS", "SYS", "NAT", "ACCOUNT_TYPE", "ACCOUNT_NO", "ACCOUNT_STATUS", "DATE_OPEN", "TRANSACTION_NO", "TRANSACTION_DATE_F", "TRANSACTION_DATE", "POSTING_DATE_F", "POSTING_DATE", "INWARD_OUTWARD", "DB_CR", "CURRENCY_TYPE", "AMOUNT_CURRENCY", "GHS_EQUIV", "TRANSACTION_PURPOSE", "PERSON_CONDUCTING", "PARTY", "BENEFICIARY_NAME", "RESIDENTIAL_ADRESS", "ISSUING_AUTH", "DATE_HIST", "CLI1_INF", "CLI2_INF", "INSTITUTION_NAME_SRC", "INSTITUTION_NAME_DEST", "INSTITUTION_CODE_SRC", "INSTITUTION_CODE_DEST", "CUSTOMER_SRC", "CUSTOMER_DEST", "ACCOUNT_NO_SRC", "ACCOUNT_NO_DEST", "T_DEST_CURRENCY_CODE", "T_DEST_EXCH_RATE", "DEST_AMOUNT_CURRENCY", "T_SRC_EXCH_RATE", "SRC_AMOUNT_CURRENCY", "ENTITY_INCORPORATION_NUM", "ACCOUNT_CLOSED_DATE", "ACCOUNT_CURR_CODE", "ACCOUNT_NAME", "ACCOUNT_BALANCE", "TRANSACTION_PARTICULARS", "T_SRC_CURRENCY_CODE", "VALUE_DATE_F", "VALUE_DATE", "AUTHORIZED", "FROM_FUNDS_CODE", "SOURCE_FUNDS_CODE", "SUBMISSION_DATE", "SUBMISSION_CODE", "TRA") AS 
  SELECT "CLI_ID","BRANCH","CLI_NAT","CUSTOMER_TYPE","OCCUP_BUSINESS_LIB","RESIDENTAL_ADRESS","POSTAL_ADRESS","SYS","NAT","ACCOUNT_TYPE","ACCOUNT_NO","ACCOUNT_STATUS","DATE_OPEN","TRANSACTION_NO","TRANSACTION_DATE_F","TRANSACTION_DATE","POSTING_DATE_F","POSTING_DATE","INWARD_OUTWARD","DB_CR","CURRENCY_TYPE","AMOUNT_CURRENCY","GHS_EQUIV","TRANSACTION_PURPOSE","PERSON_CONDUCTING","PARTY","BENEFICIARY_NAME","RESIDENTIAL_ADRESS","ISSUING_AUTH","DATE_HIST","CLI1_INF","CLI2_INF","INSTITUTION_NAME_SRC","INSTITUTION_NAME_DEST","INSTITUTION_CODE_SRC","INSTITUTION_CODE_DEST","CUSTOMER_SRC","CUSTOMER_DEST","ACCOUNT_NO_SRC","ACCOUNT_NO_DEST","T_DEST_CURRENCY_CODE","T_DEST_EXCH_RATE","DEST_AMOUNT_CURRENCY","T_SRC_EXCH_RATE","SRC_AMOUNT_CURRENCY","ENTITY_INCORPORATION_NUM","ACCOUNT_CLOSED_DATE","ACCOUNT_CURR_CODE","ACCOUNT_NAME","ACCOUNT_BALANCE","TRANSACTION_PARTICULARS","T_SRC_CURRENCY_CODE","VALUE_DATE_F","VALUE_DATE","AUTHORIZED","FROM_FUNDS_CODE","SOURCE_FUNDS_CODE","SUBMISSION_DATE","SUBMISSION_CODE","TRA" 
FROM
(
Select 
(CASE WHEN cli_id                   IS NULL THEN '-' else cli_id                   end ) as cli_id ,
(CASE WHEN BRANCH                   IS NULL THEN '-' else BRANCH                   end ) AS BRANCH ,
(CASE WHEN cli_nat                  IS NULL THEN '-' else cli_nat                  end ) AS cli_nat  ,
(CASE WHEN CUSTOMER_TYPE            IS NULL THEN '-' else CUSTOMER_TYPE            end ) AS CUSTOMER_TYPE ,
--(CASE WHEN NATIONALITY              IS NULL THEN '-' else NATIONALITY              end ) AS NATIONALITY ,
(CASE WHEN OCCUP_BUSINESS_LIB       IS NULL THEN '-' else OCCUP_BUSINESS_LIB       end ) AS OCCUP_BUSINESS_LIB ,
--(CASE WHEN ID_TYPE_1                IS NULL THEN '-' else ID_TYPE_1                end ) AS ID_TYPE_1 ,
(CASE WHEN RESIDENTAL_ADRESS        IS NULL THEN '-' else RESIDENTAL_ADRESS        end ) AS RESIDENTAL_ADRESS ,
(CASE WHEN POSTAL_ADRESS            IS NULL THEN '-' else POSTAL_ADRESS            end ) AS POSTAL_ADRESS ,
--(CASE WHEN TOWN                     IS NULL THEN '-' else TOWN                     end ) AS TOWN ,
--(CASE WHEN REGION                   IS NULL THEN '-' else REGION                   end ) AS REGION ,
--(CASE WHEN TEL                      IS NULL THEN '-' else TEL                      end ) AS TEL ,
SYS ,
NAT,
(CASE WHEN ACCOUNT_TYPE             IS NULL THEN '-' else ACCOUNT_TYPE             end ) AS ACCOUNT_TYPE ,
(CASE WHEN ACCOUNT_NO               IS NULL THEN '-' else ACCOUNT_NO               end ) AS ACCOUNT_NO ,
ACCOUNT_STATUS ,
DATE_OPEN ,                                 
(CASE WHEN TRANSACTION_NO           IS NULL THEN '-' else TRANSACTION_NO           end ) AS TRANSACTION_NO ,
TRANSACTION_DATE_F ,
TRANSACTION_DATE ,
(CASE WHEN POSTING_DATE_F           IS NULL THEN '-' else POSTING_DATE_F           end ) AS POSTING_DATE_F ,
POSTING_DATE , 
INWARD_OUTWARD ,
DB_CR ,
(CASE WHEN TRIM(CURRENCY_TYPE)            IS NULL THEN '-' else CURRENCY_TYPE            end ) AS CURRENCY_TYPE ,
(CASE WHEN TRIM(AMOUNT_CURRENCY)  IS NULL THEN 0 ELSE  AMOUNT_CURRENCY END ) AS AMOUNT_CURRENCY                   ,
GHS_EQUIV ,
(CASE WHEN trim(TRANSACTION_PURPOSE)      IS NULL THEN '-' else trim(TRANSACTION_PURPOSE)      end ) AS TRANSACTION_PURPOSE ,
(CASE WHEN trim(PERSON_CONDUCTING)        IS NULL THEN '-' else trim(PERSON_CONDUCTING)        end ) AS PERSON_CONDUCTING ,
(CASE WHEN trim(PARTY)                    IS NULL THEN '-' else trim(PARTY)                    end ) AS PARTY ,
(CASE WHEN trim(BENEFICIARY_NAME)         IS NULL THEN '-' else trim(BENEFICIARY_NAME)         end ) AS BENEFICIARY_NAME ,
(CASE WHEN trim(RESIDENTIAL_ADRESS)       IS NULL THEN '-' else trim(RESIDENTIAL_ADRESS)       end ) AS RESIDENTIAL_ADRESS ,
(CASE WHEN trim(ISSUING_AUTH)             IS NULL THEN '-' else trim(ISSUING_AUTH)             end ) AS ISSUING_AUTH ,
DATE_HIST ,
(CASE WHEN TRIM(CLI1_INF)                 IS NULL THEN '-' else TRIM(CLI1_INF)            end ) AS CLI1_INF,
(CASE WHEN TRIM(CLI2_INF)                 IS NULL THEN '-' else TRIM(CLI2_INF)            end ) AS CLI2_INF,
(CASE WHEN TRIM(INSTITUTION_NAME_SRC)           IS NULL THEN '-' else trim(INSTITUTION_NAME_SRC)            end ) AS INSTITUTION_NAME_SRC,
(CASE WHEN TRIM(INSTITUTION_NAME_DEST)          IS NULL THEN '-' else trim(INSTITUTION_NAME_DEST)            end ) AS INSTITUTION_NAME_DEST,
(CASE WHEN TRIM(INSTITUTION_CODE_SRC)           IS NULL THEN '-' else trim(INSTITUTION_CODE_SRC)            end )  AS INSTITUTION_CODE_SRC,
(CASE WHEN TRIM(INSTITUTION_CODE_DEST)          IS NULL THEN '-' else trim(INSTITUTION_CODE_DEST)            end ) AS INSTITUTION_CODE_DEST,
(CASE WHEN trim(CUSTOMER_SRC)             IS NULL THEN '-' else trim(CUSTOMER_SRC)            end ) AS CUSTOMER_SRC , 
(CASE WHEN trim(CUSTOMER_DEST)            IS NULL THEN '-' else trim(CUSTOMER_DEST)           end ) AS CUSTOMER_DEST ,
(CASE WHEN trim(ACCOUNT_NO_SRC)           IS NULL THEN '-' else trim(ACCOUNT_NO_SRC)          end ) AS ACCOUNT_NO_SRC  , 
(CASE WHEN trim(ACCOUNT_NO_DEST)          IS NULL THEN '-' else trim(ACCOUNT_NO_DEST)         end ) AS ACCOUNT_NO_DEST ,
(CASE WHEN trim(T_DEST_CURRENCY_CODE)     IS NULL THEN '-' else trim(T_DEST_CURRENCY_CODE)    end ) AS T_DEST_CURRENCY_CODE ,
T_DEST_EXCH_RATE ,
(CASE WHEN TRIM(DEST_AMOUNT_CURRENCY) IS NULL THEN 0 ELSE  DEST_AMOUNT_CURRENCY END ) AS DEST_AMOUNT_CURRENCY                        ,
T_SRC_EXCH_RATE ,
(CASE WHEN TRIM(SRC_AMOUNT_CURRENCY) IS NULL THEN 0 ELSE SRC_AMOUNT_CURRENCY END) AS SRC_AMOUNT_CURRENCY ,
(CASE WHEN ENTITY_INCORPORATION_NUM IS NULL THEN '-' else ENTITY_INCORPORATION_NUM end ) AS ENTITY_INCORPORATION_NUM  ,
ACCOUNT_CLOSED_DATE ,
(CASE WHEN TRIM(ACCOUNT_CURR_CODE)        IS NULL THEN '-' else ACCOUNT_CURR_CODE        end ) AS ACCOUNT_CURR_CODE ,
(CASE WHEN trim(ACCOUNT_NAME)             IS NULL THEN '-' else ACCOUNT_NAME             end ) AS ACCOUNT_NAME  ,
ACCOUNT_BALANCE  ,
(CASE WHEN TRANSACTION_PARTICULARS  IS NULL THEN '-' else TRANSACTION_PARTICULARS  end ) AS TRANSACTION_PARTICULARS ,
(CASE WHEN T_SRC_CURRENCY_CODE      IS NULL THEN '-' else T_SRC_CURRENCY_CODE      end ) AS T_SRC_CURRENCY_CODE ,
VALUE_DATE_F , 
VALUE_DATE  ,
(CASE WHEN AUTHORIZED               IS NULL THEN '-' else AUTHORIZED               end ) AS AUTHORIZED ,
FROM_FUNDS_CODE ,
SOURCE_FUNDS_CODE ,
SUBMISSION_DATE ,
SUBMISSION_CODE ,
(CASE WHEN TRA IS NULL THEN '-' else TRA end ) as TRA
from(
SELECT distinct
(select bkcli.cli from bkcli where cli=bkheve.cli1)  as cli_id,
--bkcli.nomrest AS SURNAME_ORG_NAME,bkcli.pre AS FIRST_NAME,bkcli.midname AS MIDNAME,bkcli.cli AS REMITTER_RECEIVER,
--'BSIC GH LTD' AS BANK_NAME,'BK1007' AS INSTITUTION_CODE,
(select lib1 from bknom where ctab='001' and cacc =bkheve.age)AS BRANCH,
--'ETR' AS REPORT_TYPE,
(SELECT BKCLI.NAT FROM BKCLI WHERE CLI = BKHEVE.CLI1 ) AS cli_nat ,
case when (select bkcli.tcli  from bkcli where cli=bkheve.cli1)='1' then 'IND' else 'ORG' end AS CUSTOMER_TYPE,
--(select lib1 from bknom where ctab='033' and cacc =(select bkcli.nat  from bkcli where cli=bkheve.cli1)) AS NATIONALITY, -- from fct
--case when bkcli.tcli='1' then bkcli.dna else bkcli.datc end AS BIRTH_DATE,
(select lib1 from bknom where ctab='071' and cacc =(select bkcli.sec  from bkcli where cli=bkheve.cli1)) AS OCCUP_BUSINESS_LIB,
--(select lib1 from bknom where ctab='078' and cacc =(select bkcli.tid  from bkcli where cli=bkheve.cli1))  AS ID_TYPE_1,-- from fct
--bkcli.nrc AS REGISTRATION_NO,
--bkcli.nid AS ID_NO,bkcli.did AS ISSUE_DATE,bkcli.lid AS ISSUE_PLACE,bkcli.oid AS ISSUING_AUTHORITY,
--' ' AS SSNIT,
(select Replace(bkadcli.adr2,'&','AND ')||Replace(bkadcli.adr3,'&','AND ') from bkadcli where bkadcli.cli=bkheve.cli1 AND bkadcli.typ='D' ) AS RESIDENTAL_ADRESS,
(select bkadcli.bpos||bkadcli.spos from bkadcli where bkadcli.cli=bkheve.cli1 AND bkadcli.typ='D' ) AS POSTAL_ADRESS,
--(select bkadcli.ville from bkadcli where bkadcli.cli=bkheve.cli1 AND bkadcli.typ='D' ) AS TOWN,
--(select bkadcli.reg from bkadcli where bkadcli.cli=bkheve.cli1 AND bkadcli.typ='D' ) AS REGION,
--(select bktelcli.num from bktelcli where bktelcli.cli=bkheve.cli1 AND bktelcli.typ = '001' )  AS TEL,-- from fct
sysdate  AS SYS,
bkheve.nat as NAT ,
(select ( case 
when lib1 ='CASH MARGIN' THEN 'U' 
when lib1 ='CUST. ACC. SOLE PROPRIETOR' THEN 'A'
when lib1 ='INTERNAL ACCOUNT' THEN 'A'
when lib1 ='CONTROLLER & ACC. GENERAL' THEN 'A'
when lib1 ='POST OFFICES' THEN 'U'
when lib1 ='VOSTRO ACCOUNTS' THEN 'U'
when lib1 ='OTHER FINANCIAL INSTITUTIONS' THEN 'A'
when lib1 ='CUST. ACC. SME' THEN 'B'
when lib1 ='CUST. ACC. LARGE COMPANIES' THEN 'A'
when lib1 ='CUST. ACC. STATE CORP. & GOVT.' THEN 'A'
when lib1 ='CUST. ACC. NGO & ASSOCIATIONS' THEN 'A'
when lib1 ='CUST. ACC. COOPERATIVES' THEN 'A'
when lib1 ='CUST. ACC. OTHERS' THEN 'U'
when lib1 ='SAVING ACCOUNTS' THEN 'C'
when lib1 ='SAVING ACCOUNTS SPECIAL' THEN 'C'
when lib1 ='INTER. FINANCIAL INSTITUTIONS' THEN 'A'
when lib1 ='CUST. ACC. INDIVIDUALS' THEN 'B'
END ) from bknom where ctab='032' AND cacc=(select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp 
AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ))AS ACCOUNT_TYPE,
bkheve.ncp1 AS ACCOUNT_NO,
case when (select bkcom.cfe from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev )='O' then 'C' else 'A' end AS ACCOUNT_STATUS,
(select substr(to_char( bkcom.dou, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char( bkcom.dou, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) AS DATE_OPEN,
--' ' AS LINKED_ACC,
bkheve.eve AS TRANSACTION_NO,
substr(to_char(bkheve.dva1, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dva1, 'YYYY-MM-DDHH:MI:SS' ),11,18) AS TRANSACTION_DATE_F,
bkheve.dva1 as TRANSACTION_DATE,
substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),11,18) AS POSTING_DATE_F,
bkheve.dsai POSTING_DATE, 
'INWARD TRANSFERS' AS INWARD_OUTWARD,
'DEBIT' AS DB_CR,
(select lib2 from bknom where ctab='005' and cacc=bkheve.dev1 ) AS CURRENCY_TYPE,
(case when bkheve.nat  in ('VRMPER','VRTPER') then bkheve.mban WHEN ( dev1 <> '936' ) then bkheve.mht1 else bkheve.mon1 end ) AS AMOUNT_CURRENCY,
--bktau.tind AS EXCH_RATE,
(case when bkheve.nat in ('VRMPER','VRTPER') then bkheve.mban*bktau.tind 
else ( CASE
WHEN ( dev1 <> '936' )  THEN bkheve.mht1*bktau.tind else bkheve.mon1*bktau.tind END ) end ) AS GHS_EQUIV,
Replace(bkheve.lib1,'&','AND ') AS TRANSACTION_PURPOSE,
(select evuti.lib from evuti where evuti.cuti=bkheve.uti) AS PERSON_CONDUCTING,
trim(Replace(nom1,'&','AND '))||' '||trim(nom2) AS PARTY,
--case when bkheve.nat in ('SAITRF','VIRBAN','VIMBAN') then Replace(bkheve.nomb,'&','AND ') else Replace(bkheve.nom2,'&','AND ') end AS BENEFICIARY_NAME,
(CASE WHEN trim(bkheve.nom2) is not null then trim(bkheve.nom2)
     when trim(bkheve.nom2) is null and trim(bkheve.nom1) is not null 
	     then trim(bkheve.nom1) 
     when trim(bkheve.nom2) is null and trim(bkheve.nom1) is null and trim(bkheve.nomb) is not null
	     then trim(bkheve.nomb)
else
'-'  end) AS BENEFICIARY_NAME,
bkheve.adb1||bkheve.adb2 AS RESIDENTIAL_ADRESS,
--bkheve.adb3 AS POSTAL_ADRESS_1,
case when bkheve.nat in ('VIRMAG','VRTPER','VIMAGE','CHQBAN','AGEBAN','VCCDEV','VCDAUT','VCDTRF','VRMPER') then (select bkcli.oid  from bkcli where cli=bkheve.cli1) else ' ' end AS ISSUING_AUTH,
--'DATA MIGRATION' AS ID_TYPE,
bkheve.dateh AS DATE_HIST,
--case when bkheve.nat in ('VIMAGE','VIRMAG') then k.nid else ' ' end AS ID_NO_1,
--' ' AS FOCUSbu,
-----

case when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is not null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is not null then 'true' 
when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is not null then 'true'  
when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is null then 'false' 
else 'both_empty' end as CLI1_INF,
case when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is not null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is not null then 'true' 
 when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is not null then 'true' 
 when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is null then 'false' 
else 'both_empty' end as CLI2_INF,
case when ncp1 is not null then bkheve.nome else '-' end as institution_name_src,
case when ncp2 is not null then bkheve.nome else '-' end as institution_name_dest,
case when ncp1 is not null then bkheve.etab else '-' end as institution_code_src,
case when ncp2 is not null then bkheve.etab else '-' end as institution_code_dest,
case when trim(bkheve.cli1) is  not null then  trim(bkheve.cli1)
else (select trim(cli) from bkcom where bkcom.ncp = bkheve.ncp1 and bkcom.dev = bkheve.dev1 and bkcom.age = bkheve.age1 ) end
AS CUSTOMER_SRC, 
case when trim(bkheve.cli2) is  not null then  trim(bkheve.cli2)
else (select trim(cli) from bkcom where bkcom.ncp = bkheve.ncp2 and bkcom.dev = bkheve.dev2 and bkcom.age = bkheve.age2 ) end AS CUSTOMER_DEST,
case when trim(bkheve.ncp1) is not null then trim(bkheve.ncp1)  
when  trim(bkheve.ncp1) is null and trim(bkheve.comb) is not null then trim(bkheve.comb)
when trim(bkheve.ncp1) is null and trim(bkheve.comb) is  null then '-'
end AS ACCOUNT_NO_SRC , 
case when trim(bkheve.ncp2) is not null then trim(bkheve.ncp2)  
when  trim(bkheve.ncp2) is null and trim(bkheve.comb) is not null then trim(bkheve.comb)
when  trim(bkheve.ncp2) is null and trim(bkheve.comb) is  null then '-'
end AS ACCOUNT_NO_DEST,
bkheve.dev2 AS T_DEST_CURRENCY_CODE,
--destination amount
(select bktau.tind from bktau where dco =bkheve.dco and  dev = bkheve.dev2) AS T_DEST_EXCH_RATE,
case when ( dev2 <> '936') then bkheve.mht2 else bkheve.mon2 end AS DEST_AMOUNT_CURRENCY,
-----source
(select bktau.tind from bktau where dco =bkheve.dco and  dev = bkheve.dev1) AS T_SRC_EXCH_RATE,
case when ( dev2 <> '936') then bkheve.mht1 else bkheve.mon1 end AS SRC_AMOUNT_CURRENCY,
--bkemacli.email AS EMAIL,
(case when (select bkcli.tcli from bkcli where bkcli.cli=bkheve.cli1) ='1' 
then (case  
        when (select bkcli.dna from bkcli where bkcli.cli=bkheve.cli1) is not null
        	then (select  substr(to_char(bkcli.dna, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkcli.dna, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcli where bkcli.cli=bkheve.cli1) 
        else to_char((select bkcli.dna from bkcli where bkcli.cli=bkheve.cli1)) end )
else (case 
		when (select bkcli.datc from bkcli where bkcli.cli=bkheve.cli1) is not null
			then (select substr(to_char(  bkcli.datc, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(  bkcli.datc, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcli where bkcli.cli=bkheve.cli1) 
		else to_char((select bkcli.datc from bkcli where bkcli.cli=bkheve.cli1)) end)
end ) AS ENTITY_INCORPORATION_NUM ,
CASE WHEN  (select bkcom.dfe  from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) is not null then (select substr(to_char(bkcom.dfe, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkcom.dfe, 'YYYY-MM-DDHH:MI:SS' ),11,18)  from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev )
else TO_char((select bkcom.dfe  from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev )) END as ACCOUNT_CLOSED_DATE,
(select bkcom.dev from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) AS ACCOUNT_CURR_CODE,
(select  Replace(bkcom.inti,'&','AND ') from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) AS ACCOUNT_NAME ,
(select bkcom.sin from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) AS ACCOUNT_BALANCE ,
'INWARD TRANSFERS' AS TRANSACTION_PARTICULARS,
bkheve.dev1 AS T_SRC_CURRENCY_CODE,
substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),11,18) AS VALUE_DATE_F, 
bkheve.dco AS VALUE_DATE ,
bkheve.utf AS AUTHORIZED,
'O'   AS FROM_FUNDS_CODE,
'-'  AS SOURCE_FUNDS_CODE,
substr(to_char(sysdate,'YYYY-MM-DDHH:MI:SS' ),1,10) || 'T'||substr(to_char(sysdate,'YYYY-MM-DDHH:MI:SS' ),11,18) as SUBMISSION_DATE,
'E' as SUBMISSION_CODE,
bkheve.dev as TRA
FROM bkheve,bktau
WHERE bktau.dev=bkheve.dev1 AND bktau.dco=bkheve.dco
AND bkheve.nat in ('VIRMAG','VIRBAN','VRTPER','VIMAGE','SAITRF','VIMBAN','AGEBAN','VCCDEV','VCDAUT','VCDTRF','VRMPER','COMCHE')
AND bkheve.eta in ('VF', 'VA', 'FO') 
AND (
bkheve.mht*bktau.tind> (select 1000*a.tind from bktau a where a.dco=bkheve.dco  and a.dev='840') 
OR bkheve.mban*bktau.tind> (select 1000*a.tind from bktau a where a.dco=bkheve.dco and a.dev='840'))
and bkheve.ope  in (case when bkheve.exo1 = 'O' and bkheve.ope='511' then null else bkheve.ope end )
and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')
and substr(ncp1,1,3) <>'005'
union
SELECT
(select bkcli.cli from bkcli where cli=bkheve.cli2)  as cli_id,
--bkcli.nomrest AS SURNAME_ORG_NAME,bkcli.pre AS FIRST_NAME,bkcli.midname AS MIDNAME,bkcli.cli AS REMITTER_RECEIVER,
--'BSIC GH LTD' AS BANK_NAME,'BK1007' AS INSTITUTION_CODE,
(select lib1 from bknom where ctab='001' and cacc =bkheve.age)AS BRANCH,
--'ETR' AS REPORT_TYPE,
(SELECT BKCLI.NAT FROM BKCLI WHERE CLI = BKHEVE.CLI2 ) AS cli_nat ,
case when (select bkcli.tcli  from bkcli where cli=bkheve.cli2)='1' then 'IND' else 'ORG' end AS CUSTOMER_TYPE,
--(select lib1 from bknom where ctab='033' and cacc =(select bkcli.nat  from bkcli where cli=bkheve.cli2)) AS NATIONALITY, -- from fct
--case when bkcli.tcli='1' then bkcli.dna else bkcli.datc end AS BIRTH_DATE,
(select lib1 from bknom where ctab='071' and cacc =(select bkcli.sec  from bkcli where cli=bkheve.cli2)) AS OCCUP_BUSINESS_LIB,
--(select lib1 from bknom where ctab='078' and cacc =(select bkcli.tid  from bkcli where cli=bkheve.cli2))  AS ID_TYPE_1, -- from fct
--bkcli.nrc AS REGISTRATION_NO,
--bkcli.nid AS ID_NO,bkcli.did AS ISSUE_DATE,bkcli.lid AS ISSUE_PLACE,bkcli.oid AS ISSUING_AUTHORITY,
--' ' AS SSNIT,
(select Replace(bkadcli.adr2,'&','AND ')||Replace(bkadcli.adr3,'&','AND ') from bkadcli where bkadcli.cli=bkheve.cli2 AND bkadcli.typ='D' ) AS RESIDENTAL_ADRESS,
(select bkadcli.bpos||bkadcli.spos from bkadcli where bkadcli.cli=bkheve.cli2 AND bkadcli.typ='D' ) AS POSTAL_ADRESS,
--(select bkadcli.ville from bkadcli where bkadcli.cli=bkheve.cli2 AND bkadcli.typ='D' ) AS TOWN,
--(select bkadcli.reg from bkadcli where bkadcli.cli=bkheve.cli2 AND bkadcli.typ='D' ) AS REGION,
--(select bktelcli.num from bktelcli where bktelcli.cli=bkheve.cli2 AND bktelcli.typ = '001' )  AS TEL, -- from fct
sysdate AS SYS,
bkheve.nat as NAT ,
(select ( case 
when lib1 ='CASH MARGIN' THEN 'U' 
when lib1 ='CUST. ACC. SOLE PROPRIETOR' THEN 'A'
when lib1 ='INTERNAL ACCOUNT' THEN 'A'
when lib1 ='CONTROLLER & ACC. GENERAL' THEN 'A'
when lib1 ='POST OFFICES' THEN 'U' 
when lib1 ='VOSTRO ACCOUNTS' THEN 'U' 
when lib1 ='OTHER FINANCIAL INSTITUTIONS' THEN 'A'
when lib1 ='CUST. ACC. SME' THEN 'B'
when lib1 ='CUST. ACC. LARGE COMPANIES' THEN 'A'
when lib1 ='CUST. ACC. STATE CORP. & GOVT.' THEN 'A'
when lib1 ='CUST. ACC. NGO & ASSOCIATIONS' THEN 'A'
when lib1 ='CUST. ACC. COOPERATIVES' THEN 'A'
when lib1 ='CUST. ACC. OTHERS' THEN 'U' 
when lib1 ='SAVING ACCOUNTS' THEN 'C'
when lib1 ='SAVING ACCOUNTS SPECIAL' THEN 'C'
when lib1 ='INTER. FINANCIAL INSTITUTIONS' THEN 'A'
when lib1 ='CUST. ACC. INDIVIDUALS' THEN 'B'
END ) 
from bknom where ctab='032' AND cacc=(select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ))AS ACCOUNT_TYPE,
bkheve.ncp2 AS ACCOUNT_NO,
case when (select bkcom.cfe from bkcom where  bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev )='O' then 'C' else 'A' end AS ACCOUNT_STATUS,
(select substr(to_char( bkcom.dou, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char( bkcom.dou, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) AS DATE_OPEN,
--' ' AS LINKED_ACC,
bkheve.eve AS TRANSACTION_NO,
substr(to_char(bkheve.dva2, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dva2, 'YYYY-MM-DDHH:MI:SS' ),11,18) AS TRANSACTION_DATE_F,
bkheve.dva2 AS TRANSACTION_DATE,
substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),11,18) AS POSTING_DATE_F,
bkheve.dsai AS POSTING_DATE , 
'OUTWARD TRANSFERS' AS INWARD_OUTWARD,
'CREDIT' AS DB_CR,
(select lib2 from bknom where ctab='005' and cacc=bkheve.dev2 ) AS CURRENCY_TYPE,
case when ( dev2 <> '936' ) then bkheve.mht2 else bkheve.mon2 end AS AMOUNT_CURRENCY,
--bktau.tind AS EXCH_RATE,
(case WHEN ( dev2 <> '936' )  THEN bkheve.mht2*bktau.tind 
ELSE  bkheve.mon2*bktau.tind  end) AS GHS_EQUIV,
Replace(bkheve.lib1,'&','AND ') AS TRANSACTION_PURPOSE,
(select evuti.lib from evuti where evuti.cuti=bkheve.uti) AS PERSON_CONDUCTING,
trim(nom1)||' '||trim(nom2) AS PARTY,
--case when bkheve.nat in ('SAIRPT','COMVIR','PRELBS') then Replace(bkheve.nomb,'&','AND ') else Replace(bkheve.nom2,'&','AND ') end AS BENEFICIARY_NAME,
(CASE WHEN trim(bkheve.nom2) is not null then trim(bkheve.nom2)
     when trim(bkheve.nom2) is null and trim(bkheve.nom1) is not null 
	     then trim(bkheve.nom1) 
     when trim(bkheve.nom2) is null and trim(bkheve.nom1) is null and trim(bkheve.nomp) is not null
	     then trim(bkheve.nomp)
else
'-'  end) AS BENEFICIARY_NAME,
case when bkheve.nat in ('VIRMAG','VRTPER','VIMAGE','CHQBAN','AGEBAN','VCCDEV','VCDAUT','VCDTRF','VRMPER') then (select bkcli.oid  from bkcli where cli=bkheve.cli2) else ' ' end AS ISSUING_AUTH,
bkheve.adb1||bkheve.adb2 AS RESIDENTIAL_ADRESS,
--bkheve.adb3 AS POSTAL_ADRESS_1,
bkheve.dateh AS DATE_HIST,
--'DATA MIGRATION' AS ID_TYPE,case when bkheve.nat in ('VIMCAI','VIRASP') then k.nid else ' ' end AS ID_NO_1,
--' ' AS FOCUS,
-----
case when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is not null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is not null then 'true' 
when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is not null then 'true'  
when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is null then 'false' 
else 'both_empty' end as CLI1_INF,
case when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is not null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is not null then 'true' 
 when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is not null then 'true' 
 when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is null then 'false' 
else 'both_empty' end as CLI2_INF,
case when ncp1 is not null then bkheve.nome else '-' end as institution_name_src,
case when ncp2 is not null then bkheve.nome else '-' end as institution_name_dest,
case when ncp1 is not null then bkheve.etab else '-' end as institution_code_src,
case when ncp2 is not null then bkheve.etab else '-' end as institution_code_dest,
case when trim(bkheve.cli1) is  not null then  trim(bkheve.cli1)
else (select trim(cli) from bkcom where bkcom.ncp = bkheve.ncp1 and bkcom.dev = bkheve.dev1 and bkcom.age = bkheve.age1 ) end
AS CUSTOMER_SRC, 
case when trim(bkheve.cli2) is  not null then  trim(bkheve.cli2)
else (select trim(cli) from bkcom where bkcom.ncp = bkheve.ncp2 and bkcom.dev = bkheve.dev2 and bkcom.age = bkheve.age2 ) end AS CUSTOMER_DEST,
case when trim(bkheve.ncp1) is not null then trim(bkheve.ncp1)  
when  trim(bkheve.ncp1) is null and trim(bkheve.comb) is not null then trim(bkheve.comb)
when trim(bkheve.ncp1) is null and trim(bkheve.comb) is  null then '-'
end AS ACCOUNT_NO_SRC , 
case when trim(bkheve.ncp2) is not null then trim(bkheve.ncp2)  
when  trim(bkheve.ncp2) is null and trim(bkheve.comb) is not null then trim(bkheve.comb)
when  trim(bkheve.ncp2) is null and trim(bkheve.comb) is  null then '-'
end AS ACCOUNT_NO_DEST,
bkheve.dev2 AS T_DEST_CURRENCY_CODE,
--destination amount
(select bktau.tind from bktau where dco =bkheve.dco and  dev = bkheve.dev2) AS T_DEST_EXCH_RATE,
case when ( dev2 <> '936' ) then bkheve.mht2 else bkheve.mon2 end AS DEST_AMOUNT_CURRENCY,
-----source
(select bktau.tind from bktau where dco =bkheve.dco and  dev = bkheve.dev1) AS T_SRC_EXCH_RATE,
case when ( dev2 <> '936') then bkheve.mht1 else bkheve.mon1 end AS SRC_AMOUNT_CURRENCY,
--bkemacli.email AS EMAIL,
(case when (select bkcli.tcli from bkcli where bkcli.cli=bkheve.cli2) ='1' 
then case 
		when (select bkcli.dna from bkcli where bkcli.cli=bkheve.cli2) is not null
			then (select  substr(to_char(bkcli.dna, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkcli.dna, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcli where bkcli.cli=bkheve.cli2) 
		else to_char((select bkcli.dna from bkcli where bkcli.cli=bkheve.cli2)) end 
else case 
		when (select bkcli.datc from bkcli where bkcli.cli=bkheve.cli2) is not null
			then (select substr(to_char(  bkcli.datc, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(  bkcli.datc, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcli where bkcli.cli=bkheve.cli2) 
		else to_char((select bkcli.datc from bkcli where bkcli.cli=bkheve.cli2)) end
end ) AS ENTITY_INCORPORATION_NUM ,
CASE WHEN  (select bkcom.dfe  from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) is not null then (select substr(to_char(bkcom.dfe, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkcom.dfe, 'YYYY-MM-DDHH:MI:SS' ),11,18)  from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev )
else to_char((select bkcom.dfe  from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev )) END as ACCOUNT_CLOSED_DATE,
(select bkcom.dev from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) AS ACCOUNT_CURR_CODE,
(select Replace(bkcom.inti,'&','AND ') from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) AS ACCOUNT_NAME ,
(select bkcom.sin from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) AS ACCOUNT_BALANCE ,
'OUTWARD TRANSFERS' AS TRANSACTION_PARTICULARS,
bkheve.dev1 AS T_SRC_CURRENCY_CODE,
substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),11,18)  AS VALUE_DATE_F, 
bkheve.dco AS VALUE_DATE ,
bkheve.utf AS AUTHORIZED,
'-'   AS FROM_FUNDS_CODE,
'O'  AS SOURCE_FUNDS_CODE,
substr(to_char(sysdate,'YYYY-MM-DDHH:MI:SS' ),1,10) || 'T'||substr(to_char(sysdate,'YYYY-MM-DDHH:MI:SS' ),11,18) as SUBMISSION_DATE,
'E' as SUBMISSION_CODE,
 bkheve.dev as TRA
FROM bkheve,bktau
WHERE    bktau.dev=bkheve.dev2 AND bktau.dco=bkheve.dco
AND ( bkheve.nat in ('RCHINT','VIMCAI','COMVIR','SAIRPT','PRELCA','PRELAG','PRELBS','PRELEV','AGEVIR','AGEPRL','VCCAUT','VCCTRF','RCAINT','RCHBSP','TRBANA')
-- pour �liminer les doublon 
or ( eta = 'FO'  AND bkheve.intr <> 'C' and bkheve.orig <> 'S' and bkheve.ceb <>'O' and bkheve.plb <>'O' and bkheve.NAT = 'VIRASP'))
AND bkheve.eta in ('VF', 'VA', 'FO') AND mht*bktau.tind>=  (select 1000*a.tind from bktau a where a.dco=bkheve.dco  and a.dev='840')
and bkheve.ope  in (case when bkheve.exo1 = 'O' and bkheve.ope='511' then null else bkheve.ope end )
and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')
and substr(ncp2,1,3) <> '005'
union
  SELECT distinct
(select bkcli.cli from bkcli where cli=bkheve.cli1)  as cli_id,
--bkcli.nomrest AS SURNAME_ORG_NAME,bkcli.pre AS FIRST_NAME,bkcli.midname AS MIDNAME,bkcli.cli AS REMITTER_RECEIVER,
--'BSIC GH LTD' AS BANK_NAME,'BK1007' AS INSTITUTION_CODE,
(select lib1 from bknom where ctab='001' and cacc =bkheve.age)AS BRANCH,
--'ETR' AS REPORT_TYPE,
(SELECT BKCLI.NAT FROM BKCLI WHERE CLI = BKHEVE.CLI1 ) AS cli_nat ,
case when (select bkcli.tcli  from bkcli where cli=bkheve.cli1)='1' then 'IND' else 'ORG' end AS CUSTOMER_TYPE,
--(select lib1 from bknom where ctab='033' and cacc =(select bkcli.nat  from bkcli where cli=bkheve.cli1)) AS NATIONALITY, -- from fct
--case when bkcli.tcli='1' then bkcli.dna else bkcli.datc end AS BIRTH_DATE,
(select lib1 from bknom where ctab='071' and cacc =(select bkcli.sec  from bkcli where cli=bkheve.cli1)) AS OCCUP_BUSINESS_LIB,
--(select lib1 from bknom where ctab='078' and cacc =(select bkcli.tid  from bkcli where cli=bkheve.cli1))  AS ID_TYPE_1, -- from fct
--bkcli.nrc AS REGISTRATION_NO,
--bkcli.nid AS ID_NO,bkcli.did AS ISSUE_DATE,bkcli.lid AS ISSUE_PLACE,bkcli.oid AS ISSUING_AUTHORITY,
--' ' AS SSNIT,
(select Replace(bkadcli.adr2,'&','AND ')||Replace(bkadcli.adr3,'&','AND ') from bkadcli where bkadcli.cli=bkheve.cli1 AND bkadcli.typ='D' ) AS RESIDENTAL_ADRESS,
(select bkadcli.bpos||bkadcli.spos from bkadcli where bkadcli.cli=bkheve.cli1 AND bkadcli.typ='D' ) AS POSTAL_ADRESS,
--(select bkadcli.ville from bkadcli where bkadcli.cli=bkheve.cli1 AND bkadcli.typ='D' ) AS TOWN,
--(select bkadcli.reg from bkadcli where bkadcli.cli=bkheve.cli1 AND bkadcli.typ='D' ) AS REGION,
--(select bktelcli.num from bktelcli where bktelcli.cli=bkheve.cli1 AND bktelcli.typ = '001' )  AS TEL,-- from fct
sysdate  AS SYS,
bkheve.nat as NAT ,
(select ( case 
when lib1 ='CASH MARGIN' THEN 'U' 
when lib1 ='CUST. ACC. SOLE PROPRIETOR' THEN 'A'
when lib1 ='INTERNAL ACCOUNT' THEN 'A'
when lib1 ='CONTROLLER & ACC. GENERAL' THEN 'A'
when lib1 ='POST OFFICES' THEN 'U' 
when lib1 ='VOSTRO ACCOUNTS' THEN 'U' 
when lib1 ='OTHER FINANCIAL INSTITUTIONS' THEN 'A'
when lib1 ='CUST. ACC. SME' THEN 'B'
when lib1 ='CUST. ACC. LARGE COMPANIES' THEN 'A'
when lib1 ='CUST. ACC. STATE CORP. & GOVT.' THEN 'A'
when lib1 ='CUST. ACC. NGO & ASSOCIATIONS' THEN 'A'
when lib1 ='CUST. ACC. COOPERATIVES' THEN 'A'
when lib1 ='CUST. ACC. OTHERS' THEN 'U' 
when lib1 ='SAVING ACCOUNTS' THEN 'C'
when lib1 ='SAVING ACCOUNTS SPECIAL' THEN 'C'
when lib1 ='INTER. FINANCIAL INSTITUTIONS' THEN 'A'
when lib1 ='CUST. ACC. INDIVIDUALS' THEN 'B'
END )
 from bknom where ctab='032' AND cacc=(select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp 
AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ))AS ACCOUNT_TYPE,
bkheve.ncp1 AS ACCOUNT_NO,
case when (select bkcom.cfe from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev )='O' then 'C' else 'A' end AS ACCOUNT_STATUS,
(select substr(to_char( bkcom.dou, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char( bkcom.dou, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) AS DATE_OPEN,
--' ' AS LINKED_ACC,
bkheve.eve AS TRANSACTION_NO,
substr(to_char(bkheve.dva1, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dva1, 'YYYY-MM-DDHH:MI:SS' ),11,18) AS TRANSACTION_DATE_F,
bkheve.dva1 as TRANSACTION_DATE,
substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),11,18) AS POSTING_DATE_F,
bkheve.dsai POSTING_DATE, 
'INWARD TRANSFERS' AS INWARD_OUTWARD,
'DEBIT' AS DB_CR,
(select lib2 from bknom where ctab='005' and cacc=bkheve.dev1 ) AS CURRENCY_TYPE,
(case when bkheve.nat  in ('VRMPER','VRTPER') then bkheve.mban 
WHEN ( dev1 <> '936' ) then bkheve.mht1 else bkheve.mon1 end ) AS AMOUNT_CURRENCY,
--bktau.tind AS EXCH_RATE,
(case when bkheve.nat in ('VRMPER','VRTPER') then bkheve.mban*bktau.tind 
else ( CASE
WHEN ( dev1 <> '936' )  THEN bkheve.mht1*bktau.tind else bkheve.mon1*bktau.tind END ) end ) AS GHS_EQUIV,
Replace(bkheve.lib1,'&','AND ') AS TRANSACTION_PURPOSE,
(select evuti.lib from evuti where evuti.cuti=bkheve.uti) AS PERSON_CONDUCTING,
trim(nom1)||' '||trim(nom2) AS PARTY,
--case when bkheve.nat in ('SAITRF','VIRBAN','VIMBAN') then Replace(bkheve.nomb,'&','AND ') else Replace(bkheve.nom2,'&','AND ') end AS BENEFICIARY_NAME,
(CASE WHEN trim(bkheve.nom2) is not null then trim(bkheve.nom2)
     when trim(bkheve.nom2) is null and trim(bkheve.nom1) is not null 
	     then trim(bkheve.nom1) 
     when trim(bkheve.nom2) is null and trim(bkheve.nom1) is null and trim(bkheve.nomp) is not null
	     then trim(bkheve.nomp)
else
'-'  end) AS BENEFICIARY_NAME,
bkheve.adb1||bkheve.adb2 AS RESIDENTIAL_ADRESS,
--bkheve.adb3 AS POSTAL_ADRESS_1,
case when bkheve.nat in ('VIRMAG','VRTPER','VIMAGE','CHQBAN','AGEBAN','VCCDEV','VCDAUT','VCDTRF','VRMPER') then (select bkcli.oid  from bkcli where cli=bkheve.cli1) else ' ' end AS ISSUING_AUTH,
--'DATA MIGRATION' AS ID_TYPE,
bkheve.dateh AS DATE_HIST,
--case when bkheve.nat in ('VIMAGE','VIRMAG') then k.nid else ' ' end AS ID_NO_1,
--' ' AS FOCUSbu,
-----
case when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is not null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is not null then 'true' 
when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is not null then 'true'  
when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is null then 'false' 
else 'both_empty' end as CLI1_INF,
case when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is not null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is not null then 'true' 
 when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is not null then 'true' 
 when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is null then 'false' 
else 'both_empty' end as CLI2_INF,
case when ncp1 is not null then bkheve.nome else '-' end as institution_name_src,
case when ncp2 is not null then bkheve.nome else '-' end as institution_name_dest,
case when ncp1 is not null then bkheve.etab else '-' end as institution_code_src,
case when ncp2 is not null then bkheve.etab else '-' end as institution_code_dest,
case when trim(bkheve.cli1) is  not null then  trim(bkheve.cli1)
else (select trim(cli) from bkcom where bkcom.ncp = bkheve.ncp1 and bkcom.dev = bkheve.dev1 and bkcom.age = bkheve.age1 ) end
AS CUSTOMER_SRC, 
case when trim(bkheve.cli2) is  not null then  trim(bkheve.cli2)
else (select trim(cli) from bkcom where bkcom.ncp = bkheve.ncp2 and bkcom.dev = bkheve.dev2 and bkcom.age = bkheve.age2 ) end AS CUSTOMER_DEST,
case when trim(bkheve.ncp1) is not null then trim(bkheve.ncp1)  
when  trim(bkheve.ncp1) is null and trim(bkheve.comb) is not null then trim(bkheve.comb)
when trim(bkheve.ncp1) is null and trim(bkheve.comb) is  null then '-'
end AS ACCOUNT_NO_SRC , 
case when trim(bkheve.ncp2) is not null then trim(bkheve.ncp2)  
when  trim(bkheve.ncp2) is null and trim(bkheve.comb) is not null then trim(bkheve.comb)
when  trim(bkheve.ncp2) is null and trim(bkheve.comb) is  null then '-'
end AS ACCOUNT_NO_DEST,
bkheve.dev2 AS T_DEST_CURRENCY_CODE,
--destination amount
(select bktau.tind from bktau where dco =bkheve.dco and  dev = bkheve.dev2) AS T_DEST_EXCH_RATE,
case when ( dev2 <> '936') then bkheve.mht2 else bkheve.mon2 end AS DEST_AMOUNT_CURRENCY,
-----source
(select bktau.tind from bktau where dco =bkheve.dco and  dev = bkheve.dev1) AS T_SRC_EXCH_RATE,
case when ( dev2 <> '936') then bkheve.mht1 else bkheve.mon1 end AS SRC_AMOUNT_CURRENCY,
--bkemacli.email AS EMAIL,
(case when (select bkcli.tcli from bkcli where bkcli.cli=bkheve.cli1) ='1' 
then (case  
        when (select bkcli.dna from bkcli where bkcli.cli=bkheve.cli1) is not null
        	then (select  substr(to_char(bkcli.dna, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkcli.dna, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcli where bkcli.cli=bkheve.cli1) 
        else to_char((select bkcli.dna from bkcli where bkcli.cli=bkheve.cli1)) end )
else (case 
		when (select bkcli.datc from bkcli where bkcli.cli=bkheve.cli1) is not null
			then (select substr(to_char(  bkcli.datc, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(  bkcli.datc, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcli where bkcli.cli=bkheve.cli1) 
		else to_char((select bkcli.datc from bkcli where bkcli.cli=bkheve.cli1)) end)
end ) AS ENTITY_INCORPORATION_NUM ,
CASE WHEN  (select bkcom.dfe  from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) is not null then (select substr(to_char(bkcom.dfe, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkcom.dfe, 'YYYY-MM-DDHH:MI:SS' ),11,18)  from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev )
else TO_char((select bkcom.dfe  from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev )) END as ACCOUNT_CLOSED_DATE,
(select bkcom.dev from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) AS ACCOUNT_CURR_CODE,
(select Replace(bkcom.inti,'&','AND ') from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) AS ACCOUNT_NAME ,
(select bkcom.sin from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) AS ACCOUNT_BALANCE ,
'INWARD TRANSFERS' AS TRANSACTION_PARTICULARS,
bkheve.dev1 AS T_SRC_CURRENCY_CODE,
substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),11,18) AS VALUE_DATE_F, 
bkheve.dco AS VALUE_DATE ,
bkheve.utf AS AUTHORIZED,
'O'   AS FROM_FUNDS_CODE,
'-'  AS SOURCE_FUNDS_CODE,
substr(to_char(sysdate,'YYYY-MM-DDHH:MI:SS' ),1,10) || 'T'||substr(to_char(sysdate,'YYYY-MM-DDHH:MI:SS' ),11,18) as SUBMISSION_DATE,
'E' as SUBMISSION_CODE,
bkheve.dev as TRA
FROM bkheve,bktau
WHERE bktau.dev=bkheve.dev1 AND bktau.dco=bkheve.dco
AND bkheve.nat in ('VIRMAG','VIRBAN','VRTPER','VIMAGE','SAITRF','VIMBAN','AGEBAN','VCCDEV','VCDAUT','VCDTRF','VRMPER','COMCHE')
AND bkheve.eta in ('VF', 'VA', 'FO') 
AND (
bkheve.mht*bktau.tind> (select 1000*a.tind from bktau a where a.dco=bkheve.dco  and a.dev='840') 
OR bkheve.mban*bktau.tind> (select 1000*a.tind from bktau a where a.dco=bkheve.dco and a.dev='840'))
and bkheve.ope  in (case when bkheve.exo1 = 'O' and bkheve.ope='511' then null else bkheve.ope end )
and (select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp AND bkheve.age1=bkcom.age AND bkheve.dev1=bkcom.dev ) not in ('100')
and  substr(ncp1,1,3) = '005' and (((select DISTINCT bkcli.sec from bkcli where cli=bkheve.cli1) <> '10740') AND  bkheve.lib1 not like '%SALA%' )
union
  SELECT distinct
(select bkcli.cli from bkcli where cli=bkheve.cli2)  as cli_id,
--bkcli.nomrest AS SURNAME_ORG_NAME,bkcli.pre AS FIRST_NAME,bkcli.midname AS MIDNAME,bkcli.cli AS REMITTER_RECEIVER,
--'BSIC GH LTD' AS BANK_NAME,'BK1007' AS INSTITUTION_CODE,
(select lib1 from bknom where ctab='001' and cacc =bkheve.age)AS BRANCH,
--'ETR' AS REPORT_TYPE,
(SELECT BKCLI.NAT FROM BKCLI WHERE CLI = BKHEVE.cli2 ) AS cli_nat ,
case when (select bkcli.tcli  from bkcli where cli=bkheve.cli2)='1' then 'IND' else 'ORG' end AS CUSTOMER_TYPE,
--(select lib1 from bknom where ctab='033' and cacc =(select bkcli.nat  from bkcli where cli=bkheve.cli2)) AS NATIONALITY,
--case when bkcli.tcli='1' then bkcli.dna else bkcli.datc end AS BIRTH_DATE,
(select lib1 from bknom where ctab='071' and cacc =(select bkcli.sec  from bkcli where cli=bkheve.cli2)) AS OCCUP_BUSINESS_LIB,
--(select lib1 from bknom where ctab='078' and cacc =(select bkcli.tid  from bkcli where cli=bkheve.cli2))  AS ID_TYPE_1,
--bkcli.nrc AS REGISTRATION_NO,
--bkcli.nid AS ID_NO,bkcli.did AS ISSUE_DATE,bkcli.lid AS ISSUE_PLACE,bkcli.oid AS ISSUING_AUTHORITY,
--' ' AS SSNIT,
(select Replace(bkadcli.adr2,'&','AND ')||Replace(bkadcli.adr3,'&','AND ') from bkadcli where bkadcli.cli=bkheve.cli2 AND bkadcli.typ='D' ) AS RESIDENTAL_ADRESS,
(select bkadcli.bpos||bkadcli.spos from bkadcli where bkadcli.cli=bkheve.cli2 AND bkadcli.typ='D' ) AS POSTAL_ADRESS,
--(select bkadcli.ville from bkadcli where bkadcli.cli=bkheve.cli2 AND bkadcli.typ='D' ) AS TOWN,
--(select bkadcli.reg from bkadcli where bkadcli.cli=bkheve.cli2 AND bkadcli.typ='D' ) AS REGION,
--(select bktelcli.num from bktelcli where bktelcli.cli=bkheve.cli2 AND bktelcli.typ = '001' )  AS TEL, 
sysdate  AS SYS,
bkheve.nat as NAT ,
(select ( case 
when lib1 ='CASH MARGIN' THEN 'U' 
when lib1 ='CUST. ACC. SOLE PROPRIETOR' THEN 'A'
when lib1 ='INTERNAL ACCOUNT' THEN 'A'
when lib1 ='CONTROLLER & ACC. GENERAL' THEN 'A'
when lib1 ='POST OFFICES' THEN 'U' 
when lib1 ='VOSTRO ACCOUNTS' THEN 'U' 
when lib1 ='OTHER FINANCIAL INSTITUTIONS' THEN 'A'
when lib1 ='CUST. ACC. SME' THEN 'B'
when lib1 ='CUST. ACC. LARGE COMPANIES' THEN 'A'
when lib1 ='CUST. ACC. STATE CORP. & GOVT.' THEN 'A'
when lib1 ='CUST. ACC. NGO & ASSOCIATIONS' THEN 'A'
when lib1 ='CUST. ACC. COOPERATIVES' THEN 'A'
when lib1 ='CUST. ACC. OTHERS' THEN 'U' 
when lib1 ='SAVING ACCOUNTS' THEN 'C'
when lib1 ='SAVING ACCOUNTS SPECIAL' THEN 'C'
when lib1 ='INTER. FINANCIAL INSTITUTIONS' THEN 'A'
when lib1 ='CUST. ACC. INDIVIDUALS' THEN 'B'
END )
 from bknom where ctab='032' AND cacc=(select bkcom.typ from bkcom where bkheve.ncp1=bkcom.ncp 
AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ))AS ACCOUNT_TYPE,
bkheve.ncp2 AS ACCOUNT_NO,
case when (select bkcom.cfe from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev )='O' then 'C' else 'A' end AS ACCOUNT_STATUS,
(select substr(to_char( bkcom.dou, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char( bkcom.dou, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) AS DATE_OPEN,
--' ' AS LINKED_ACC,
bkheve.eve AS TRANSACTION_NO,
substr(to_char(bkheve.dva1, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dva1, 'YYYY-MM-DDHH:MI:SS' ),11,18) AS TRANSACTION_DATE_F,
bkheve.dva1 as TRANSACTION_DATE,
substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),11,18) AS POSTING_DATE_F,
bkheve.dsai POSTING_DATE, 
'INWARD TRANSFERS' AS INWARD_OUTWARD,
'DEBIT' AS DB_CR,
(select lib2 from bknom where ctab='005' and cacc=bkheve.dev2 ) AS CURRENCY_TYPE,
(case when bkheve.nat  in ('VRMPER','VRTPER') then bkheve.mban 
WHEN ( dev2 <> '936' ) then bkheve.mht1 else bkheve.mon1 end ) AS AMOUNT_CURRENCY,
--bktau.tind AS EXCH_RATE,
(case when bkheve.nat in ('VRMPER','VRTPER') then bkheve.mban*bktau.tind 
else ( CASE
WHEN ( dev2 <> '936' )  THEN bkheve.mht1*bktau.tind else bkheve.mon1*bktau.tind END ) end ) AS GHS_EQUIV,
Replace(bkheve.lib1,'&','AND ') AS TRANSACTION_PURPOSE,
(select evuti.lib from evuti where evuti.cuti=bkheve.uti) AS PERSON_CONDUCTING,
trim(nom1)||' '||trim(nom2) AS PARTY,
--case when bkheve.nat in ('SAITRF','VIRBAN','VIMBAN') then Replace(bkheve.nomb,'&','AND ') else Replace(bkheve.nom2,'&','AND ') end AS BENEFICIARY_NAME,
(CASE WHEN trim(bkheve.nom2) is not null then trim(bkheve.nom2)
     when trim(bkheve.nom2) is null and trim(bkheve.nom1) is not null 
	     then trim(bkheve.nom1) 
     when trim(bkheve.nom2) is null and trim(bkheve.nom1) is null and trim(bkheve.nomp) is not null
	     then trim(bkheve.nomp)
else
'-'  end) AS BENEFICIARY_NAME,
bkheve.adb1||bkheve.adb2 AS RESIDENTIAL_ADRESS,
--bkheve.adb3 AS POSTAL_ADRESS_1,
case when bkheve.nat in ('VIRMAG','VRTPER','VIMAGE','CHQBAN','AGEBAN','VCCDEV','VCDAUT','VCDTRF','VRMPER') then (select bkcli.oid  from bkcli where cli=bkheve.cli2) else ' ' end AS ISSUING_AUTH,
--'DATA MIGRATION' AS ID_TYPE,
bkheve.dateh AS DATE_HIST,
--case when bkheve.nat in ('VIMAGE','VIRMAG') then k.nid else ' ' end AS ID_NO_1,
--' ' AS FOCUSbu,
-----
case when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is not null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is not null then 'true' 
when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is not null then 'true'  
when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is null then 'false' 
else 'both_empty' end as CLI1_INF,
case when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is not null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is not null then 'true' 
 when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is not null then 'true' 
 when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is null then 'false' 
else 'both_empty' end as CLI2_INF,
case when ncp1 is not null then bkheve.nome else '-' end as institution_name_src,
case when ncp2 is not null then bkheve.nome else '-' end as institution_name_dest,
case when ncp1 is not null then bkheve.etab else '-' end as institution_code_src,
case when ncp2 is not null then bkheve.etab else '-' end as institution_code_dest,
case when trim(bkheve.cli1) is  not null then  trim(bkheve.cli1)
else (select trim(cli) from bkcom where bkcom.ncp = bkheve.ncp1 and bkcom.dev = bkheve.dev1 and bkcom.age = bkheve.age1 ) end
AS CUSTOMER_SRC, 
case when trim(bkheve.cli2) is  not null then  trim(bkheve.cli2)
else (select trim(cli) from bkcom where bkcom.ncp = bkheve.ncp2 and bkcom.dev = bkheve.dev2 and bkcom.age = bkheve.age2 ) end AS CUSTOMER_DEST,
case when trim(bkheve.ncp1) is not null then trim(bkheve.ncp1)  
when  trim(bkheve.ncp1) is null and trim(bkheve.comb) is not null then trim(bkheve.comb)
when trim(bkheve.ncp1) is null and trim(bkheve.comb) is  null then '-'
end AS ACCOUNT_NO_SRC ,  
case when trim(bkheve.ncp2) is not null then trim(bkheve.ncp2)  
when  trim(bkheve.ncp2) is null and trim(bkheve.comb) is not null then trim(bkheve.comb)
when  trim(bkheve.ncp2) is null and trim(bkheve.comb) is  null then '-'
end AS ACCOUNT_NO_DEST,
bkheve.dev2 AS T_DEST_CURRENCY_CODE,
--destination amount
(select bktau.tind from bktau where dco =bkheve.dco and  dev = bkheve.dev2) AS T_DEST_EXCH_RATE,
case when ( dev2 <> '936') then bkheve.mht2 else bkheve.mon2 end AS DEST_AMOUNT_CURRENCY,
-----source
(select bktau.tind from bktau where dco =bkheve.dco and  dev = bkheve.dev2) AS T_SRC_EXCH_RATE,
case when ( dev2 <> '936') then bkheve.mht1 else bkheve.mon1 end AS SRC_AMOUNT_CURRENCY,
--bkemacli.email AS EMAIL,
(case when (select bkcli.tcli from bkcli where bkcli.cli=bkheve.cli2) ='1' 
then (case  
        when (select bkcli.dna from bkcli where bkcli.cli=bkheve.cli2) is not null
        	then (select  substr(to_char(bkcli.dna, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkcli.dna, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcli where bkcli.cli=bkheve.cli2) 
        else to_char((select bkcli.dna from bkcli where bkcli.cli=bkheve.cli2)) end )
else (case 
		when (select bkcli.datc from bkcli where bkcli.cli=bkheve.cli2) is not null
			then (select substr(to_char(  bkcli.datc, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(  bkcli.datc, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcli where bkcli.cli=bkheve.cli2) 
		else to_char((select bkcli.datc from bkcli where bkcli.cli=bkheve.cli2)) end)
end ) AS ENTITY_INCORPORATION_NUM ,
CASE WHEN  (select bkcom.dfe  from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) is not null then (select substr(to_char(bkcom.dfe, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkcom.dfe, 'YYYY-MM-DDHH:MI:SS' ),11,18)  from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev )
else TO_char((select bkcom.dfe  from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev )) END as ACCOUNT_CLOSED_DATE,
(select bkcom.dev from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) AS ACCOUNT_CURR_CODE,
(select Replace(bkcom.inti,'&','AND ') from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) AS ACCOUNT_NAME ,
(select bkcom.sin from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) AS ACCOUNT_BALANCE ,
'INWARD TRANSFERS' AS TRANSACTION_PARTICULARS,
bkheve.dev2 AS T_SRC_CURRENCY_CODE,
substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),11,18) AS VALUE_DATE_F, 
bkheve.dco AS VALUE_DATE ,
bkheve.utf AS AUTHORIZED,
'O'   AS FROM_FUNDS_CODE,
'-'  AS SOURCE_FUNDS_CODE,
substr(to_char(sysdate,'YYYY-MM-DDHH:MI:SS' ),1,10) || 'T'||substr(to_char(sysdate,'YYYY-MM-DDHH:MI:SS' ),11,18) as SUBMISSION_DATE,
'E' as SUBMISSION_CODE,
bkheve.dev as TRA
FROM bkheve,bktau
WHERE bktau.dev=bkheve.dev2 AND bktau.dco=bkheve.dco
AND bkheve.nat in ('VIRMAG','VIRBAN','VRTPER','VIMAGE','SAITRF','VIMBAN','AGEBAN','VCCDEV','VCDAUT','VCDTRF','VRMPER','COMCHE')
AND bkheve.eta in ('VF', 'VA', 'FO') 
AND (
bkheve.mht*bktau.tind> (select 1000*a.tind from bktau a where a.dco=bkheve.dco  and a.dev='840') 
OR bkheve.mban*bktau.tind> (select 1000*a.tind from bktau a where a.dco=bkheve.dco and a.dev='840'))
and bkheve.ope  in (case when bkheve.exo1 = 'O' and bkheve.ope='511' then null else bkheve.ope end )
and (select bkcom.typ from bkcom where bkheve.ncp2=bkcom.ncp AND bkheve.age2=bkcom.age AND bkheve.dev2=bkcom.dev ) not in ('100')
and  substr(ncp2,1,3) = '005' and (((select DISTINCT bkcli.sec from bkcli where cli=bkheve.cli2) <> '10740') AND  bkheve.lib1 not like '%SALA%' )
)
);
