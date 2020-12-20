<h1><p align="center">Designing and Testing a Database for The Happy Phone Company</p></h1>

<p align="center"><b>Author</b></p>
<a href="https://github.com/j-b-ferguson"><p align="center">Justin Ferguson GitHub</p></a>
<a href="https://www.linkedin.com/in/jf2749/"><p align="center">Justin Ferguson LinkedIn</p></a>
<a href="mailto:justin.benjamin.ferguson@gmail.com?subject=GitHub%20Enquiry"><p align="center">Contact</p></a>

<h2><p align="center">Background</p></h2>

<p align="justify">
The Happy Phone Company is a fictitious retailer of various makes and models of mobile phones. The business requires a new database to help manage data concerning employees, customers, suppliers, phones and contracts.
</p>

<h2><p align="center">Business Rules</p></h2>

The database must satisfy the following business rules:

* Information about The Happy Phone Company employees includes an employee ID, name and position.

* Each customer of The Happy Phone Company is identified by a customer ID and has a name.

* Suppliers to The Happy Phone Company have a unique name and contact phone number.

* Phones stocked by The Happy Phone Company are described by a product code, retail price and stock quantity.

* Details of phones need to be kept, including make and model information.

* Contracts supplied by The Happy Phone Company are described by a contract number, contract term in months and contract price.

* A phone must have at least one supplier and each supplier can supply many phones. When a supplier supplies a phone, data includes a supply price, the quantity supplied and the date of the supply. If a supplier provides several supplies of a phone, only data for the most recent supply is kept.

* Details of a purchase by a customer shall include the date of purchase and a contract number (if applicable). A customer can purchase several phones in a single day and the details of each purchase must be kept.

<h2><p align="center">Functional Dependencies of the Business Rules</p></h2>

The first step in creating a relational database is to obtain the functional dependencies from the business rules. A functional dependency is a logical relationship between two sets of attributes X={X<sub>1</sub>, X<sub>2</sub>, ..., X<sub>n</sub>} and Y={Y<sub>1</sub>, Y<sub>2</sub>, ..., Y<sub>n</sub>}. A functional dependency must satisfy the criteria X &#8594; Y, where the arrow notation is read in plain english as <i>determine</i>. In other words, all attributes together in X determine any attribute in Y, and any attribute in Y must be related to those in X.

The following are the set of minimal basis functional dependencies drawn from the business rules:

employee ID &#8594; employee name, position

customer ID &#8594; customer name

supplier name &#8594; phone number

product code &#8594; make, model, retail price, stock quantity

purchase number, contract number &#8594; contract term, contract price

supplier name, product code &#8594; supply price, supply quantity, supply date

purchase number &#8594; customer ID, product code, employee ID, purchase date

<h2><p align="center">Normalisation</p></h2>

The process of normalisation in database design removes data redundancy by measuring the goodness of a relational schema with respect to the <i>normal forms</i>. An important concept in normalisation is the <i>key</i> of a relation. As a functional dependency X &#8594; Y, a key is the set of attributes in X that completely determine the remaining attributes in Y of a relation.

The following points describe the levels of normal forms, where higher normal forms remove data redundancy more deeply.

First Normal Form (1NF): Attributes of a relation are atomic values and do not contain sets of values.

Second Normal Form (2NF): Non-key attributes of a relation must be fully functionally dependent on a key.

Third Normal Form (3NF): A functional dependency FD X &#8594; Y of a relation must have X as a candidate key or Y as part of a (possibly different) candidate key

Boyce-Codd Normal Form (BCNF): A functional dependency FD X &#8594; Y where X is a key of the relation.

The standard for this database is either 3NF or BCNF. The keys of the relations inferred from the minimal set of functional dependencies are {employee ID}, {customer ID}, {supplier name}, {product code}, {purchase number, contract number}, {supplier name, product code}, {purchase number}. With respect to the definitions above, the relations are all in BCNF.

<h2><p align="center">Modelling the Business Rules</p></h2>

<p align="center"><img src="https://github.com/j-b-ferguson/business-database-design-and-test/blob/main/ER%20Model/ER%20Model%20-%20The%20Happy%20Phone%20Company.png" width=80% height=80%></p>

<h2><p align="center">ER Model to Relational Database Schema Mapping</p></h2>

Supplier(<ins>supplierName</ins>, contactPhone)

Supply(<ins>supplierName*, productCode*</ins>, supplyPrice, supplyQuantity, supplyDate)

Phones(<ins>productCode</ins>, make, model, stockQuantity, retailPrice)

Customer(<ins>custID</ins>, custName)

Purchase(<ins>purchaseNo</ins>, purchaseDate, custID*, productCode*, empID*)

Contract(<ins>contractNo, purchaseNo*</ins>, contractTerm, contractPrice)

Employee(<ins>empID</ins>, empName, position)

<h2><p align="center">Testing the Relational Database in Oracle with SQL Queries</p></h2>

```sql
-- Which employee had the most overall sales?
SQL> SELECT
  2      e.empid,
  3      empname,
  4      COUNT(e.empid) AS "SALES COUNT"
  5  FROM
  6           employee e
  7      JOIN purchase p ON e.empid = p.empid
  8  GROUP BY
  9      e.empid,
 10      empname
 11  HAVING
 12      COUNT(e.empid) >= ALL (
 13          SELECT
 14              COUNT(e.empid)
 15          FROM
 16                   employee e
 17              JOIN purchase p ON e.empid = p.empid
 18          GROUP BY
 19              e.empid
 20      );

EMPID EMPNAME          SALES COUNT
----- ---------------- -----------
6     Kleon Dewey              107                                              
```

```sql
-- Which customer purchased the most products in November 2020?
SQL> SELECT
  2      c.custid,
  3      c.custname,
  4      COUNT(c.custid) AS "PURCHASES"
  5  FROM
  6           customer c
  7      JOIN purchase p ON c.custid = p.custid
  8  WHERE
  9      p.purchasedate BETWEEN '01/NOV/20' AND '30/NOV/20'
 10  GROUP BY
 11      c.custid,
 12      c.custname
 13  HAVING
 14      COUNT(c.custid) >= ALL (
 15          SELECT
 16              COUNT(c.custid)
 17          FROM
 18                   customer c
 19              JOIN purchase p ON c.custid = p.custid
 20          WHERE
 21              p.purchasedate BETWEEN '01/NOV/20' AND '30/NOV/20'
 22          GROUP BY
 23              c.custid
 24      );

CUSTID CUSTNAME                   PURCHASES
------ ------------------------- ----------
696    Fanya Attard                       2
```

```sql
-- How many sales were made on 07/DEC/20?
SQL> SELECT
  2      SUM(COUNT(purchaseno)) AS "TOTAL SALES"
  3  FROM
  4      purchase
  5  WHERE
  6      purchasedate = '07/DEC/20'
  7  GROUP BY
  8      purchaseno;

TOTAL SALES
-----------
          3
```

```sql
-- How many phone contracts were sold as purchases on 07/DEC/20?
SQL> SELECT
  2      SUM(COUNT(contractno)) AS "CONTRACTS SOLD"
  3  FROM
  4      contract  c,
  5      purchase  p
  6  WHERE
  7          c.purchaseno = p.purchaseno
  8      AND p.purchasedate = '07/DEC/20'
  9  GROUP BY
 10      contractno;

CONTRACTS SOLD
--------------
             1
```

```sql
-- What is the most popular selling make and model of phone?
SQL> SELECT
  2      make,
  3      model,
  4      COUNT(model) AS "SOLD"
  5  FROM
  6           phones ph
  7      JOIN purchase pu ON pu.productcode = ph.productcode
  8  GROUP BY
  9      make,
 10      model
 11  HAVING
 12      COUNT(model) >= ALL (
 13          SELECT
 14              COUNT(model)
 15          FROM
 16                   phones ph
 17              JOIN purchase pu ON pu.productcode = ph.productcode
 18          GROUP BY
 19              make,
 20              model
 21      );

MAKE              MODEL               SOLD
----------------- ------------- ----------
Apple             irj-11736694U         25
```

```sql
-- What is the cost difference between retailPrice and average contractPrice for the Apple model irj-11736694U?
SQL> SELECT DISTINCT
  2      make,
  3      model,
  4      contractterm,
  5      retailprice,
  6      round(AVG(contractprice))                      AS "AVERAGE CONTRACTPRICE",
  7      round(AVG(contractprice)) - retailprice        AS "COST DIFFERENCE"
  8  FROM
  9      phones    ph,
 10      purchase  pu,
 11      contract  co
 12  WHERE
 13          pu.productcode = ph.productcode
 14      AND pu.purchaseno = co.purchaseno
 15      AND model = 'irj-11736694U'
 16  GROUP BY
 17      make,
 18      model,
 19      contractterm,
 20      retailprice
 21  ORDER BY
 22      contractterm;

MAKE              MODEL         CONTRACTTERM RETAILPRICE AVERAGE CONTRACTPRICE COST DIFFERENCE
----------------- ------------- ------------ ----------- --------------------- ---------------
Apple             irj-11736694U           12        1131                  1196              65
Apple             irj-11736694U           24        1131                  1752             621
Apple             irj-11736694U           36        1131                  2079             948
```

```sql
-- What is the cost difference between supplyPrice and retailPrice for the Apple model irj-11736694U?
SQL> SELECT
  2      make,
  3      model,
  4      retailprice,
  5      supplyprice,
  6      ( retailprice - supplyprice ) AS "COST DIFFERENCE"
  7  FROM
  8           phones p
  9      JOIN supply s ON p.productcode = s.productcode
 10  WHERE
 11      model = 'irj-11736694U';

MAKE              MODEL         RETAILPRICE SUPPLYPRICE COST DIFFERENCE
----------------- ------------- ----------- ----------- ---------------
Apple             irj-11736694U        1131         314             817
```

```sql
-- Which supplier last supplied an Apple model phone?
SQL> SELECT
  2      suppliername,
  3      make,
  4      MAX(supplydate) AS "SUPPLYDATE"
  5  FROM
  6      supply  s,
  7      phones  p
  8  WHERE
  9          s.productcode = p.productcode
 10      AND make = 'Apple'
 11  GROUP BY
 12      suppliername,
 13      make
 14  HAVING
 15      MAX(supplydate) >= ALL (
 16          SELECT
 17              MAX(supplydate)
 18          FROM
 19              supply  s,
 20              phones  p
 21          WHERE
 22                  s.productcode = p.productcode
 23              AND make = 'Apple'
 24      );

SUPPLIERNAME                   MAKE  SUPPLYDATE
------------------------------ ----- ----------
Larson Inc                     Apple  13-DEC-20
```

```sql
-- How many products were received on 01/DEC/20?
SQL> SELECT
  2      supplydate,
  3      SUM(supplyquantity) AS "PRODUCTS RECEIVED"
  4  FROM
  5      supply
  6  WHERE
  7      supplydate = '15/SEP/20'
  8  GROUP BY
  9      supplydate;

SUPPLYDATE PRODUCTS RECEIVED
---------- -----------------
15-SEP-20                 21
```
