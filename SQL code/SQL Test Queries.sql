-- Which employee has the most overall sales?
SELECT
    e.empid,
    empname,
    COUNT(e.empid) AS "SALES COUNT"
FROM
         employee e
    JOIN purchase p ON e.empid = p.empid
GROUP BY
    e.empid,
    empname
HAVING
    COUNT(e.empid) >= ALL (
        SELECT
            COUNT(e.empid)
        FROM
                 employee e
            JOIN purchase p ON e.empid = p.empid
        GROUP BY
            e.empid
    );

-- Which customer purchased the most products in November 2020?
SELECT
    c.custid,
    c.custname,
    COUNT(c.custid) AS "PURCHASES"
FROM
         customer c
    JOIN purchase p ON c.custid = p.custid
WHERE
    p.purchasedate BETWEEN '01/NOV/20' AND '30/NOV/20'
GROUP BY
    c.custid,
    c.custname
HAVING
    COUNT(c.custid) >= ALL (
        SELECT
            COUNT(c.custid)
        FROM
                 customer c
            JOIN purchase p ON c.custid = p.custid
        WHERE
            p.purchasedate BETWEEN '01/NOV/20' AND '30/NOV/20'
        GROUP BY
            c.custid
    );
                          
-- How many sales were made on 07/DEC/20?
SELECT
    SUM(COUNT(purchaseno)) AS "TOTAL SALES"
FROM
    purchase
WHERE
    purchasedate = '07/DEC/20'
GROUP BY
    purchaseno;

-- How many phone contracts were sold as purchases on 07/DEC/20?
SELECT
    SUM(COUNT(contractno)) AS "CONTRACTS SOLD"
FROM
    contract  c,
    purchase  p
WHERE
        c.purchaseno = p.purchaseno
    AND p.purchasedate = '07/DEC/20'
GROUP BY
    contractno;

-- What is the most popular selling make and model of phone?
SELECT
    make,
    model,
    COUNT(model) AS "SOLD"
FROM
         phones ph
    JOIN purchase pu ON pu.productcode = ph.productcode
GROUP BY
    make,
    model
HAVING
    COUNT(model) >= ALL (
        SELECT
            COUNT(model)
        FROM
                 phones ph
            JOIN purchase pu ON pu.productcode = ph.productcode
        GROUP BY
            make,
            model
    );

-- What is the cost difference between retailPrice and average contractPrice for the Apple model irj-11736694U?
SELECT DISTINCT
    make,
    model,
    contractterm,
    retailprice,
    round(AVG(contractprice))                      AS "AVERAGE CONTRACTPRICE",
    round(AVG(contractprice)) - retailprice        AS "COST DIFFERENCE"
FROM
    phones    ph,
    purchase  pu,
    contract  cu
WHERE
        pu.productcode = ph.productcode
    AND pu.purchaseno = cu.purchaseno
    AND model = 'irj-11736694U'
GROUP BY
    make,
    model,
    contractterm,
    retailprice
ORDER BY
    contractterm;
 
-- What is the cost difference between supplyPrice and retailPrice for the Apple model irj-11736694U?
SELECT
    make,
    model,
    retailprice,
    supplyprice,
    ( retailprice - supplyprice ) AS "COST DIFFERENCE"
FROM
         phones p
    JOIN supply s ON p.productcode = s.productcode
WHERE
    model = 'irj-11736694U';

-- Which supplier last supplied an Apple model phone?
SELECT
    suppliername,
    make,
    MAX(supplydate) AS "SUPPLYDATE"
FROM
    supply  s,
    phones  p
WHERE
        s.productcode = p.productcode
    AND make = 'Apple'
GROUP BY
    suppliername,
    make
HAVING
    MAX(supplydate) >= ALL (
        SELECT
            MAX(supplydate)
        FROM
            supply  s,
            phones  p
        WHERE
                s.productcode = p.productcode
            AND make = 'Apple'
    );

-- How many products were received on 01/DEC/20?
SELECT
    supplydate,
    SUM(supplyquantity) AS "PRODUCTS RECEIVED"
FROM
    supply
WHERE
    supplydate = '15/SEP/20'
GROUP BY
    supplydate;
