
# Northwind Sales Insights with dbt

## Project Overview

This project builds a data transformation pipeline using dbt for Northwind Trading, a company that distributes food and beverage products worldwide.

The goal is to transform raw operational data into clean, structured, and business-ready tables that can be used for reporting and analytics.

---

## Business Problems Solved

The raw Northwind data had several challenges:

- Raw tables were not standardized, making analysis difficult.
- Analysts had to write complex SQL joins repeatedly to combine sales data.
- Different analysts could calculate revenue differently, leading to inconsistent business metrics.

This dbt project solves these problems by creating a structured data pipeline with clear transformation layers:

- Cleaning and standardizing raw data.
- Centralizing business logic such as revenue calculation.
- Providing ready-to-use analytical tables for dashboards and reporting.

---

## dbt Models Built

### 1. Staging Layer

The staging models clean and standardize the raw Northwind tables.

Models created:

- `staging_orders`
  - Cleans order data.
  - Standardizes column names and data types.

- `staging_order_details`
  - Cleans product order information.
  - Standardizes price, quantity, and discount fields.

- `staging_products`
  - Provides clean product information.

- `staging_categories`
  - Provides clean category information.

---

### 2. Prep Layer

Model created:

- `prep_sales`

Purpose:

- Combines orders, order details, products, and categories.
- Creates a single sales dataset.
- Calculates important business metrics:
  - Revenue
  - Order year
  - Order month

This layer contains the main business logic used for analysis.

---

### 3. Mart Layer

Model created:

- `mart_sales_performance`

Purpose:

Creates an aggregated table for business reporting.

It provides:

- Total revenue
- Total number of orders
- Average revenue per order

The data is aggregated by:

- Year
- Month
- Product category

This table can be directly used by BI tools for dashboards and KPI reporting.

---

## Data Quality

Basic data validation was added using dbt tests.

Tests include:

- Not null checks for important fields.
- Validation of key metrics in the final mart model.

The tests ensure that the analytical tables contain reliable data.

---

## Main Learning

This project helped demonstrate how dbt can be used to build a modern analytics workflow by separating:

- Data cleaning (Staging)
- Business transformations (Prep)
- Reporting tables (Mart)

It also showed the importance of reusable models, testing, and maintaining consistent business logic.