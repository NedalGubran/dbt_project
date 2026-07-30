# Northwind Sales Insights with dbt

## Project Overview

This project builds a business-ready sales analytics pipeline using **dbt (Data Build Tool)**.

The goal of this project is to transform raw Northwind operational data into clean, reliable, and reusable analytical models that can support reporting and business analysis.

The project follows a modular dbt architecture with three main transformation layers:

- **Staging Layer**: Cleaning and standardizing raw source data.
- **Prep Layer**: Combining datasets and applying business logic.
- **Mart Layer**: Creating business-ready analytical models and KPIs.

---

# Business Challenge

Northwind stores sales data across multiple raw operational tables, including orders, order details, products, and categories.

The analytics workflow faced several challenges:

- Inconsistent column names and data types across raw tables.
- Analysts had to rewrite complex SQL joins for every report.
- Revenue calculations were not standardized across different reports.

## Project Goal

Build a modular dbt pipeline that transforms raw operational data into reliable analytical models with consistent business metrics.

---

# dbt Transformation Pipeline

The project follows this data transformation flow:

Raw Source Tables
      |
      ↓
  Staging Layer
      |
      ↓
  Prep Layer
      |
      ↓
  Mart Layer
      |
      ↓
Business Reporting


---

# Staging Layer

The Staging Layer is the first step in the dbt transformation process.

Its purpose is to clean and standardize raw source tables before applying business transformations.

## Transformations Performed

- Loaded raw tables using dbt `source()`.
- Standardized column names across models.
- Applied appropriate data types for analysis.
- Selected only required columns.
- Prepared clean datasets for downstream transformations and joins.

## Staging Models

### stg_orders

The orders data was prepared by:

- Selecting required order information.
- Standardizing order fields.
- Converting date columns into the correct data type.
- Preparing order data for sales analysis.

### stg_order_details

The order details data was prepared by:

- Keeping important sales fields:
  - Product ID
  - Unit Price
  - Quantity
  - Discount

These fields were prepared for revenue calculation in the Prep layer.

### stg_products

The products data was prepared by selecting important business columns:

- Product ID
- Product Name
- Supplier ID
- Category ID
- Unit Price
- Units in Stock

### stg_categories

The category data was prepared by keeping:

- Category ID
- Category Name

---

# Prep Layer

The Prep Layer combines cleaned staging models using key relationships and applies business logic.

## Data Joins

### Orders and Order Details
Joined using:
- order_id

Purpose:
Combine order information with transaction details.

### Order Details and Products
Joined using:
- product_id

Purpose:
Add product information to each sales transaction.

### Products and Categories
Joined using:
- category_id

Purpose:
Add category information for sales analysis.
-----

## Business Logic

A standardized revenue calculation was created:

Revenue = Unit Price × Quantity × (1 − Discount)

This calculation standardizes revenue metrics across all reports and provides a consistent KPI for business analysis.

Additional time attributes were created:

- Order Year
- Order Month

to support monthly sales performance analysis.

---

# Mart Layer

The Mart Layer creates business-ready analytical models for reporting.

The final model created: mart_sales_performance


This model provides sales performance KPIs.

## Metrics Created

- Total Revenue
- Total Orders
- Average Revenue per Order
- Monthly Sales Performance
- Sales by Product Category

The final model aggregates data by:

- Order Year
- Order Month
- Product Category

This structure allows business users to analyze sales performance efficiently.

---

# Testing and Documentation

Data quality and documentation were implemented using dbt features.

## Data Tests

The models were validated using dbt tests.

Implemented tests include:

- Not-null tests on important fields.
- Validation of critical columns required for reporting.

Examples:

- order_year
- order_month
- category_name
- total_revenue

These tests help ensure reliable and consistent analytical outputs.

---

## Documentation

dbt documentation was generated to improve project transparency and maintainability.

Documentation includes:

- Model descriptions.
- Column information.
- Data types.
- Model dependencies.
- SQL code.
- Lineage graph.

---

# Tools Used

- SQL
- dbt
- GitHub

---

# Final Outcome

The final result is a clean, modular, and maintainable sales analytics pipeline.

The pipeline transforms raw Northwind data into reliable analytical models ready for reporting and business analysis.

This project demonstrates how dbt improves:

- Data organization.
- Data quality.
- Reusability.
- Analytics workflows.