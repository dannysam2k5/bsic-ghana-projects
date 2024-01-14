alter session set nls_date_format='dd/mm/yyyy';
define DATE_ARRETE='30/06/2018';
--- MBK900
select 
BRANCH,
CUST_NO,
CUST_NAME,
GL,
--ACC_NUMBER,
Bus_Reg_No,
TO_CHAR(START_DATE, 'DDMMYYYY')As START_DATE,
TO_CHAR(EXPIRY, 'DDMMYYYY')As EXPIRY,
CURR,
REPLACE(FACILITY_BAL,',','.') As FACILITY_BAL,
REPLACE(FACILITY_AMOUNT,',','.') As FACILITY_AMOUNT,
REPLACE(DEBIT_ON_CurAcc,',','.') As DEBIT_ON_CurAcc,
REPLACE(FACILITY_BAL + DEBIT_ON_CurAcc,',','.') As TOTAL_EXPOSURE,
Cust_Loc_Addr,
PHONE_CLI,
SECTOR,
TENOR,
EXPOSURE As Facility_Type
from
(
select 
BRANCH,
CUST_NO,
CUST_NAME,
GL,
--ACC_NUMBER,
Bus_Reg_No,
START_DATE,
EXPIRY,
(select LIB2 from bknom where ctab='005' and cacc=CURR) as CURR,
sum(FACILITY_BAL) As FACILITY_BAL,
FACILITY_AMOUNT,
--DEBIT_ON_CurAcc,
case when
    row_number() over (partition by CUST_NO order by DEBIT_ON_CurAcc) = 1
  then
    DEBIT_ON_CurAcc
  else 
   0
  end as DEBIT_ON_CurAcc,
Cust_Loc_Addr,
PHONE_CLI,
SECTOR,
TENOR,
EXPOSURE 
FROM
(
SELECT a.age BRANCH,
  a.cli CUST_NO,
  nom CUST_NAME,
  a.cha GL,
  a.ncp ACC_NUMBER,
  f.nrc Bus_Reg_No ,
  c.dmep AS START_DATE,
  c.ddec EXPIRY,
  a.dev CURR,
  a.sdecv AS FACILITY_BAL,
  c.mon   AS FACILITY_AMOUNT,
  (SELECT NVL(SUM(sdecv),0)
  FROM bksld
  WHERE dco=to_date('&DATE_ARRETE','DD/MM/YYYY')
  AND cha LIKE '2511%'
  AND cli=a.cli
  AND sde<0
  ) AS DEBIT_ON_CurAcc,
  trim(g.adr1)
  ||' '
  ||trim(g.adr2)
  ||' '
  ||trim(g.adr3) AS Cust_Loc_Addr,
  (SELECT num FROM bktelcli WHERE cli=a.cli AND rownum=1
  ) AS PHONE_CLI,
  (SELECT trim(lib1)||trim(lib2) FROM bknom WHERE ctab='071' AND cacc=f.sec
  )             AS SECTOR,
  ROUND(nbe/12) AS TENOR,
  libe          AS EXPOSURE
FROM bksld a,
  gedefil b,
  bkdosprt c,
  bkcptprt d,
  bktyprt e,
  bkcli f,
  bkadcli g
WHERE dco  =to_date('&DATE_ARRETE','DD/MM/YYYY')
AND nomd  IN ('10670','10680','11230','21630')
AND a.cha >=b.cha1
AND a.cha <= b.cha2
AND c.eve  =d.eve
AND c.age  =d.age
AND a.ncp  =d.ncp
AND a.age  =c.age
AND c.typ  =e.typ
AND f.cli  =g.cli
AND g.typ  ='D'
AND a.cli  =f.cli
AND c.eta  ='VA'
AND c.ctr  = 1
AND cha NOT LIKE '25%'
AND sde!=0
UNION
SELECT a.age BRANCH,
  a.cli CUST_NO,
  nom CUST_NAME,
  a.cha GL,
  a.ncp ACC_NUMBER,
  f.nrc Bus_Reg_No,
  b.debut AS START_DATE,
  b.fin EXPIRY,
  a.dev CURR,
  a.sdecv AS FACILITY_BAL ,
  b.maut  AS FACILITY_AMOUNT,
  (SELECT NVL(SUM(sdecv),0)
  FROM bksld
  WHERE dco=to_date('&DATE_ARRETE','DD/MM/YYYY')
  AND cha LIKE '2511%'
  AND cli=a.cli
  AND sde<0
  ) AS DEBIT_ON_CurAcc,
  trim(g.adr1)
  ||' '
  ||trim(g.adr2)
  ||' '
  ||trim(g.adr3) AS Cust_Loc_Addr,
  (SELECT num FROM bktelcli WHERE cli=a.cli AND rownum=1
  ) AS PHONE_CLI,
  (SELECT trim(lib1)||trim(lib2) FROM bknom WHERE ctab='071' AND cacc=f.sec
  )                             AS SECTOR,
  ROUND((b.fin - b.debut)/365 ) AS TENOR,
  (
  CASE
    WHEN ctyp='001'
    THEN 'OVERDRAFT'
    ELSE 'CREDIT LINE'
  END) AS EXPOSURE
FROM bksld a,
  bkautc b,
  bkcli f,
  bkadcli g
WHERE dco =to_date('&DATE_ARRETE','DD/MM/YYYY')
AND a.age =b.age
AND a.ncp =b.ncp
AND a.dev =b.dev
AND f.cli =g.cli
AND g.typ ='D'
AND a.cli =f.cli
AND b.fin>=a.dco
AND sde   <0
UNION
SELECT a.age BRANCH,
  a.cli CUST_NO,
  nom CUST_NAME,
  a.cha GL,
  a.ncp ACC_NUMBER,
  f.nrc Bus_Reg_No,
  b.dva AS START_DATE,
  b.dech EXPIRY,
  a.dev CURR,
  a.sdecv AS FACILITY_BAL ,
  b.mon   AS FACILITY_AMOUNT,
  (SELECT NVL(SUM(sdecv),0)
  FROM bksld
  WHERE dco=to_date('&DATE_ARRETE','DD/MM/YYYY')
  AND cha LIKE '2511%'
  AND cli=a.cli
  AND sde<0
  ) AS DEBIT_ON_CurAcc,
  trim(g.adr1)
  ||' '
  ||trim(g.adr2)
  ||' '
  ||trim(g.adr3) AS Cust_Loc_Addr,
  (SELECT num FROM bktelcli WHERE cli=a.cli AND rownum=1
  ) AS PHONE_CLI,
  (SELECT trim(lib1)||trim(lib2) FROM bknom WHERE ctab='071' AND cacc=f.sec
  )                            AS SECTOR,
  ROUND((b.dech - b.dva)/365 ) AS TENOR,
  b.obj                        AS EXPOSURE
FROM bksld a,
  bkcau b,
  bkcli f,
  bkadcli g
WHERE a.dco=to_date('&DATE_ARRETE','DD/MM/YYYY')
AND a.cha IN ('913301','913302')
AND a.ncp  =b.ncpe
AND f.cli  =g.cli
AND g.typ  ='D'
AND a.cli  =f.cli
AND sde    <0
)
group by FACILITY_AMOUNT,BRANCH, CUST_NO, CUST_NAME, GL, Bus_Reg_No, START_DATE, EXPIRY, CURR, DEBIT_ON_CurAcc, Cust_Loc_Addr, PHONE_CLI, SECTOR, TENOR, EXPOSURE
);