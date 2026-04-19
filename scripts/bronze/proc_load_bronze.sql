CREATE OR ALTER PROCEDURE bronze.load_bronze_layer
AS
BEGIN
USE DataWarehouse
GO

DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start DATETIME;

BEGIN TRY

    SET @batch_start = GETDATE();
    PRINT '========================================';
    PRINT 'Loading Bronze Layer Started: ' + CONVERT(NVARCHAR, @batch_start, 120);
    PRINT '========================================';

    -- ========================
    -- CRM: cust_info
    -- ========================
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.crm_cust_info;
    BULK INSERT bronze.crm_cust_info
    FROM 'cust_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> bronze.crm_cust_info loaded successfully. Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- ========================
    -- CRM: prd_info
    -- ========================
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.crm_prd_info;
    BULK INSERT bronze.crm_prd_info
    FROM 'prd_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> bronze.crm_prd_info loaded successfully. Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- ========================
    -- CRM: sales_details
    -- ========================
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.crm_sales_details;
    BULK INSERT bronze.crm_sales_details
    FROM 'sales_details.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> bronze.crm_sales_details loaded successfully. Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- ========================
    -- ERP: cust_az12
    -- ========================
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_cust_az12;
    BULK INSERT bronze.erp_cust_az12
    FROM 'CUST_AZ12.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> bronze.erp_cust_az12 loaded successfully. Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- ========================
    -- ERP: loc_a101
    -- ========================
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_loc_a101;
    BULK INSERT bronze.erp_loc_a101
    FROM 'loc_a101.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> bronze.erp_loc_a101 loaded successfully. Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- ========================
    -- ERP: px_cat_g1v2
    -- ========================
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM 'px_cat_g1v2.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> bronze.erp_px_cat_g1v2 loaded successfully. Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- ========================
    -- Total batch duration
    -- ========================
    PRINT '========================================';
    PRINT 'Bronze Layer Load Completed Successfully!';
    PRINT 'Total Duration: ' + CAST(DATEDIFF(SECOND, @batch_start, GETDATE()) AS NVARCHAR) + ' seconds';
    PRINT '========================================';

END TRY
BEGIN CATCH
    PRINT '========================================';
    PRINT 'ERROR IN LOADING BRONZE LAYER';
    PRINT 'Error Message : ' + ERROR_MESSAGE();
    PRINT 'Error Number  : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
    PRINT 'Error Line    : ' + CAST(ERROR_LINE() AS NVARCHAR);
    PRINT '========================================';
END CATCH
