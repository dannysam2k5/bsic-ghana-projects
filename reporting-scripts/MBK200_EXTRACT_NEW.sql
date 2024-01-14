alter session set nls_date_format='dd/mm/yyyy';
define DATE_ARRETE='30/06/2020';
SELECT 
LPAD(dense_rank() OVER (ORDER BY rank_scrolling,item_code ASC )*10,5,'0') as ITEM_CODE,
   LPAD(ROW_NUMBER() OVER (PARTITION BY rank_scrolling,item_code ORDER BY row_number ASC),5,'0') as SUB_ITEM_CODE,
  (SELECT distinct nomrest FROM bkcli WHERE cli=item_desc
  UNION
  SELECT item_desc
  FROM dual
  WHERE NOT EXISTS
    (SELECT distinct nomrest FROM bkcli WHERE cli=item_desc
    )
  )             AS item_desc,
  type_exposure AS type_exposure ,
  currency      AS currency,
  for_cur_mnt   AS foreign_currency_amount,
  cedi_equiv    AS cedi_equivalent,
  ROUND(rate,2)          AS revaluation_rate,
  (SELECT distinct MON
  FROM BKLEGAL
  WHERE DARR = DCO
  AND PER    ='M'
  AND DOC    ='100'
  AND FEUI   =01
  AND poste  ='L157'
  AND NCOL   =3
  ) AS networth_reporting_bank ,
  0 AS percentage_exposure_networth,
  (select UPPER(TO_CHAR(TO_DATE(CASE when max(dech) != null then max(dech) else to_date('&DATE_ARRETE') end, 'dd-mm-yyyy'),'dd-mon-YYYY','NLS_DATE_LANGUAGE=english')) from bkgar where cli=item_desc  ) AS maturity_date,
  --DCO AS maturity_date,
  0   AS interest_rate,
  0   AS rating_counter_party,
  0   AS networth_counter_party,
  DCO AS counter_party_audit_reportdate,
  (SELECT SUM(bksld.sdecv)
  FROM bksld ,
    gedefil
  WHERE gedefil.nomd = '10700'
  AND bksld.cli      = item_desc
  AND bksld.dco      = DCO
  ) AS provision
FROM (
  -- Scrolling list 10010 - START -
  (SELECT 'A'          AS rank_scrolling,
    '10010'            AS item_code,
    00000              AS row_number,
    'A.Foreign ASSETS' AS item_desc,
    'NA'               AS type_exposure,
    'GHS'              AS currency,
    0                  AS for_cur_mnt,
    SUM(somme_cv)      AS cedi_equiv,
    1                  AS rate,
    dco                AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN('10030','10040')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev!    ='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN ('10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101220001','10101220001','10101220002','10101220002','10101220003','10101220003','10105000001','10105000001','10105000001','10105000001','10103000001','10103000002','10103000003','10103000004','10103000005','10103000006','10103000007','10103000008','10103000009','10103000010','37910000021','37910000006','37920000042','37910000005','12671100002','12671100003','12671100004','12671100005')
    AND a.dev!   ='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  ) -- Scrolling list 10010 - END -
UNION
---MBK200 . 10020 - part
SELECT *
FROM
  (SELECT 'A'                                  AS rank_scrolling,
    '10020'                                    AS item_code,
    00000                                      AS row_number,
    '    (a) Foreign Currency notes and coins' AS item_desc,
    'NA'                                       AS type_exposure,
    'NA'                                       AS currency,
    0                                          AS for_cur_mnt,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END   AS cedi_equiv ,
    1     AS rate,
    a.dco AS dco
  FROM bksld a
  WHERE a.ncp IN ('10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101220001','10101220001','10101220002','10101220002','10101220003','10101220003','10105000001','10105000001','10105000001','10105000001','10103000001','10103000002','10103000003','10103000004','10103000005','10103000006','10103000007','10103000008','10103000009','10103000010')
  AND a.dev!   ='936'
  AND a.sdecv != 0
  AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dco
  UNION
  SELECT 'A'                                       AS rank_scrolling,
    '10020'                                        AS item_code,
    ROW_NUMBER() OVER (ORDER BY currency,currency) AS row_number,
    'Foreign cash'                                 AS item_desc,
    'Cash'                                         AS type_exposure,
    currency                                       AS currency,
    SUM(for_cur_mnt)                               AS for_cur_mnt ,
    SUM(cedi_equiv)                                AS cedi_equiv ,
    MAX(rate)                                      AS rate,
    dco                                            AS dco
  FROM
    (SELECT
      CASE a.dev
        WHEN '840'
        THEN 'USD'
        WHEN '978'
        THEN 'EURO'
        WHEN '826'
        THEN 'GBP'
        ELSE 'NA'
      END AS currency,
      CASE
        WHEN SUM(a.sde) < 0
        THEN -1*SUM(a.sde)
        WHEN SUM(a.sde) > 0
        THEN SUM(a.sde)
      END AS for_cur_mnt ,
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(a.sdecv) > 0
        THEN SUM(a.sdecv)
      END          AS cedi_equiv ,
      MAX(a.txind) AS rate,
      a.dco        AS dco
    FROM bksld a
    WHERE a.ncp IN ('10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101200001','10101200002','10101200003','10101200004','10101200005','10101200006','10101220001','10101220001','10101220002','10101220002','10101220003','10101220003','10105000001','10105000001','10105000001','10105000001','10103000001','10103000002','10103000003','10103000004','10103000005','10103000006','10103000007','10103000008','10103000009','10103000010')
    AND a.dev!   ='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dev,
      a.dco
    )
  GROUP BY currency,
    dco
  )
---MBK200 . 10020 - part END
UNION-- Scrolling list 10030 - STATRT -
SELECT *
FROM (
  (SELECT 'A'                                                AS rank_scrolling,
    '10030'                                                  AS item_code,
    00000                                                    AS row_number,
    '    (b) Correspondent acc. In non-res. Financial inst.' AS item_desc,
    'NA'                                                     AS type_exposure,
    'NA'                                                     AS currency,
    0                                                        AS for_cur_mnt,
    SUM(somme_cv)                                            AS cedi_equiv,
    1                                                        AS rate,
    dco                                                      AS dco
  FROM (
    (SELECT SUM(-1*sdecv) AS somme_cv,
      a.dco               AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd = '10030'
    AND a.cha   >=b.cha1
    AND a.cha   <=b.cha2
    AND a.dev!   ='936'
    AND a.sdecv != 0
    AND dco      =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT SUM(-1*sdecv) AS somme_cv,
      a.dco               AS dco
    FROM bksld a
    WHERE a.ncp IN ('37910000021','37910000006','37920000042','37910000005')
    AND a.dev!   ='936'
    AND a.sdecv != 0
    AND dco      =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  )
UNION
SELECT 'A'                                 AS rank_scrolling,
  '10030'                                  AS item_code,
  ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
  CASE
    WHEN a.cli != '  '
    THEN a.cli
    ELSE 'NA'
  END       AS item_desc,
  'Current' AS type_exposure,
  CASE a.dev
    WHEN '840'
    THEN 'USD'
    WHEN '978'
    THEN 'EURO'
    WHEN '826'
    THEN 'GBP'
    ELSE 'NA'
  END             AS currency,
  SUM(-1*a.sde)   AS for_cur_mnt ,
  SUM(-1*a.sdecv) AS cedi_equiv ,
  MAX(a.txind)    AS rate,
  a.dco           AS dco
FROM bksld a,
  gedefil b
WHERE a.cha >=b.cha1
AND a.cha   <=b.cha2
AND b.nomd  IN ('10030')
AND a.dev!   ='936'
AND a.sdecv != 0
AND dco      =to_date('&DATE_ARRETE','DD/MM/YYYY')
GROUP BY a.dev,
  a.cli,
  a.dco
UNION
SELECT 'A'                                 AS rank_scrolling,
  '10030'                                  AS item_code,
  ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
  CASE
    WHEN a.cli != '  '
    THEN a.cli
    ELSE 'NA'
  END       AS item_desc,
  'Current' AS type_exposure,
  CASE a.dev
    WHEN '840'
    THEN 'USD'
    WHEN '978'
    THEN 'EURO'
    WHEN '826'
    THEN 'GBP'
    ELSE 'NA'
  END             AS currency,
  SUM(-1*a.sde)   AS for_cur_mnt ,
  SUM(-1*a.sdecv) AS cedi_equiv ,
  MAX(a.txind)    AS rate,
  a.dco           AS dco
FROM bksld a
WHERE a.ncp IN ('37910000021','37910000006','37920000042','37910000005')
AND a.dev!   ='936'
AND a.sdecv != 0
AND dco      =to_date('&DATE_ARRETE','DD/MM/YYYY')
GROUP BY a.dev,
  a.cli,
  a.dco)
-- Scrolling list 10030 - END -
UNION
-- Scrolling list 10040 - STATRT -
SELECT *
FROM (
  (SELECT 'A'                               AS rank_scrolling,
    '10040'                                 AS item_code,
    00000                                   AS row_number,
    '    (c) Other claims on non-residents' AS item_desc,
    'NA'                                    AS type_exposure,
    'NA'                                    AS currency,
    0                                       AS for_cur_mnt,
    SUM(somme_cv)                           AS cedi_equiv,
    1                                       AS rate,
    dco                                     AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv ,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd = '10040'
    AND a.cha   >=b.cha1
    AND a.cha   <=b.cha2
    AND a.dev!   ='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN ('12671100002','12671100003','12671100004','12671100005')
    AND a.dev!   ='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  )
UNION
SELECT 'A'                                 AS rank_scrolling,
  '10040'                                  AS item_code,
  ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
  CASE
    WHEN a.cli != '  '
    THEN a.cli
    ELSE 'NA'
  END         AS item_desc,
  'Time Dep.' AS type_exposure,
  CASE a.dev
    WHEN '840'
    THEN 'USD'
    WHEN '978'
    THEN 'EURO'
    WHEN '826'
    THEN 'GBP'
    ELSE 'NA'
  END AS currency,
  CASE
    WHEN SUM(a.sde) < 0
    THEN -1*SUM(a.sde)
    WHEN SUM(a.sde) > 0
    THEN SUM(a.sde)
  END AS for_cur_mnt ,
  CASE
    WHEN SUM(a.sdecv) < 0
    THEN -1*SUM(a.sdecv)
    WHEN SUM(a.sdecv) > 0
    THEN SUM(a.sdecv)
  END          AS cedi_equiv ,
  MAX(a.txind) AS rate,
  a.dco        AS dco
FROM bksld a,
  gedefil b
WHERE b.nomd IN ('10040')
AND a.cha    >=b.cha1
AND a.cha    <=b.cha2
AND a.dev!    ='936'
AND a.sdecv  != 0
AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
GROUP BY a.dev,
  a.cli,
  b.nomd,
  a.dco
UNION
SELECT 'A'                                 AS rank_scrolling,
  '10040'                                  AS item_code,
  ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
  CASE
    WHEN a.cli != '  '
    THEN a.cli
    ELSE 'NA'
  END         AS item_desc,
  'Time Dep.' AS type_exposure,
  CASE a.dev
    WHEN '840'
    THEN 'USD'
    WHEN '978'
    THEN 'EURO'
    WHEN '826'
    THEN 'GBP'
    ELSE 'NA'
  END AS currency,
  CASE
    WHEN SUM(a.sde) < 0
    THEN -1*SUM(a.sde)
    WHEN SUM(a.sde) > 0
    THEN SUM(a.sde)
  END AS for_cur_mnt ,
  CASE
    WHEN SUM(a.sdecv) < 0
    THEN -1*SUM(a.sdecv)
    WHEN SUM(a.sdecv) > 0
    THEN SUM(a.sdecv)
  END          AS cedi_equiv ,
  MAX(a.txind) AS rate,
  a.dco        AS dco
FROM bksld a
WHERE a.ncp IN ('12671100002','12671100003','12671100004','12671100005')
AND a.dev!   ='936'
AND a.sdecv != 0
AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
GROUP BY a.dev,
  a.cli,
  a.dco )
-- Scrolling list 10040 - END -
UNION
-- Scrolling list 10050 - STATRT -
SELECT *
FROM
  (SELECT 'A'                                     AS rank_scrolling,
    '10050'                                       AS item_code,
    00000                                         AS row_number,
    '    (d) Loans and Advances to non-residents' AS item_desc,
    'NA'                                          AS type_exposure,
    'NA'                                          AS currency,
    0                                             AS for_cur_mnt,
    0                                             AS cedi_equiv,
    1                                             AS rate,
    to_date('&DATE_ARRETE','dd/mm/yyyy')          AS dco
  FROM dual
  )
-- Scrolling list 10050 - END -
UNION -- Scrolling list 10060 - STATRT -
SELECT *
FROM
  (SELECT 'A'                                                AS rank_scrolling,
    '10060'                                                  AS item_code,
    00000                                                    AS row_number,
    '    (e) Equity and other non-liquid investments abroad' AS item_desc,
    'NA'                                                     AS type_exposure,
    'NA'                                                     AS currency,
    0                                                        AS for_cur_mnt,
    0                                                        AS cedi_equiv,
    1                                                        AS rate,
    to_date('&DATE_ARRETE','dd/mm/yyyy')                     AS dco
  FROM dual
  )
-- Scrolling list 10060 - END -
UNION
  -- Scrolling list 10070 - START -
  (
  SELECT 'A'            AS rank_scrolling,
    '10070'             AS item_code,
    00000               AS row_number,
    'B.DOMESTIC ASSETS' AS item_desc,
    'NA'                AS type_exposure,
    'GHS'               AS currency,
    0                   AS for_cur_mnt,
    SUM(somme_cv)       AS cedi_equiv,
    1                   AS rate,
    dco                 AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv ,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN('10650','10670','10680')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev!    ='936'
    AND sdecv     < 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv ,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN('10110','10170D','10220','10680B','11230')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev!    ='936'
    AND sdecv    != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv ,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN ('12671100001','12671100006','12671100007','38120000001','38120000002','38120000003','38120000004','38120000005','251710000008', '38120000006','38120000007','38120000008','38120000009','38120000010','38120000011','38120000012', '32311000003','32311000004','32311000007','32311000008','10104000004','38110000009','37910000001','37910000024', '33117000009','37920000043','33111000003','20228900001','20228900002','20228900201','20228900202','20480000001','20480000002','20480000201','20480000202')
    AND a.dev!   ='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  )
-- Scrolling list 10070 - END -
UNION
  -- Scrolling list 10080 - STATRT -
  (
  SELECT 'B'                          AS rank_scrolling,
    '10080'                           AS item_code,
    00000                             AS row_number,
    '    (a) Claims on Central Banks' AS item_desc,
    'NA'                              AS type_exposure,
    'NA'                              AS currency,
    0                                 AS for_cur_mnt,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END   AS cedi_equiv ,
    1     AS rate,
    a.dco AS dco
  FROM bksld a,
    gedefil b
  WHERE b.nomd IN ('10110')
  AND a.cha    >=b.cha1
  AND a.cha    <=b.cha2
  AND a.sdecv  != 0
  AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
  AND dev      !='936'
  GROUP BY a.dco
  UNION
  SELECT 'B'                                 AS rank_scrolling,
    '10080'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN a.cli
      ELSE 'NA'
    END       AS item_desc,
    'Current' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    dco          AS dco
  FROM bksld a,
    gedefil b
  WHERE b.nomd IN ('10110')
  AND a.cha    >=b.cha1
  AND a.cha    <=b.cha2
  AND a.sdecv  != 0
  AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
  AND dev      !='936'
  GROUP BY a.dev,
    a.cli,
    a.dco
  )
-- Scrolling list 10080 - END -
UNION
  -- Scrolling list 10090 - STATRT -
  (
  SELECT 'B'                                                         AS rank_scrolling,
    '10090'                                                          AS item_code,
    00000                                                            AS row_number,
    '    (b) Claims on other Banks and other Financial Institutions' AS item_desc,
    'NA'                                                             AS type_exposure,
    'NA'                                                             AS currency,
    0                                                                AS for_cur_mnt,
    SUM(somme_cv)                                                    AS cedi_equiv,
    1                                                                AS rate,
    dco                                                              AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN ('10170D','10220')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev    !='936'
    AND a.sdecv  != 0
    AND dco       =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN ('12671100001','12671100006','12671100007')
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND dco      =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  UNION
  SELECT 'B'                                 AS rank_scrolling,
    '10090'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN a.cli
      ELSE 'NA'
    END         AS item_desc,
    'PLACEMENT' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    a.dco        AS dco
  FROM bksld a,
    gedefil b
  WHERE a.cha>=b.cha1
  AND a.cha  <=b.cha2
    --AND a.dco   ='30/09/2016'
  AND b.nomd  IN ('10170D','10220')
  AND a.dev!   ='936'
  AND a.sdecv != 0
  AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dev,
    a.cli,
    b.nomd,
    a.dco
  UNION
  SELECT 'B'                                 AS rank_scrolling,
    '10090'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN a.cli
      ELSE 'NA'
    END         AS item_desc,
    'PLACEMENT' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    a.dco        AS dco
  FROM bksld a
  WHERE a.ncp IN ('12671100001','12671100006','12671100007')
  AND a.dev!   ='936'
  AND a.sdecv != 0
  AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dev,
    a.cli,
    a.dco
  )
-- Scrolling list 10090 - END -
UNION
  -- Scrolling list 10100 - STATRT -
  (
  (
  SELECT 'B'                                       AS rank_scrolling,
    '10100'                                        AS item_code,
    00000                                          AS row_number,
    '    (c) Loans, Overdrafts and other Advances' AS item_desc,
    'NA'                                           AS type_exposure,
    'NA'                                           AS currency,
    0                                              AS for_cur_mnt,
    SUM(somme_cv)                                  AS cedi_equiv,
    1                                              AS rate,
    dco                                            AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv ,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN ('10650','10670','10680')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev!    ='936'
    AND a.sdecv   < 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv ,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN ('10680B')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev!    ='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  )
UNION
SELECT 'B'                                 AS rank_scrolling,
  '10100'                                  AS item_code,
  ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
  CASE
    WHEN a.cli != '  '
    THEN a.cli
    ELSE 'NA'
  END         AS item_desc,
  'Overdraft' AS type_exposure,
  CASE a.dev
    WHEN '840'
    THEN 'USD'
    WHEN '978'
    THEN 'EURO'
    WHEN '826'
    THEN 'GBP'
    ELSE 'NA'
  END AS currency,
  CASE
    WHEN SUM(a.sde) < 0
    THEN -1*SUM(a.sde)
    WHEN SUM(a.sde) > 0
    THEN SUM(a.sde)
  END AS for_cur_mnt ,
  CASE
    WHEN SUM(a.sdecv) < 0
    THEN -1*SUM(a.sdecv)
    WHEN SUM(a.sdecv) > 0
    THEN SUM(a.sdecv)
  END          AS cedi_equiv ,
  MAX(a.txind) AS rate,
  dco          AS dco
FROM bksld a,
  gedefil b
WHERE b.nomd IN ('10650','10670','10680')
AND a.cha    >=b.cha1
AND a.cha    <=b.cha2
AND dev      != '936'
AND sdecv     < 0
AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
GROUP BY a.dev,
  a.cli,
  b.nomd,
  a.dco
UNION
SELECT 'B'                                 AS rank_scrolling,
  '10100'                                  AS item_code,
  ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
  CASE
    WHEN a.cli != '  '
    THEN a.cli
    ELSE 'NA'
  END         AS item_desc,
  'Overdraft' AS type_exposure,
  CASE a.dev
    WHEN '840'
    THEN 'USD'
    WHEN '978'
    THEN 'EURO'
    WHEN '826'
    THEN 'GBP'
    ELSE 'NA'
  END AS currency,
  CASE
    WHEN SUM(a.sde) < 0
    THEN -1*SUM(a.sde)
    WHEN SUM(a.sde) > 0
    THEN SUM(a.sde)
  END AS for_cur_mnt ,
  CASE
    WHEN SUM(a.sdecv) < 0
    THEN -1*SUM(a.sdecv)
    WHEN SUM(a.sdecv) > 0
    THEN SUM(a.sdecv)
  END          AS cedi_equiv ,
  MAX(a.txind) AS rate,
  dco          AS dco
FROM bksld a,
  gedefil b
WHERE b.nomd IN ('10680B')
AND a.cha    >=b.cha1
AND a.cha    <=b.cha2
AND dev      != '936'
AND sdecv    != 0
AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
GROUP BY a.dev,
  a.cli,
  b.nomd,
  a.dco )
-- Scrolling list 10100 - END -
UNION
  -- Scrolling list 10110 - STATRT -
  (
  SELECT 'B'                             AS rank_scrolling,
    '10110'                              AS item_code,
    00000                                AS row_number,
    '    (d) Cheques for clearing'       AS item_desc,
    'NA'                                 AS type_exposure,
    'NA'                                 AS currency,
    0                                    AS for_cur_mnt,
    0                                    AS cedi_equiv,
    1                                    AS rate,
    to_date('&DATE_ARRETE','DD/MM/YYYY') AS dco
  FROM dual
  )
-- Scrolling list 10110 - END -
UNION
  -- Scrolling list 10120 - STATRT -
  (
  SELECT 'B'                             AS rank_scrolling,
    '10120'                              AS item_code,
    00000                                AS row_number,
    '    (e) Securities'                 AS item_desc,
    'NA'                                 AS type_exposure,
    'NA'                                 AS currency,
    0                                    AS for_cur_mnt,
    0                                    AS cedi_equiv,
    1                                    AS rate,
    to_date('&DATE_ARRETE','DD/MM/YYYY') AS dco
  FROM dual
  )
-- Scrolling list 10120 - END -
UNION
  -- Scrolling list 10130 - STATRT -
  (
  SELECT 'B'               AS rank_scrolling,
    '10130'                AS item_code,
    00000                  AS row_number,
    '    (f) Other Assets' AS item_desc,
    'NA'                   AS type_exposure,
    'NA'                   AS currency,
    0                      AS for_cur_mnt,
    SUM(somme_cv)          AS cedi_equiv,
    1                      AS rate,
    dco                    AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv ,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd = '11230'
    AND a.cha   >=b.cha1
    AND a.cha   <=b.cha2
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv ,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN('38120000001','38120000002','38120000003','38120000004','38120000005','251710000008', '38120000006','38120000007','38120000008','38120000009','38120000010','38120000011','38120000012', '32311000003','32311000004','32311000007','32311000008','10104000004','38110000009','37910000001','37910000024', '33117000009','37920000043','33111000003','20228900001','20228900002','20228900201','20228900202','20480000001','20480000002','20480000201','20480000202')
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  UNION
  SELECT 'B'                                 AS rank_scrolling,
    '10130'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN (select distinct inti from bkcom where cli=a.cli and ncp=a.ncp and dev=a.dev and age=a.age)
      ELSE 'NA'
    END  AS item_desc,
    'NA' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    a.dco        AS dco
  FROM bksld a,
    gedefil b
  WHERE b.nomd IN ('11230')
  AND a.cha    >=b.cha1
  AND a.cha    <=b.cha2
  AND a.sdecv  != 0
  AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
  AND dev      != '936'
  GROUP BY a.dev,
    a.cli,
    a.dco,
	a.ncp,
	a.age
  UNION
  SELECT 'B'                                 AS rank_scrolling,
    '10130'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN (select distinct inti from bkcom where cli=a.cli and ncp=a.ncp and dev=a.dev and age=a.age)
      ELSE 'NA'
    END  AS item_desc,
    'NA' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    a.dco        AS dco
  FROM bksld a
  WHERE a.ncp IN('38120000001','38120000002','38120000003','38120000004','38120000005','251710000008', '38120000006','38120000007','38120000008','38120000009','38120000010','38120000011','38120000012', '32311000003','32311000004','32311000007','32311000008','10104000004','38110000009','37910000001','37910000024', '33117000009','37920000043','33111000003','20228900001','20228900002','20228900201','20228900202','20480000001','20480000002','20480000201','20480000202')
  AND dev     !='936'
  AND a.sdecv != 0
  AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dev,
    a.cli,
    a.dco,
	a.ncp,
	a.age
  )
-- Scrolling list 10130 - END -*/
UNION
  -- Scrolling list 10140 - START -
  (
  SELECT 'C'                AS rank_scrolling,
    '10140'                 AS item_code,
    00000                   AS row_number,
    'C.Foreign Liabilities' AS item_desc,
    'NA'                    AS type_exposure,
    'NA'                    AS currency,
    0                       AS for_cur_mnt,
    SUM(somme_cv)           AS cedi_equiv,
    1                       AS rate,
    dco                     AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN('20150','20160','20170','20190','20200','20210','20260')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev    !='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT SUM(sdecv) AS somme_cv,
      a.dco            AS dco
    FROM bksld a
    WHERE a.ncp IN('17561100005','17561200002','17561200003','17561200004','17561200005','17561200006','27250000006','27211000004')
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ))
  GROUP BY dco
  )
-- Scrolling list 10140 - END -
UNION
  -- Scrolling list 10150 - STATRT -
  (
  SELECT 'C'                        AS rank_scrolling,
    '10150'                         AS item_code,
    00000                           AS row_number,
    '    (a) Short-Term Borrowings' AS item_desc,
    'NA'                            AS type_exposure,
    'NA'                            AS currency,
    0                               AS for_cur_mnt,
    SUM(somme_cv)                   AS cedi_equiv,
    1                               AS rate,
    dco                             AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN('20150','20160','20170')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev    !='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN('17561100005')
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ))
  GROUP BY dco
  UNION
    (SELECT 'C'                                AS rank_scrolling,
      '10150'                                  AS item_code,
      ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
      CASE
        WHEN a.cli != '  '
        THEN a.cli
        ELSE 'NA'
      END  AS item_desc,
      'NA' AS type_exposure,
      CASE a.dev
        WHEN '840'
        THEN 'USD'
        WHEN '978'
        THEN 'EURO'
        WHEN '826'
        THEN 'GBP'
        ELSE 'NA'
      END AS currency,
      CASE
        WHEN SUM(a.sde) < 0
        THEN -1*SUM(a.sde)
        WHEN SUM(a.sde) > 0
        THEN SUM(a.sde)
      END AS for_cur_mnt ,
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(a.sdecv) > 0
        THEN SUM(a.sdecv)
      END          AS cedi_equiv ,
      MAX(a.txind) AS rate,
      a.dco        AS dco
    FROM bksld a,
      gedefil b
    WHERE a.cha >=b.cha1
    AND a.cha   <=b.cha2
    AND b.nomd  IN('20150','20160','20170')
    AND dev     !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dev,
      a.cli,
      a.dco
    UNION
    SELECT 'C'                                 AS rank_scrolling,
      '10150'                                  AS item_code,
      ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
      CASE
        WHEN a.cli != '  '
        THEN a.cli
        ELSE 'NA'
      END  AS item_desc,
      'NA' AS type_exposure,
      CASE a.dev
        WHEN '840'
        THEN 'USD'
        WHEN '978'
        THEN 'EURO'
        WHEN '826'
        THEN 'GBP'
        ELSE 'NA'
      END AS currency,
      CASE
        WHEN SUM(a.sde) < 0
        THEN -1*SUM(a.sde)
        WHEN SUM(a.sde) > 0
        THEN SUM(a.sde)
      END AS for_cur_mnt ,
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(a.sdecv) > 0
        THEN SUM(a.sdecv)
      END          AS cedi_equiv ,
      MAX(a.txind) AS rate,
      a.dco        AS dco
    FROM bksld a
    WHERE a.ncp IN('17561100005')
    AND dev     !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dev,
      a.cli,
      a.dco
    )
  )
-- Scrolling list 10150 - END -
UNION
  -- Scrolling list 10160 - STATRT -
  (
  SELECT 'C'                             AS rank_scrolling,
    '10160'                              AS item_code,
    00000                                AS row_number,
    '    (b) Long-term borrowing'        AS item_desc,
    'NA'                                 AS type_exposure,
    'NA'                                 AS currency,
    0                                    AS for_cur_mnt,
    0                                    AS cedi_equiv,
    1                                    AS rate,
    to_date('&DATE_ARRETE','DD/MM/YYYY') AS dco
  FROM dual
  WHERE NOT EXISTS (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN ('20190','20200','20210')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev    !='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN('17561200002','17561200003','17561200004','17561200005','17561200006')
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  )
UNION
  (SELECT 'C'                     AS rank_scrolling,
    '10160'                       AS item_code,
    00000                         AS row_number,
    '    (b) Long-term borrowing' AS item_desc,
    'NA'                          AS type_exposure,
    'NA'                          AS currency,
    0                             AS for_cur_mnt,
    SUM(somme_cv)                 AS cedi_equiv,
    1                             AS rate,
    dco                           AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN ('20190','20200','20210')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev    !='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN('17561200002','17561200003','17561200004','17561200005','17561200006')
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  UNION
    (SELECT 'C'                                AS rank_scrolling,
      '10160'                                  AS item_code,
      ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
      CASE
        WHEN a.cli != '  '
        THEN a.cli
        ELSE 'NA'
      END  AS item_desc,
      'NA' AS type_exposure,
      CASE a.dev
        WHEN '840'
        THEN 'USD'
        WHEN '978'
        THEN 'EURO'
        WHEN '826'
        THEN 'GBP'
        ELSE 'NA'
      END AS currency,
      CASE
        WHEN SUM(a.sde) < 0
        THEN -1*SUM(a.sde)
        WHEN SUM(a.sde) > 0
        THEN SUM(a.sde)
      END AS for_cur_mnt ,
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(a.sdecv) > 0
        THEN SUM(a.sdecv)
      END          AS cedi_equiv ,
      MAX(a.txind) AS rate,
      a.dco        AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN('20190','20200','20210')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND dev      !='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dev,
      a.cli,
      a.dco
    UNION
    SELECT 'C'                                 AS rank_scrolling,
      '10160'                                  AS item_code,
      ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
      CASE
        WHEN a.cli != '  '
        THEN a.cli
        ELSE 'NA'
      END  AS item_desc,
      'NA' AS type_exposure,
      CASE a.dev
        WHEN '840'
        THEN 'USD'
        WHEN '978'
        THEN 'EURO'
        WHEN '826'
        THEN 'GBP'
        ELSE 'NA'
      END AS currency,
      CASE
        WHEN SUM(a.sde) < 0
        THEN -1*SUM(a.sde)
        WHEN SUM(a.sde) > 0
        THEN SUM(a.sde)
      END AS for_cur_mnt ,
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(a.sdecv) > 0
        THEN SUM(a.sdecv)
      END          AS cedi_equiv ,
      MAX(a.txind) AS rate,
      a.dco        AS dco
    FROM bksld a
    WHERE a.ncp IN('17561200002','17561200003','17561200004','17561200005','17561200006')
    AND dev     !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dev,
      a.cli,
      a.dco
    )
  )
-- Scrolling list 10160 - END -
UNION
  -- Scrolling list 10170 - STATRT -
  (
  SELECT 'C'                             AS rank_scrolling,
    '10170'                              AS item_code,
    00000                                AS row_number,
    '    (c) Deposits of non-residents'  AS item_desc,
    'NA'                                 AS type_exposure,
    'NA'                                 AS currency,
    0                                    AS for_cur_mnt,
    0                                    AS cedi_equiv,
    1                                    AS rate,
    to_date('&DATE_ARRETE','DD/MM/YYYY') AS dco
  FROM dual
  WHERE NOT EXISTS (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd = '20260'
    AND a.cha   >=b.cha1
    AND a.cha   <=b.cha2
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN('27250000006','27211000004')
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  )
UNION
  (SELECT 'C'                           AS rank_scrolling,
    '10170'                             AS item_code,
    00000                               AS row_number,
    '    (c) Deposits of non-residents' AS item_desc,
    'NA'                                AS type_exposure,
    'NA'                                AS currency,
    0                                   AS for_cur_mnt,
    SUM(somme_cv)                       AS cedi_equiv,
    1                                   AS rate,
    dco                                 AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd = '20260'
    AND a.cha   >=b.cha1
    AND a.cha   <=b.cha2
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN('27250000006','27211000004')
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  UNION
  SELECT 'C'                                 AS rank_scrolling,
    '10170'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN a.cli
      ELSE 'NA'
    END  AS item_desc,
    'NA' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    a.dco        AS dco
  FROM bksld a,
    gedefil b
  WHERE a.cha >=b.cha1
  AND a.cha   <=b.cha2
  AND b.nomd  IN('20260')
  AND dev     !='936'
  AND a.sdecv != 0
  AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dev,
    a.cli,
    a.dco
  UNION
  SELECT 'C'                                 AS rank_scrolling,
    '10170'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN a.cli
      ELSE 'NA'
    END  AS item_desc,
    'NA' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    a.dco        AS dco
  FROM bksld a
  WHERE a.ncp IN('27250000006','27211000004')
  AND dev     !='936'
  AND a.sdecv != 0
  AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dev,
    a.cli,
    a.dco
  )
-- Scrolling list 10170 - END -
UNION
  -- Scrolling list 10180 - START -
  (
  SELECT 'D'                 AS rank_scrolling,
    '10180'                  AS item_code,
    00000                    AS row_number,
    'D.DOMESTIC Liabilities' AS item_desc,
    'NA'                     AS type_exposure,
    'NA'                     AS currency,
    0                        AS for_cur_mnt,
    SUM(somme_cv)            AS cedi_equiv,
    1                        AS rate,
    dco                      AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN('21070','21080','21100','21110','21120','21150','21230','21240','21260','21270','21280')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev!    ='936'
    AND a.sdecv   > 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN('20470','20530','20660','20670','20710','21130','21140','21210','21220','21290','21570','21590')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev!    ='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN ('17561200001','17561000001','25261000001','25261000002','25261000003','25261000004','25261000005','25261000006','25261000007','25261000008','25262000001','25262000002','25262000003','25262000004','25262000005','25262000006','25262000007','25262000008','38220010009','38220020009','38220010010','38220020010','38220010011','38220020011','38220010012','38220020012','38220010013','38220020013', '38220010014','38220020014','38220010015','38220020015','27220000001','27211000005','37130000011','37130000013','37130000014','37429000001', '37431000001','37439000001','27250000001','37920000010','37120000002','37920000039','33220000028','33220000027','33220000018','33220000020', '33220000029','33230000001','33211000001','33211000001','33212000001','38250000010','37920000040','27250000003','10104000004','33290000001', '38250000002','38250000003','38250000009','27250000004','38220020018','37920000041','33290000001','37920000007')
    AND a.dev!   ='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  )
-- Scrolling list 10180 - END -
UNION
  -- Scrolling list 10190 - STATRT -
  (
  SELECT 'D'                             AS rank_scrolling,
    '10190'                              AS item_code,
    00000                                AS row_number,
    '    (a) Long-term Borrowings'       AS item_desc,
    'NA'                                 AS type_exposure,
    'NA'                                 AS currency,
    0                                    AS for_cur_mnt,
    0                                    AS cedi_equiv,
    1                                    AS rate,
    to_date('&DATE_ARRETE','DD/MM/YYYY') AS dco
  FROM dual
  WHERE NOT EXISTS (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN ('20470','20530')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev    !='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN ('17561200001')
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  )
UNION
  (SELECT 'D'                      AS rank_scrolling,
    '10190'                        AS item_code,
    00000                          AS row_number,
    '    (a) Long-term Borrowings' AS item_desc,
    'NA'                           AS type_exposure,
    'NA'                           AS currency,
    0                              AS for_cur_mnt,
    SUM(somme_cv)                  AS cedi_equiv,
    1                              AS rate,
    dco                            AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN ('20470','20530')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev    !='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN ('17561200001')
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  UNION
    (SELECT 'C'                                AS rank_scrolling,
      '10190'                                  AS item_code,
      ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
      CASE
        WHEN a.cli != '  '
        THEN a.cli
        ELSE 'NA'
      END  AS item_desc,
      'NA' AS type_exposure,
      CASE a.dev
        WHEN '840'
        THEN 'USD'
        WHEN '978'
        THEN 'EURO'
        WHEN '826'
        THEN 'GBP'
        ELSE 'NA'
      END AS currency,
      CASE
        WHEN SUM(a.sde) < 0
        THEN -1*SUM(a.sde)
        WHEN SUM(a.sde) > 0
        THEN SUM(a.sde)
      END AS for_cur_mnt ,
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(a.sdecv) > 0
        THEN SUM(a.sdecv)
      END          AS cedi_equiv ,
      MAX(a.txind) AS rate,
      a.dco        AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN('20470','20530')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    AND dev      !='936'
    GROUP BY a.dev,
      a.cli,
      a.dco
    UNION
    SELECT 'C'                                 AS rank_scrolling,
      '10190'                                  AS item_code,
      ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
      CASE
        WHEN a.cli != '  '
        THEN a.cli
        ELSE 'NA'
      END  AS item_desc,
      'NA' AS type_exposure,
      CASE a.dev
        WHEN '840'
        THEN 'USD'
        WHEN '978'
        THEN 'EURO'
        WHEN '826'
        THEN 'GBP'
        ELSE 'NA'
      END AS currency,
      CASE
        WHEN SUM(a.sde) < 0
        THEN -1*SUM(a.sde)
        WHEN SUM(a.sde) > 0
        THEN SUM(a.sde)
      END AS for_cur_mnt ,
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(a.sdecv) > 0
        THEN SUM(a.sdecv)
      END          AS cedi_equiv ,
      MAX(a.txind) AS rate,
      a.dco        AS dco
    FROM bksld a
    WHERE a.ncp IN('17561200001')
    AND dev     !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dev,
      a.cli,
      a.dco
    )
  )
-- Scrolling list 10190 - END -
UNION
  -- Scrolling list 10200 - STATRT -
  (
  SELECT 'D'                       AS rank_scrolling,
    '10200'                        AS item_code,
    00000                          AS row_number,
    '    (b) Short-term borrowing' AS item_desc,
    'NA'                           AS type_exposure,
    'NA'                           AS currency,
    0                              AS for_cur_mnt,
    SUM(somme_cv)                  AS cedi_equiv,
    1                              AS rate,
    dco                            AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN('20660','20670','20710')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev    !='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp ='17561000001'
    AND a.dev  !='936'
    GROUP BY a.dco
    ) )
  GROUP BY dco
  UNION
  SELECT 'D'                                 AS rank_scrolling,
    '10200'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN a.cli
      ELSE 'NA'
    END  AS item_desc,
    'NA' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    a.dco        AS dco
  FROM bksld a,
    gedefil b
  WHERE b.nomd IN('20660','20670','20710')
  AND a.cha    >=b.cha1
  AND a.cha    <=b.cha2
  AND a.dev    !='936'
  AND a.sdecv  != 0
  AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dev,
    a.cli,
    a.dco
  UNION
  SELECT 'D'                                 AS rank_scrolling,
    '10200'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN a.cli
      ELSE 'NA'
    END  AS item_desc,
    'NA' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    a.dco        AS dco
  FROM bksld a
  WHERE a.ncp  ='17561000001'
  AND a.dev   !='936'
  AND a.sdecv != 0
  AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dev,
    a.cli,
    a.dco
  )
-- Scrolling list 10200 - END -
UNION
  -- Scrolling list 10210 - STATRT -
  (
  SELECT 'D'                             AS rank_scrolling,
    '10210'                              AS item_code,
    00000                                AS row_number,
    '    (c) cheques for clearing'       AS item_desc,
    'NA'                                 AS type_exposure,
    'NA'                                 AS currency,
    0                                    AS for_cur_mnt,
    0                                    AS cedi_equiv,
    1                                    AS rate,
    to_date('&DATE_ARRETE','DD/MM/YYYY') AS dco
  FROM dual
  )
-- Scrolling list 10210 - END -
UNION
  -- Scrolling list 10220 - STATRT -
  (
  SELECT 'D'                             AS rank_scrolling,
    '10220'                              AS item_code,
    00000                                AS row_number,
    '    (d) Deposits of financial institutions'                 AS item_desc,
    'NA'                                 AS type_exposure,
    'NA'                                 AS currency,
    0                                    AS for_cur_mnt,
    0                                    AS cedi_equiv,
    1                                    AS rate,
    to_date('&DATE_ARRETE','DD/MM/YYYY') AS dco
  FROM dual
  )
-- Scrolling list 10220 - END -
UNION
  -- Scrolling list 10230 - STATRT -
  (
  SELECT 'D'                                                          AS rank_scrolling,
    '10230'                                                           AS item_code,
    00000                                                             AS row_number,
    '    (e) Deposits of non-financial institutions public and govt.' AS item_desc,
    'NA'                                                              AS type_exposure,
    'NA'                                                              AS currency,
    0                                                                 AS for_cur_mnt,
    SUM(somme_cv)                                                     AS cedi_equiv,
    1                                                                 AS rate,
    dco                                                               AS dco
  FROM (
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN ('21070','21080','21100','21110','21120','21150','21230','21240','21260','21270','21280')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND sdecv     > 0
    AND a.dev    !='936'
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN ('21130','21140','21210','21220','21290')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev    !='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    )
  UNION
    (SELECT
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(sdecv) > 0
        THEN SUM(a.sdecv)
      END   AS somme_cv,
      a.dco AS dco
    FROM bksld a
    WHERE a.ncp IN ('25261000001','25261000002','25261000003','25261000004','25261000005','25261000006','25261000007','25261000008','25262000001','25262000002','25262000003','25262000004','25262000005','25262000006','25262000007','25262000008') --21290--
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dco
    ) )
  GROUP BY dco
  UNION
  SELECT 'D'                                        AS rank_scrolling,
    '10230'                                         AS item_code,
    ROW_NUMBER() OVER (ORDER BY currency,item_desc) AS row_number,
    item_desc                                       AS item_desc,
    'Deposit'                                       AS type_exposure,
    currency                                        AS currency,
    SUM(for_cur_mnt)                                AS for_cur_mnt ,
    SUM(cedi_equiv)                                 AS cedi_equiv ,
    rate                                            AS rate,
    dco                                             AS dco
  FROM
    (SELECT 'D'                                AS rank_scrolling,
      '10230'                                  AS item_code,
      ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
      CASE
        WHEN b.nomd IN ('21070','21080','21100','21110')
        THEN 'Demand'
        WHEN b.nomd IN ('21140','21150')
        THEN 'Savings'
        WHEN b.nomd IN ('21220','21230','21240','21260','21270')
        THEN 'Time'
        WHEN b.nomd IN ('21120','21280')
        THEN 'Others'
        WHEN b.nomd IN ('21130','21290','21210')
        THEN 'ACCRUED INTEREST'
      END       AS item_desc,
      'Deposit' AS type_exposure,
      CASE a.dev
        WHEN '840'
        THEN 'USD'
        WHEN '978'
        THEN 'EURO'
        WHEN '826'
        THEN 'GBP'
        ELSE 'NA'
      END AS currency,
      CASE
        WHEN SUM(a.sde) < 0
        THEN -1*SUM(a.sde)
        WHEN SUM(a.sde) > 0
        THEN SUM(a.sde)
      END AS for_cur_mnt ,
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(a.sdecv) > 0
        THEN SUM(a.sdecv)
      END          AS cedi_equiv ,
      MAX(a.txind) AS rate,
      a.dco        AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN ('21130','21140','21210','21220','21290')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev    !='936'
    AND a.sdecv  != 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dev,
      a.cli,
      b.nomd,
      a.dco
    UNION
    SELECT 'D'                                 AS rank_scrolling,
      '10230'                                  AS item_code,
      ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
      CASE
        WHEN b.nomd IN ('21070','21080','21100','21110')
        THEN 'Demand'
        WHEN b.nomd IN ('21140','21150')
        THEN 'Savings'
        WHEN b.nomd IN ('21220','21230','21240','21260','21270')
        THEN 'Time'
        WHEN b.nomd IN ('21120','21280')
        THEN 'Others'
        WHEN b.nomd IN ('21130','21290','21210')
        THEN 'ACCRUED INTEREST'
      END       AS item_desc,
      'Deposit' AS type_exposure,
      CASE a.dev
        WHEN '840'
        THEN 'USD'
        WHEN '978'
        THEN 'EURO'
        WHEN '826'
        THEN 'GBP'
        ELSE 'NA'
      END AS currency,
      CASE
        WHEN SUM(a.sde) < 0
        THEN -1*SUM(a.sde)
        WHEN SUM(a.sde) > 0
        THEN SUM(a.sde)
      END AS for_cur_mnt ,
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(a.sdecv) > 0
        THEN SUM(a.sdecv)
      END          AS cedi_equiv ,
      MAX(a.txind) AS rate,
      a.dco        AS dco
    FROM bksld a,
      gedefil b
    WHERE b.nomd IN ('21070','21080','21100','21110','21120','21150','21230','21240','21260','21270','21280')
    AND a.cha    >=b.cha1
    AND a.cha    <=b.cha2
    AND a.dev    !='936'
    AND a.sdecv   > 0
    AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dev,
      a.cli,
      b.nomd,
      a.dco
    UNION
    SELECT 'D'                                 AS rank_scrolling,
      '10230'                                  AS item_code,
      ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
      CASE
        WHEN (SELECT COUNT(*)
          FROM gedefil
          WHERE nomd                      IN ( '21070','21080','21100','21110')
          AND a.cha BETWEEN cha1 AND cha2) > 0
        THEN 'Demand'
        WHEN (SELECT COUNT(*)
          FROM gedefil
          WHERE nomd                      IN ('21140','21150')
          AND a.cha BETWEEN cha1 AND cha2) > 0
        THEN 'Savings'
        WHEN (SELECT COUNT(*)
          FROM gedefil
          WHERE nomd                      IN ('21220','21230','21240','21260','21270')
          AND a.cha BETWEEN cha1 AND cha2) > 0
        THEN 'Time'
        WHEN (SELECT COUNT(*)
          FROM gedefil
          WHERE nomd                      IN ('21120','21280')
          AND a.cha BETWEEN cha1 AND cha2) > 0
        THEN 'Others'
        WHEN (SELECT COUNT(*)
          FROM gedefil
          WHERE nomd                      IN ('21130','21290','21210')
          AND a.cha BETWEEN cha1 AND cha2) > 0
        THEN 'ACCRUED INTEREST'
      END       AS item_desc,
      'Deposit' AS type_exposure,
      CASE a.dev
        WHEN '840'
        THEN 'USD'
        WHEN '978'
        THEN 'EURO'
        WHEN '826'
        THEN 'GBP'
        ELSE 'NA'
      END AS currency,
      CASE
        WHEN SUM(a.sde) < 0
        THEN -1*SUM(a.sde)
        WHEN SUM(a.sde) > 0
        THEN SUM(a.sde)
      END AS for_cur_mnt ,
      CASE
        WHEN SUM(a.sdecv) < 0
        THEN -1*SUM(a.sdecv)
        WHEN SUM(a.sdecv) > 0
        THEN SUM(a.sdecv)
      END          AS cedi_equiv ,
      MAX(a.txind) AS rate,
      a.dco        AS dco
    FROM bksld a
    WHERE a.ncp IN ('25261000001','25261000002','25261000003','25261000004','25261000005','25261000006','25261000007','25261000008','25262000001','25262000002','25262000003','25262000004','25262000005','25262000006','25262000007','25262000008') --21290--
    AND a.dev   !='936'
    AND a.sdecv != 0
    AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
    GROUP BY a.dev,
      a.cli,
      a.cha,
      a.dco
    )
  GROUP BY item_desc,
    currency,
    rate ,
    dco
  )
-- Scrolling list 10230 - END -
UNION
  -- Scrolling list 10300 - STATRT -
  (
  SELECT 'D'                             AS rank_scrolling,
    '10300'                              AS item_code,
    00000                                AS row_number,
    '    (f) Special deposits'           AS item_desc,
    'NA'                                 AS type_exposure,
    'GHS'                                AS currency,
    0                                    AS for_cur_mnt,
    0                                    AS cedi_equiv,
    1                                    AS rate,
    to_date('&DATE_ARRETE','dd/mm/yyyy') AS dco
  FROM dual
  )
-- Scrolling list 10300 - END -
UNION
  -- Scrolling list 10310 - STATRT -
  (
  SELECT 'D'                                         AS rank_scrolling,
    '10310'                                          AS item_code,
    00000                                            AS row_number,
    '    (g) Margins against contingent Liabilities' AS item_desc,
    'NA'                                             AS type_exposure,
    'NA'                                             AS currency,
    0                                                AS for_cur_mnt,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END   AS cedi_equiv ,
    1     AS rate,
    a.dco AS dco
  FROM bksld a,
    gedefil b
  WHERE b.nomd IN ('21570')
  AND a.cha    >=b.cha1
  AND a.cha    <=b.cha2
  AND a.dev    !='936'
  AND a.sdecv  != 0
  AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dco
  UNION
  SELECT 'D'                                 AS rank_scrolling,
    '10310'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN a.cli
      ELSE 'NA'
    END               AS item_desc,
    'CASH MARGIN  LC' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    a.dco        AS dco
  FROM bksld a,
    gedefil b
  WHERE b.nomd IN ('21570')
  AND a.cha    >=b.cha1
  AND a.cha    <=b.cha2
  AND a.sdecv  != 0
  AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
  AND a.dev    !='936'
  GROUP BY a.dev,
    a.cli,
    a.dco
  )
-- Scrolling list 10310 - END -
UNION
-- Scrolling list 10320 - STATRT -
SELECT 'D'                    AS rank_scrolling,
  '10320'                     AS item_code,
  00000                       AS row_number,
  '    (h) Other Liabilities' AS item_desc,
  'NA'                        AS type_exposure,
  'GHS'                       AS currency,
  0                           AS for_cur_mnt,
  SUM(somme_cv)               AS cedi_equiv,
  1                           AS rate,
  dco                         AS dco
FROM (
  (SELECT
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(sdecv) > 0
      THEN SUM(a.sdecv)
    END   AS somme_cv,
    a.dco AS dco
  FROM bksld a,
    gedefil b
  WHERE b.nomd = '21590'
  AND a.cha   >=b.cha1
  AND a.cha   <=b.cha2
  AND a.dev   !='936'
  AND a.sdecv != 0
  AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dco
  )
UNION
  (SELECT
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(sdecv) > 0
      THEN SUM(a.sdecv)
    END   AS somme_cv,
    a.dco AS dco
  FROM bksld a
  WHERE a.ncp IN ('38220010009','38220020009','38220010010','38220020010','38220010011','38220020011','38220010012','38220020012','38220010013','38220020013', '38220010014','38220020014','38220010015','38220020015','27220000001','27211000005','37130000011','37130000013','37130000014','37429000001', '37431000001','37439000001','27250000001','37920000010','37120000002','37920000039','33220000028','33220000027','33220000018','33220000020', '33220000029','33230000001','33211000001','33211000001','33212000001','38250000010','37920000040','27250000003','10104000004','33290000001', '38250000002','38250000003','38250000009','27250000004','38220020018','37920000041','33290000001','37920000007')
  AND a.dev   !='936'
  AND a.sdecv != 0
  AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dco
  ) )
GROUP BY dco
UNION
SELECT 'D'                                 AS rank_scrolling,
  '10320'                                  AS item_code,
  ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
  (select distinct inti from bkcom where cli=a.cli and ncp=a.ncp and dev=a.dev and age=a.age) AS item_desc,
  'CASH MARGIN  LC' AS type_exposure,
  CASE a.dev
    WHEN '840'
    THEN 'USD'
    WHEN '978'
    THEN 'EURO'
    WHEN '826'
    THEN 'GBP'
    ELSE 'NA'
  END AS currency,
  CASE
    WHEN SUM(a.sde) < 0
    THEN -1*SUM(a.sde)
    WHEN SUM(a.sde) > 0
    THEN SUM(a.sde)
  END AS for_cur_mnt ,
  CASE
    WHEN SUM(a.sdecv) < 0
    THEN -1*SUM(a.sdecv)
    WHEN SUM(a.sdecv) > 0
    THEN SUM(a.sdecv)
  END          AS cedi_equiv ,
  MAX(a.txind) AS rate,
  a.dco        AS dco
FROM bksld a,
  gedefil b
WHERE b.nomd IN ('21590')
AND a.cha    >=b.cha1
AND a.cha    <=b.cha2
AND a.dev    !='936'
AND a.sdecv  != 0
AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
GROUP BY a.dev,
  a.cli,
  a.dco,
  a.ncp,
  a.age
UNION
SELECT 'D'                                 AS rank_scrolling,
  '10320'                                  AS item_code,
  ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
  (select distinct inti from bkcom where cli=a.cli and ncp=a.ncp and dev=a.dev and age=a.age) AS item_desc,
  'CASH MARGIN  LC' AS type_exposure,
  CASE a.dev
    WHEN '840'
    THEN 'USD'
    WHEN '978'
    THEN 'EURO'
    WHEN '826'
    THEN 'GBP'
    ELSE 'NA'
  END AS currency,
  CASE
    WHEN SUM(a.sde) < 0
    THEN -1*SUM(a.sde)
    WHEN SUM(a.sde) > 0
    THEN SUM(a.sde)
  END AS for_cur_mnt ,
  CASE
    WHEN SUM(a.sdecv) < 0
    THEN -1*SUM(a.sdecv)
    WHEN SUM(a.sdecv) > 0
    THEN SUM(a.sdecv)
  END          AS cedi_equiv ,
  MAX(a.txind) AS rate,
  a.dco        AS dco
FROM bksld a
WHERE a.ncp IN ('38220010009','38220020009','38220010010','38220020010','38220010011','38220020011','38220010012','38220020012','38220010013','38220020013', '38220010014','38220020014','38220010015','38220020015','27220000001','27211000005','37130000011','37130000013','37130000014','37429000001', '37431000001','37439000001','27250000001','37920000010','37120000002','37920000039','33220000028','33220000027','33220000018','33220000020', '33220000029','33230000001','33211000001','33211000001','33212000001','38250000010','37920000040','27250000003','10104000004','33290000001', '38250000002','38250000003','38250000009','27250000004','38220020018','37920000041','33290000001','37920000007')
AND a.dev   !='936'
AND a.sdecv != 0
AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
GROUP BY a.dev,
  a.cli,
  a.dco,
  a.ncp,
  a.age
-- Scrolling list 10320 - END -
UNION
  -- Scrolling list 10330 - START -
  (
  SELECT 'E'                   AS rank_scrolling,
    '10330'                    AS item_code,
    00000                      AS row_number,
    'E.CONTINGENT Liabilities' AS item_desc,
    'NA'                       AS type_exposure,
    'GHS'                      AS currency,
    0                          AS for_cur_mnt,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END   AS cedi_equiv ,
    1     AS rate,
    a.dco AS dco
  FROM bksld a,
    gedefil b
  WHERE b.nomd IN ('21630A','21630B')
  AND a.cha    >=b.cha1
  AND a.cha    <=b.cha2
  AND a.sdecv  != 0
  AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
  AND a.dev    !='936'
  GROUP BY a.dco
  )
-- Scrolling list 10330 - END -
UNION
  -- Scrolling list 10340 - STATRT -
  (
  SELECT 'E'                   AS rank_scrolling,
    '10340'                    AS item_code,
    00000                      AS row_number,
    '   Customers Liabilities' AS item_desc,
    'NA'                       AS type_exposure,
    'GHS'                      AS currency,
    0                          AS for_cur_mnt,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END   AS cedi_equiv ,
    1     AS rate,
    a.dco AS dco
  FROM bksld a,
    gedefil b
  WHERE b.nomd IN ('21630A')
  AND a.cha    >=b.cha1
  AND a.cha    <=b.cha2
  AND a.dev    !='936'
  AND a.sdecv  != 0
  AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dco
  UNION
  SELECT 'E'                                 AS rank_scrolling,
    '10340'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN a.cli
      ELSE 'NA'
    END  AS item_desc,
    'LC' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    a.dco        AS dco
  FROM bksld a,
    gedefil b
  WHERE a.cha >=b.cha1
  AND a.cha   <=b.cha2
  AND b.nomd  IN ('21630A')
  AND a.dev   !='936'
  AND a.sdecv != 0
  AND a.dco    =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dev,
    a.cli,
    a.dco
  )
-- Scrolling list 10340 - END -
UNION
  -- Scrolling list 10350 - STATRT -
  (
  SELECT 'E'                 AS rank_scrolling,
    '10350'                  AS item_code,
    00000                    AS row_number,
    '   Bonds and Guarantee' AS item_desc,
    'NA'                     AS type_exposure,
    'GHS'                    AS currency,
    0                        AS for_cur_mnt,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END   AS cedi_equiv ,
    1     AS rate,
    a.dco AS dco
  FROM bksld a,
    gedefil b
  WHERE b.nomd IN ('21630B')
  AND a.cha    >=b.cha1
  AND a.cha    <=b.cha2
  AND a.dev    !='936'
  AND a.sdecv  != 0
  AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
  GROUP BY a.dco
  UNION
  SELECT 'E'                                 AS rank_scrolling,
    '10350'                                  AS item_code,
    ROW_NUMBER() OVER (ORDER BY a.dev,a.cli) AS row_number,
    CASE
      WHEN a.cli != '  '
      THEN a.cli
      ELSE 'NA'
    END              AS item_desc,
    'Bank Guarantee' AS type_exposure,
    CASE a.dev
      WHEN '840'
      THEN 'USD'
      WHEN '978'
      THEN 'EURO'
      WHEN '826'
      THEN 'GBP'
      ELSE 'NA'
    END AS currency,
    CASE
      WHEN SUM(a.sde) < 0
      THEN -1*SUM(a.sde)
      WHEN SUM(a.sde) > 0
      THEN SUM(a.sde)
    END AS for_cur_mnt ,
    CASE
      WHEN SUM(a.sdecv) < 0
      THEN -1*SUM(a.sdecv)
      WHEN SUM(a.sdecv) > 0
      THEN SUM(a.sdecv)
    END          AS cedi_equiv ,
    MAX(a.txind) AS rate,
    a.dco        AS dco
  FROM bksld a,
    gedefil b
  WHERE b.nomd IN ('21630B')
  AND a.cha    >=b.cha1
  AND a.cha    <=b.cha2
  AND a.sdecv  != 0
  AND a.dco     =to_date('&DATE_ARRETE','DD/MM/YYYY')
  AND a.dev    !='936'
  GROUP BY a.dev,
    a.cli,
    a.dco
  )
  -- Scrolling list 10350 - END -
  );