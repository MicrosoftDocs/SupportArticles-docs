---
title: Data mart integration error Index was out of range
description: Describes an error message that occurs in the Management Reporter 2012 data mart integration with Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, aeric, jopankow
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Management Reporter
---
# Management Reporter 2012 Data mart integration error "Index was out of range"

This article provides a resolution for the issue **Index was out of range** error that occurs when you use Management Reporter 2012 data mart integration with Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3029952

## Symptoms

The following error message may appear in the Management Reporter Dynamics GP Data Mart integration, for the Dimension Value task:

> DimensionValueProvider to Dimension Value: Error Text: Index was out of range. Must be non-negative and less than the size of the collection.

Additionally, the event viewer on the server hosting the Management Reporter services will display the following error details in the Windows Application logs.

> Index was out of range. Must be non-negative and less than the size of the collection.  
Parameter name: index  
--- Exception Dump ---  
Caught Exception: [System.ArgumentOutOfRangeException] Index was out of range. Must be non-negative and less than the size of the collection.  
Parameter name: index
>
> Stack trace:  
 at Microsoft.Dynamics.Performance.Integration.Reporting.Adapter.GP.DimensionValueProvider.CreateGLDimensionValueFromReader(SqlDataReader reader, Company cmp)  
 at Microsoft.Dynamics.Performance.Integration.Reporting.Adapter.GP.DimensionValueProvider.\<ReadObjects>d__0.MoveNext()  
 at Microsoft.Dynamics.Integration.Service.Tasks.MapWork.ProcessRecordsImplementation(OperationType operationType)

This error message can also occur when you attempt to open a building block or generate a report.

## Cause

This error can occur if there are references to accounts in the account segment table (GL40200) of the Microsoft Dynamics GP application database that are not present in the Account setup table (SY00300) or the Account index table (GL00100).

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Run the following query in SQL Management Studio against the Microsoft Dynamics GP company database to identify the invalid account segments:

    ```sql
    select * from GL40200 where SGMTNUMB not in (select SGMTNUMB from SY00300)
    select * from GL40200 where SGMTNUMB=1 and SGMNTID not in (select distinct ACTNUMBR_1 from GL00100)
    select * from GL40200 where SGMTNUMB=2 and SGMNTID not in (select distinct ACTNUMBR_2 from GL00100)
    select * from GL40200 where SGMTNUMB=3 and SGMNTID not in (select distinct ACTNUMBR_3 from GL00100)
    select * from GL40200 where SGMTNUMB=4 and SGMNTID not in (select distinct ACTNUMBR_4 from GL00100)
    ```

    Depending on the number of segments, you may need to adjust the statement.

2. Run the following statements in SQL to delete the bad records from the GL40200 table:

    ```sql
    delete GL40200 where SGMTNUMB not in (select SGMTNUMB from SY00300)
    delete GL40200 where SGMTNUMB=1 and SGMNTID not in (select distinct ACTNUMBR_1 from GL00100)
    delete GL40200 where SGMTNUMB=2 and SGMNTID not in (select distinct ACTNUMBR_2 from GL00100)
    delete GL40200 where SGMTNUMB=3 and SGMNTID not in (select distinct ACTNUMBR_3 from GL00100)
    delete GL40200 where SGMTNUMB=4 and SGMNTID not in (select distinct ACTNUMBR_4 from GL00100)
    ```

3. After removing the records from the GL40200 table, run Check Links on the account master in Microsoft Dynamics GP:

    1. Select **Dynamics GP**, then select **Maintenance** and then select **Check Links**.
    2. Select **Financial** series. Select **Account Master**, select **Insert** and then select **OK**.

4. Reconfigure the Management Reporter Data Mart integration to a new data mart database after correcting the account segments.

    > [!NOTE]
    > All steps must be completed by a domain user assigned to the Administrator role in Management Reporter Security who is also a member of the local Administrators group on the server

    1. Open the Management Reporter Configuration Console.
    2. Select the GP integration under **ERP integrations**.
    3. Select **Disable Integration**.
    4. Select **Remove** in the upper-right corner to remove the integration.
    5. Exit the Configuration Console.
    6. Open SQL Server Management Studio.
    7. Back up the Management Reporter database.
    8. Back up the data mart (usually DDM or ManagementReporterDM) database.
    9. Delete the data mart database.
    10. Open the Configuration Console.
    11. Stop the Management Reporter 2012 Process Service.
    12. Stop the Management Reporter 2012 Application Service.
    13. Start the Management Reporter 2012 Application Service.
    14. Start the Management Reporter 2012 Process Service.
    15. Select **File** and then select **Configure**.
    16. Select **Add Microsoft Dynamics GP Data Mart**.
    17. Follow the steps for the Microsoft Dynamics GP provider at:

        [Management Reporter 2012 for Microsoft Dynamics ERP: Installation, Migration, and Configuration Guides](https://www.microsoft.com/download/details.aspx?id=5916)

   18. When you have finished, select **Enable Integration** in the Configuration Console.
