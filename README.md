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

The database is subject to the following business rules:

* Information about The Happy Phone Company employees includes an employee ID, name and position.

* Each customer of The Happy Phone Company is identified by a customer ID and has a name.

* Suppliers to The Happy Phone Company have a unique name and contact phone number.

* Phones stocked by The Happy Phone Company are described by a product code, retail price and stock quantity.

* Details of phones need to be kept, including make and model information.

* Contracts supplied by The Happy Phone Company are described by a contract number, contract term in months and contract price.

* A phone must have at least one supplier and each supplier can supply many phones. When a supplier supplies a phone, data includes a supply price, the quantity supplied and the date of the supply. If a supplier provides several supplies of a phone, only data for the most recent supply is kept.

* Details of a purchase by a customer shall include the date of purchase and a contract number (if applicable). A customer can purchase several phones in a single day and the details of each purchase must be kept.

<h2><p align="center">Functional Dependencies of the Business Rules</p></h2>

employee ID &#8594; employee name, position

customer ID &#8594; customer name

supplier name &#8594; phone number

product code &#8594; make, model, retail price, stock quantity

purchase number, contract number &#8594; contract term, contract price

supplier name, product code &#8594; supply price, supply quantity, supply date

purchase number &#8594; customer ID, product code, employee ID, purchase date

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

<meta charset="utf8" />
<html>
  <script src='/dist/sql-wasm.js'></script>
  <script>
    config = {
      locateFile: filename => `/dist/${filename}`
    }
    // The `initSqlJs` function is globally provided by all of the main dist files if loaded in the browser.
    // We must specify this locateFile function if we are loading a wasm file from anywhere other than the current html page's folder.
    initSqlJs(config).then(function(SQL){
      //Create the database
      var db = new SQL.Database();
      // Run a query without reading the results
      db.run("CREATE TABLE test (col1, col2);");
      // Insert two rows: (1,111) and (2,222)
      db.run("INSERT INTO test VALUES (?,?), (?,?)", [1,111,2,222]);

      // Prepare a statement
      var stmt = db.prepare("SELECT * FROM test WHERE col1 BETWEEN $start AND $end");
      stmt.getAsObject({$start:1, $end:1}); // {col1:1, col2:111}

      // Bind new values
      stmt.bind({$start:1, $end:2});
      while(stmt.step()) { //
        var row = stmt.getAsObject();
        console.log('Here is a row: ' + JSON.stringify(row));
      }
    });
  </script>
  <body>
    Output is in Javascript console
  </body>
</html>
