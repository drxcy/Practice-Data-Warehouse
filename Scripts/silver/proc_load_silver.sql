/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC silver.load_silver;
===============================================================================
*/
EXEC silver.load_silver
CREATE OR ALTER PROCEDURE silver.load_silver AS 
BEGIN 
DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME
BEGIN TRY 
			SET @batch_start_time =GETDATE();
			Print '================================================';
			Print 'Loading Silver Layer';
			Print '================================================';
		
			Print '================================================';
			Print 'Loading trasaksi Tables';
			Print '================================================';
            -- Loading silver.transaksi
            SET @start_time =GETDATE();
            Print '>> Trucating Tables :silver.transaksi';
            TRUNCATE TABLE silver.transaksi ;
            Print '>> Inserting Tables : silver.transaksi';

INSERT INTO silver.transaksi
(
    transaction_id ,
    account_no ,
    tgl_transaksi,
    amount ,
    channel ,
    branch_code 
)

    SELECT transaction_id ,
    account_no ,
     FORMAT(CAST(tgl_transaksi AS DATE),'yyyy-MM-dd') AS tgl_transaksi,
    round(amount ,2) AS amount ,
    CASE WHEN UPPER(TRIM(channel)) = 'EDC'
        THEN 'Electronic Data Capture'
        ELSE UPPER(TRIM(channel))
      END AS channel,
    branch_code
    FROM (
        SELECT *, ROW_NUMBER() OVER (PARTITION by transaction_id order by tgl_transaksi) as flag_last
        FROM
            bronze.transaksi
            WHERE transaction_id IS NOT NULL )t 
        WHERE flag_last =1
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
    
 
 




