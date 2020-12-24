<h1><p align="center">Creating a Sample Data Set to Test the Relational Database with SQL Queries</p></h1>

The database must be thoroughly tested with business-related SQL queries before delivering the final product to the client. Therefore, realistic sample data has been created for this purpose as real-world data is not available. 

All realistic sample data has been generated at [Mockaroo](https://www.mockaroo.com/). Example below:

<p align="center"><img src="https://github.com/j-b-ferguson/relational-database-design-and-test/blob/main/SQL%20code/Sample%20Data%20Generation%20Example.PNG" width=80% height=80%></p>

Some attributes required simple random sampling to mimic the randomness of real-world data. For example, not all customers buy phone contracts. Therefore, simple random sampling has been performed to mimic random contract purchases from available purchase numbers shown in the Purchase table below. This process was carried out by using the `RAND()` and `SORT()` functions available in Microsoft Excel.

<p align="center"><img src="https://github.com/j-b-ferguson/relational-database-design-and-test/blob/main/SQL%20code/Simple%20Random%20Sampling.png" width=80% height=80%></p>

