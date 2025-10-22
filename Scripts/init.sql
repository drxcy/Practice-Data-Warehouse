/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'WAREHOUSE_PRACTICE' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'WAREHOUSE_PRACTICE' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/
	Use master ;
GO
--Drop and recreate Database 'WAREHOUSE_PRACTICE'

	If EXISTS (SELECT 1 FROM sys.databases WHERE name ='WAREHOUSE_PRACTICE')
	Begin 
	ALTER DATABASE WAREHOUSE_PRACTICE SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE WAREHOUSE_PRACTICE;
	END
GO

	CREATE DATABASE WAREHOUSE_PRACTICE;
GO

	USE WAREHOUSE_PRACTICE;
GO

/*Create Schema */
	CREATE SCHEMA bronze;
GO
	CREATE SCHEMA silver;
GO
	CREATE SCHEMA gold;
