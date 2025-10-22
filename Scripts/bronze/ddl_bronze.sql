/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/
IF OBJECT_ID('bronze.transaksi','U') IS NOT NULL
	DROP TABLE bronze.transaksi

GO
CREATE TABLE bronze.transaksi(
transaction_id NVARCHAR(50),
account_no NVARCHAR(50),
tgl_transaksi DATE,
amount DECIMAL(18,2),
channel NVARCHAR(50),
branch_code NVARCHAR(50),
)
