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

<h2><p align="center">Modelling the Business Rules</p></h2>

<p align="center"><img src="https://github.com/j-b-ferguson/business-database-design-and-test/blob/main/ER%20Model/ER%20Model%20-%20The%20Happy%20Phone%20Company.png" width=80% height=80%></p>

<h2><p align="center">ER Model to Relational Database Schema Mapping</p></h2>

<p style="text-decoration: underline;">Supplier(<u>supplierName</u>, contactPhone)</p>

Supply(<u>supplierName*, productCode*</u>, supplyPrice, supplyQuantity, supplyDate)

Phones(<u>productCode</u>, make, model, stockQuantity, retailPrice)

Customer(<u>custID</u>, custname)

Purchase(<u>purchaseNo</u>, purchaseDate, custID*, productCode*, empID*)

Contract(<u>contractNo, purchaseNo*</u>, contractTerm, contractPrice)

Employee(<u>empID</u>, empName, position)
</p>
<p>This is some <u>mispeled</u> text.</p>

<span style="text-decoration: underline">underlined text</span>
