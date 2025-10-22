/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

EXEC bronze.load_bronze;
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
	BEGIN 
		DECLARE @start_time DATETIME, @end_time DATETIME , @batch_start_time DATETIME, @batch_end_time DATETIME;
		BEGIN TRY
			SET @batch_start_time =GETDATE();
			Print '===================================';
			Print 'Loading Bronze Layer';
			Print '===================================';

			Print '===================================';
			Print 'Loading datesets crm';
			Print '===================================';

			SET @start_time = GETDATE();
			Print '>> Truncating Table : bronze.transaksi';
			TRUNCATE TABLE bronze.transaksi;
			Print '>> Inserting Data Into :bronze.transaksi'
			BULK INSERT bronze.transaksi
			FROM 'C:\Users\HP\Downloads\datasets\transaksi.csv'
			 WITH (
			FIRSTROW =2,
			  FIELDTERMINATOR=',',
			 ROWTERMINATOR = '\n',
			TABLOCK
			) 
			SET @end_time =GETDATE();
			Print '>> Loading Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time)AS VARCHAR ) + 'seconds'
			Print '>> -------------------------------------------- <<';
			SET @batch_end_time =GETDATE();
			Print '>> --------------------------------------------- <<';
			Print 'Bronze Layer Loading is Completed';
			Print 'Total Loading Duration : ' + CAST(DATEDIFF(SECOND ,@batch_start_time,@batch_end_time) AS VARCHAR ) + 'seconds';
			Print '>> --------------------------------------------- <<';
			END TRY 
			BEGIN CATCH 
			Print '============================================';
			Print'ERROR OCCURED DURING LOADING BRONZE LAYER';
			Print'ERROR MESSAGE ' +  CAST (ERROR_NUMBER() AS NVARCHAR);
			Print'ERROR MESSAGE ' + ERROR_MESSAGE();
			Print'ERROR MESSAGE ' +  CAST (ERROR_STATE() AS NVARCHAR);
			Print '============================================';
			END CATCH
		END
	
