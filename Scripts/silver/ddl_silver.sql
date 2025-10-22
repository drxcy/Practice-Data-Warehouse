/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('silver.transaksi','U') IS NOT NULL
	DROP TABLE silver.transaksi

GO
CREATE TABLE silver.transaksi(
transaction_id NVARCHAR(50),
account_no NVARCHAR(50),
tgl_transaksi DATE,
amount DECIMAL(18,2),
channel NVARCHAR(50),
branch_code NVARCHAR(50),
)
