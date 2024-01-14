-- V_CTR View REPORT
--============================

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PRDGHAAMP"."V_CTR" ("SURNAME_ORG_NAME", "OCCUPATION", "BRANCH", "CUSTOMER_TYPE", "PARTY", "ACCOUNT_NO", "TRANSACTION_NO", "TRANSACTION_DATE_F", "TRANSACTION_DATE", "BIRTH_INCORPORATION", "RESIDENTAL_ADRESS", "ENT_ADR_TYP", "ACCOUNT_BALANCE", "ACCOUNT_CLOSED_DATE", "ACCOUNT_CURR_CODE", "DATE_OPEN", "ACCOUNT_NAME", "ACCOUNT_STATUS", "CURRENCY_TYPE", "NO_CLIENT", "ACCOUNT_TYPE", "DB_CR", "TRANSACTION_PARTICULARS", "SUBMISSION_DATE", "SUBMISSION_CODE", "FROM_FUNDS_CODE", "SOURCE_FUNDS_CODE", "AMOUNT_CURRENCY", "EXCH_RATE", "AMOUNT_LOCAL_CURRENCY", "TRANSACTION_PURPOSE", "ACCOUNT_NO_SRC", "ACCOUNT_NO_DEST", "COSTUMER_SRC", "COSTUMER_DEST", "CLI1_INF", "CLI2_INF", "T_CURRENCY_CODE", "POSTING_DATE_F", "POSTING_DATE", "SENS_SRC", "SENS_DEST", "AUTHORIZED", "DEV_SRC", "DEV_DEST", "BENEFICIARY_NAME", "AMOUNT_LOC_CCY", "PERSON", "DATE_HIST", "TIME_SAIS", "REMETTER_NAME", "REMETTER_SSN", "REMETTER_ADR", "REMETTER_TEL") AS 
  select "SURNAME_ORG_NAME","OCCUPATION","BRANCH","CUSTOMER_TYPE","PARTY","ACCOUNT_NO","TRANSACTION_NO","TRANSACTION_DATE_F","TRANSACTION_DATE","BIRTH_INCORPORATION","RESIDENTAL_ADRESS","ENT_ADR_TYP","ACCOUNT_BALANCE","ACCOUNT_CLOSED_DATE","ACCOUNT_CURR_CODE","DATE_OPEN","ACCOUNT_NAME","ACCOUNT_STATUS","CURRENCY_TYPE","NO_CLIENT","ACCOUNT_TYPE","DB_CR","TRANSACTION_PARTICULARS","SUBMISSION_DATE","SUBMISSION_CODE","FROM_FUNDS_CODE","SOURCE_FUNDS_CODE","AMOUNT_CURRENCY","EXCH_RATE","AMOUNT_LOCAL_CURRENCY","TRANSACTION_PURPOSE","ACCOUNT_NO_SRC","ACCOUNT_NO_DEST","COSTUMER_SRC","COSTUMER_DEST","CLI1_INF","CLI2_INF","T_CURRENCY_CODE","POSTING_DATE_F","POSTING_DATE","SENS_SRC","SENS_DEST","AUTHORIZED","DEV_SRC","DEV_DEST","BENEFICIARY_NAME","AMOUNT_LOC_CCY","PERSON","DATE_HIST","TIME_SAIS","REMETTER_NAME","REMETTER_SSN","REMETTER_ADR","REMETTER_TEL"
from 
(
SELECT distinct
--(Case when (select pre from bkcli where bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli) is null then '-' else (select pre from bkcli where bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli) end) AS FIRST_NAME,
--(Case when (select nom from bkcli where bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli) is null then '-'  else (select nom from bkcli where bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli) end) AS MIDNAME,
(case when (select nomrest from bkcli where bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli) is null then '-' else (select nomrest from bkcli where bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli) end) AS SURNAME_ORG_NAME,
 --'BSIC GH LTD' AS BANK_NAME,
 --'BK1007' AS INSTITUTION_CODE,
(case when (select lib1 from bknom where ctab='071' and cacc=(select sec from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli))) is null then '-'
else (select lib1 from bknom where ctab='071' and cacc=(select sec from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli))) end )AS OCCUPATION,
(case when (select lib1 from bknom where ctab='001' and cacc=bkheve.age) is null then '-' else (select lib1 from bknom where ctab='001' and cacc=bkheve.age) end) AS BRANCH,
--(case when  (select lib1 from bknom where ctab='033' and cacc=(select nat from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli))) is null then '-' else  (select lib1 from bknom where ctab='033' and cacc=(select nat from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli))) end )AS NATIONALITY,
 case when (select bkcli.tcli from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli) )='1' then 'IND' else 'ORG' end AS CUSTOMER_TYPE,
 ---'CTR' AS REPORT_TYPE,
(case when (trim(bkheve.nom1)||trim(bkheve.nom2)) is null then '-' else (trim(bkheve.nom1)||trim(bkheve.nom2)) end)as PARTY,
(case when bkheve.nat in ('RETESP','RETDEV','VENDEV','RETFON','AGERET') then 
(case when trim(bkheve.ncp1) is null then '-' else trim(bkheve.ncp1) end)  
else 
(case when TRIM(bkheve.ncp2) is null then '-' else trim(bkheve.ncp2) end) end) as ACCOUNT_NO,
(case when trim(bkheve.eve) is null then '-' else trim(bkheve.eve)  end) AS TRANSACTION_NO,
--transaction date à affiché 
(case when (substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),11,18)) is null then '-' else (substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dco, 'YYYY-MM-DDHH:MI:SS' ),11,18)) end)  AS TRANSACTION_DATE_F,
 bkheve.dco  AS TRANSACTION_DATE,
case when (select bkcli.tcli from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli) )='1'
	then CASE 
		WHEN (select dna from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli)) is not null
			then (select  substr(to_char(dna , 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(dna, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli))
		else to_char((select dna from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli))) end
else case 
		when (select datc from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli)) is not null
			then (select substr(to_char(datc, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(datc, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli))
		else to_char((select datc from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli))) end
end as BIRTH_INCORPORATION,
--(case when (SELECT BKCLI.NAT FROM BKCLI WHERE CLI = BKHEVE.CLI1 ) is null then '-' else (SELECT BKCLI.NAT FROM BKCLI WHERE CLI = BKHEVE.CLI1 )end ) AS CLI_NAT ,
--(case when (select lib2 from bknom where ctab='040' and lib1 =((select distinct bkcli.lid from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli)))) is null then '-'
--else (select lib2 from bknom where ctab='040' and lib1 =((select distinct bkcli.lid from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli)))) end)  AS ISSUE_PLACE,
(CASE WHEN(select bkadcli.adr2||bkadcli.adr3 from bkadcli where (bkheve.cli1 = bkadcli.cli OR bkheve.cli2 = bkadcli.cli)and bkadcli.typ='D') is null then '-'
else (select bkadcli.adr2||bkadcli.adr3 from bkadcli where (bkheve.cli1 = bkadcli.cli OR bkheve.cli2 = bkadcli.cli)and bkadcli.typ='D') end ) AS RESIDENTAL_ADRESS,
--(case when (select bkadcli.ville from bkadcli where (bkheve.cli1 = bkadcli.cli OR bkheve.cli2 = bkadcli.cli)and bkadcli.typ='D') is null then '-'
--else (select bkadcli.ville from bkadcli where (bkheve.cli1 = bkadcli.cli OR bkheve.cli2 = bkadcli.cli)and bkadcli.typ='D') end) AS TOWN,
--(case when (select  bkadcli.reg from bkadcli where (bkheve.cli1 = bkadcli.cli OR bkheve.cli2 = bkadcli.cli)and bkadcli.typ='D') is null then '-' else (select  bkadcli.reg from bkadcli where (bkheve.cli1 = bkadcli.cli OR bkheve.cli2 = bkadcli.cli)and bkadcli.typ='D') end) AS REGION,
--(case when (select bktelcli.num from bktelcli where (bkheve.cli1 = bktelcli.cli OR bkheve.cli2 = bktelcli.cli)and bktelcli.typ='001') is null then '-'
--else (select bktelcli.num from bktelcli where (bkheve.cli1 = bktelcli.cli OR bkheve.cli2 = bktelcli.cli)and bktelcli.typ='001') end) AS TEL,
--(select bkadcli.typ from bkadcli where (bkheve.cli1 = bkadcli.cli OR bkheve.cli2 = bkadcli.cli)and bkadcli.typ='D') AS ENT_ADR_TYP,
'1' AS ENT_ADR_TYP,

(select (case when trim(bkcom.sin) is null then '0' else trim(bkcom.sin) end)  from bkcom where  (bkheve.ncp1=bkcom.ncp OR bkheve.ncp2=bkcom.ncp) AND (bkheve.age1=bkcom.age OR bkheve.age2=bkcom.age) 
AND (bkheve.dev1=bkcom.dev OR bkheve.dev2=bkcom.dev))  AS ACCOUNT_BALANCE,
case 
    when (select bkcom.dfe from bkcom where  (bkheve.ncp1=bkcom.ncp OR bkheve.ncp2=bkcom.ncp) AND (bkheve.age1=bkcom.age OR bkheve.age2=bkcom.age) AND (bkheve.dev1=bkcom.dev OR bkheve.dev2=bkcom.dev)) is not null 
        then  (select substr(to_char( bkcom.dfe, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char( bkcom.dfe, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcom where  (bkheve.ncp1=bkcom.ncp OR bkheve.ncp2=bkcom.ncp) AND (bkheve.age1=bkcom.age OR bkheve.age2=bkcom.age) AND (bkheve.dev1=bkcom.dev OR bkheve.dev2=bkcom.dev))
    else '-'
end
AS ACCOUNT_CLOSED_DATE,
(case when (select bkcom.dev from bkcom where  (bkheve.ncp1=bkcom.ncp OR bkheve.ncp2=bkcom.ncp) AND (bkheve.age1=bkcom.age OR bkheve.age2=bkcom.age) AND (bkheve.dev1=bkcom.dev OR bkheve.dev2=bkcom.dev)) is null then '-'
else (select bkcom.dev from bkcom where  (bkheve.ncp1=bkcom.ncp OR bkheve.ncp2=bkcom.ncp) AND (bkheve.age1=bkcom.age OR bkheve.age2=bkcom.age) AND (bkheve.dev1=bkcom.dev OR bkheve.dev2=bkcom.dev)) end ) AS ACCOUNT_CURR_CODE,
(select substr(to_char( bkcom.dou, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char( bkcom.dou, 'YYYY-MM-DDHH:MI:SS' ),11,18) from bkcom where  (bkheve.ncp1=bkcom.ncp OR bkheve.ncp2=bkcom.ncp) AND (bkheve.age1=bkcom.age OR bkheve.age2=bkcom.age)
AND (bkheve.dev1=bkcom.dev OR bkheve.dev2=bkcom.dev))   AS DATE_OPEN,
(case when (select bkcom.inti from bkcom where  (bkheve.ncp1=bkcom.ncp OR bkheve.ncp2=bkcom.ncp) AND (bkheve.age1=bkcom.age OR bkheve.age2=bkcom.age) 
AND (bkheve.dev1=bkcom.dev OR bkheve.dev2=bkcom.dev)) is null then '-' else 
(select bkcom.inti from bkcom where  (bkheve.ncp1=bkcom.ncp OR bkheve.ncp2=bkcom.ncp) AND (bkheve.age1=bkcom.age OR bkheve.age2=bkcom.age) 
AND (bkheve.dev1=bkcom.dev OR bkheve.dev2=bkcom.dev)) end) AS ACCOUNT_NAME,
case when (select bkcom.cfe from bkcom where  (bkheve.ncp1=bkcom.ncp OR bkheve.ncp2=bkcom.ncp) AND (bkheve.age1=bkcom.age OR bkheve.age2=bkcom.age) 
AND (bkheve.dev1=bkcom.dev OR bkheve.dev2=bkcom.dev))='O' then 'C' else 'A' end AS ACCOUNT_STATUS,
(CASE WHEN(select lib2 from bknom where ctab='005' and (cacc= bkheve.dev1 OR cacc = bkheve.dev2)) is null then '-'
else (select lib2 from bknom where ctab='005' and (cacc= bkheve.dev1 OR cacc = bkheve.dev2)) end ) AS CURRENCY_TYPE,
(case when (select cli from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli)) is null then '-'
else (select cli from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli)) end) AS NO_CLIENT,
--(case when (select lib1 from bknom where ctab='078' and cacc =(select tid from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli))) is null then '-'
--else (select lib1 from bknom where ctab='078' and cacc =(select tid from bkcli where (bkheve.cli1 = bkcli.cli OR bkheve.cli2 = bkcli.cli))) end ) AS ID_TYPE,
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
END ) from bknom where ctab='032' and cacc=(select bkcom.typ from bkcom where  (bkheve.ncp1=bkcom.ncp OR bkheve.ncp2=bkcom.ncp) AND (bkheve.age1=bkcom.age OR bkheve.age2=bkcom.age) 
AND (bkheve.dev1=bkcom.dev OR bkheve.dev2=bkcom.dev))) AS ACCOUNT_TYPE,
case when (bkheve.sen1='C' OR bkheve.sen2='C') then 'CREDIT' else 'DEBIT' end AS DB_CR,
case  
when bkheve.nat='CHGESP' THEN 'CASH EXCHANGE'
when bkheve.nat='PAICAI' THEN 'CASH PAYMENT'
when bkheve.nat='RETESP' THEN 'CASH WITHDRAWAL'
when bkheve.nat='VERESP' THEN 'CASH DEPOSIT' 
when bkheve.nat='VESDEV' THEN 'CASH DEPOSIT TO FOREIGN CURRENCY ACCOUNTS'  
when bkheve.nat='RETDEV' THEN 'FOREIGN CURRENCY WITHDRAWAL' 
when bkheve.nat='VERDEV' THEN 'FOREIGN CURRENCY DEPOSIT'  
when bkheve.nat='ACHDEV' THEN 'PURCHASE OF FOREIGN CURRENCIES' 
when bkheve.nat='VENDEV' THEN 'SALE OF FOREIGN CURRENCIES' 
when bkheve.nat='RETFON' THEN 'CASH WITHDRAWALS CIVIL SERVANTS' 
 else 'CASH WITHDRAWAL' end  AS TRANSACTION_PARTICULARS,
 case  
when bkheve.nat='CHGESP' THEN 'K' 
when bkheve.nat='PAICAI' THEN 'K' 
when bkheve.nat='RETESP' THEN 'K'  
when bkheve.nat='RETDEV' THEN 'C'  
when bkheve.nat='ACHDEV' THEN 'C' 
when bkheve.nat='VENDEV' THEN 'C' 
when bkheve.nat='RETFON' THEN 'K' 
 else 'O' end  AS FROM_FUNDS_CODE,
  case  
when bkheve.nat='CHGESP' THEN 'K' 
when bkheve.nat='PAICAI' THEN 'K'  
when bkheve.nat='VERESP' THEN 'A' 
when bkheve.nat='VESDEV' THEN 'A' 
when bkheve.nat='VERDEV' THEN 'C' 
when bkheve.nat='ACHDEV' THEN 'C' 
when bkheve.nat='VENDEV' THEN 'C' 
 else 'O' end  AS SOURCE_FUNDS_CODE,  -- T_SOURCE_FUNDS_CODE
 --------- for the transaction mode code 
case  
when bkheve.nat='CHGESP' THEN 'F' 
when bkheve.nat='PAICAI' THEN 'F' 
when bkheve.nat='RETESP' THEN 'AU' 
when bkheve.nat='VERESP' THEN 'AD' 
when bkheve.nat='VESDEV' THEN 'AD' 
when bkheve.nat='RETDEV' THEN 'AU' 
when bkheve.nat='VERDEV' THEN 'AD' 
when bkheve.nat='ACHDEV' THEN 'AK' 
when bkheve.nat='VENDEV' THEN 'AN' 
when bkheve.nat='RETFON' THEN 'AU' else 'AU' end  AS transmode_code,
substr(to_char(sysdate,'YYYY-MM-DDHH:MI:SS' ),1,10) || 'T'||substr(to_char(sysdate,'YYYY-MM-DDHH:MI:SS' ),11,18) as SUBMISSION_DATE,
'E' as SUBMISSION_CODE,
case when (dev1 <> '936' and dev2 <> '936' ) then bkheve.mht1 else bkheve.mht end AS AMOUNT_CURRENCY,
bktau.tind AS EXCH_RATE,
case when (dev1 <> '936' and dev2 <> '936' ) then bkheve.mht1*bktau.tind else bkheve.mht*bktau.tind end AS AMOUNT_LOCAL_CURRENCY,
---(bkheve.mht1+bkheve.mht2)*bktau.tind AS TOTAL_TRANSACTION_AMOUNT,
(CASE WHEN bkheve.lib2 IS NULL THEN '-' ELSE bkheve.lib2  END) AS TRANSACTION_PURPOSE,
(CASE WHEN trim(bkheve.ncp1) IS NULL THEN '-' ELSE trim(bkheve.ncp1) END) AS ACCOUNT_NO_SRC , 
(CASE WHEN trim(bkheve.ncp2) IS NULL THEN '-' ELSE trim(bkheve.ncp2) END) AS ACCOUNT_NO_DEST , 
CASE when TRIM(bkheve.cli1) is not null then bkheve.cli1 else (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) end  as COSTUMER_SRC, 
CASE when trim(bkheve.cli2) is not null then bkheve.cli2 else (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) end  as COSTUMER_DEST, 
case when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is not null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is not null then 'true' 
when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is not null then 'true'  
when trim(bkheve.ncp1) is not null and trim(bkheve.cli1) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp1 and age =bkheve.age1 and dev =bkheve.dev1) is null then 'false' 
else 'both_empty' end as CLI1_INF,
case when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is not null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is not null then 'true' 
 when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is not null then 'true' 
 when trim(bkheve.ncp2) is not null and trim(bkheve.cli2) is null and (select trim(cli) from bkcom where ncp =bkheve.ncp2 and age =bkheve.age2 and dev =bkheve.dev2) is null then 'false' 
else 'both_empty' end as CLI2_INF,
(CASE WHEN bkheve.dev  IS NULL THEN '-' ELSE bkheve.dev END) as T_CURRENCY_CODE,
(CASE WHEN (substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),11,18)) is null then '-'
else (substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),1,10)||'T'||substr(to_char(bkheve.dsai, 'YYYY-MM-DDHH:MI:SS' ),11,18)) end) AS POSTING_DATE_F,
 bkheve.dsai AS POSTING_DATE,
(CASE WHEN bkheve.sen1 is null then '-' else bkheve.sen1 end) AS SENS_SRC , 
(CASE WHEN bkheve.sen2 is null then '-' else bkheve.sen2 end) AS SENS_DEST,
(CASE WHEN bkheve.utf  is null then '-' else bkheve.utf  end) AS AUTHORIZED,
(CASE WHEN bkheve.dev1 is null then '-' else bkheve.dev1 end) AS DEV_SRC,
(CASE WHEN bkheve.dev2 is null then '-' else bkheve.dev2 end) AS DEV_DEST ,
(CASE WHEN trim(bkheve.nom2) is not null then trim(bkheve.nom2)
     when trim(bkheve.nom2) is null and trim(bkheve.nom1) is not null 
	     then trim(bkheve.nom1) 
     when trim(bkheve.nom2) is null and trim(bkheve.nom1) is null and trim(bkheve.nomp) is not null
	     then trim(bkheve.nomp)
else
'-'  end) AS BENEFICIARY_NAME,
case when (bkheve.sen1 ='C' OR bkheve.sen2='C') then (bkheve.mht)*bktau.tac else (bkheve.mht)*bktau.tve end AS AMOUNT_LOC_CCY,
(case when bkheve.uti   is null then '-' else bkheve.uti   end) AS PERSON , 
bkheve.dateh AS DATE_HIST, 
bkheve.hsai  as time_sais,
bkheve.nomp as  REMETTER_NAME,
bkheve.nump as  REMETTER_SSN,
bkheve.ad1p as  REMETTER_ADR,
bkheve.ad2p as  REMETTER_TEL
FROM bkheve, bktau
WHERE (bkheve.dev1 = bktau.dev OR bkheve.dev2 =bktau.dev) 
AND bktau.dco=bkheve.dco 
AND bkheve.nat in ('VERESP','PAICAI','VESDEV','VERDEV','ACHDEV','CHGESP','RETESP','RETDEV','VENDEV','RETFON','AGERET') 
AND bkheve.eta in ('VF', 'VA', 'FO')
and (trim(lib3) not like nat or trim(lib3) is null)
)
where AMOUNT_LOCAL_CURRENCY> 50000;
