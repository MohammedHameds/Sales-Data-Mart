# Sales Data Mart
Adventure Works Data Warehouse project (Sales data mart) using SQL and SSIS 

## Overview
The AdventureWorks2014 Sales Data Mart Project is a powerful data solution built on SQL Server and SQL Server Integration Services (SSIS). It efficiently extracts, transforms, and loads data from SQL Server into a star schema-based data model.


## Data Sources

The AdventureWorks2014 Sales Data Mart Project relies on the AdventureWorks2014 dataset as its primary data source. This dataset provides comprehensive information related to sales, customers, products, and more.[ adventureworks2014](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms)

## Prerequisites
Before getting started with the proejct, ensure you have the following prerequisites installed:

- SQL Server
- SQL Server Integration Services (SSIS)


## Key Features
- **Data Pipeline:** Implemented SSIS for seamless data extraction and transformation.
- **Star Schema:** Designed a star schema for optimized querying and analytics.
- **Change Management:** Incorporated Slowly Changing Dimensions for data integrity.
- **ETL Processes:** Leveraged Derived Column for calculated fields and supported both Full Load and Incremental Load scenarios.



## Data Modeling (Star Schema)

The project employs a star schema for streamlined analytics:

1. Fact Sales: Centralizes key sales measures.

2. Dim Product: Manages product details.

3. Dim Customer: Comprehensive customer information.

4. Dim Time: Time-related data for analysis.

5. Dim Territory: Stores territory details.

This star schema optimizes data retrieval for efficient insights.

![star schema](Images/Star%20schema.jpg)

## ETL 
The ETL process orchestrates the movement and transformation of data for optimal integration into the star schema.


#### 1. Dimension Product
Dim Product design extract customer data from the source database (OLEDB). Apply some transformation (Lookup and get data from different tables and replace Nulls values).

Apply Slowly Changing Dimension (SCD) processing to handle orders changes.

![dim product img](/Images/Dim%20product.jpg)


#### 2. Dimension Customer
Dim customer design extract customer data from the source database (OLEDB). Apply some transformation (Lookup and get data from different tables and replace Nulls values).

Apply Slowly Changing Dimension (SCD) processing to handle customer phone changes.

![dim customer img](/Images/Dim%20customer.jpg)

#### 3. Dimension Date
Dim Date design extract customer data from the source database [Excel file](/SQL%20Queries/dim_date_01_populate_table.xls) . Apply data convesion to Month_name column to reduce its length.
![dim date img](/Images/Dim%20date.jpg)

#### 4. Dim Territory 
Dim territory design extract customer data from the source database (OLEDB).
![dim date img](/Images/Dim%20territory.jpg)

#### 5. Fact Sales 
Data can be loaded from the source to the destination in two ways:
- Full Load
- Incremental Load


1. #### Full Load Process 
![dim date img](/Images/Full%20load%201.jpg)

![dim date img](/Images/Full%20load%202.jpg)


2. #### Incremental Load Process 
![dim date img](/Images/Incremental%20load%201.jpg)

![dim date img](/Images/Incremental%20load%202.jpg)