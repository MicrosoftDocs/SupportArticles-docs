---
title: Stop Audit Trail triggers in the test company from updating the live audit database using Audit Trails in Microsoft Dynamics GP
description: How to stop the Audit Trail triggers in the test company from updating the live audit database in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/31/2021
---
# How to stop Audit Trail triggers in the test company from updating the live audit database using Audit Trails in Microsoft Dynamics GP

This article provides information about how to stop Audit Trail triggers in the test company from updating the live audit database using Audit Trails in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2847491

## Symptoms

When you copy a live database with Audit Trails over to a test company, all the audits on the tables are also copied over. These are just triggers on the tables and still point to the live audit database. Therefore, when you key data in the test company, these changes are still recorded to the live audit database. Furthermore, if you stop the audits in the test company, it will actually delete the corresponding audit trigger in the live database. The audit still *appears* as active in the live company, but the user wouldn't know that the trigger is actually missing and therefore, not updating the live audit database with any changes.

## Cause

Product design: Audit Trails is just triggers on the tables that get copied over and so still point to the same audit database.

## Resolution

Use the following steps to remove the Audit Trail triggers from the test company, so that any changes in the test company do not affect the live company or the audit database for the live company. These steps would need to be done each time after copying a live database with Audit Trails over to a test company.

Restore the backup to the test company. Follow the steps in [KB871973](https://support.microsoft.com/topic/kb-set-up-a-test-company-that-has-a-copy-of-live-company-data-for-microsoft-dynamics-gp-by-using-microsoft-sql-server-6199295b-fc49-d963-3865-2d24a4b49211), including running the company ID script. Once completed with the steps in that KB, then follow the steps below to remove the Audit Trail triggers from the test company:

1. Make a "current" backup of the live company database, if you don't have one already.

2. Open SQL Server Management Studio. Click on the **New Query** button at the top to open a query window and select the "TEST" company database in the drop-down list. (The name of your TEST company database will most likely be different, so select the appropriate company ID for your test company. However, I will refer to my test company database as TEST as the ID going forward in this article.)

3. Copy in this script and run it against your "TEST" company database to remove all the Audit Trail triggers in this database. (So be sure you only run it against the "TEST" company.)

    ```sql
    SET QUOTED_IDENTIFIER ON 
    GO
    SET ANSI_NULLS ON 
    GO
    /*Delete earlier version of RemoveAuditTrails*/
    if exists (select * from sysobjects where name = 'RemoveAuditTrails' and type = 'P')
    drop proc RemoveAuditTrails
    GO
    /*Start procedure RemoveAuditTrails*/
    create procedure RemoveAuditTrails
    as 
    /*This procedure will remove the entire Audit Trails product from the database*/
    begin 
     declare @name char(500),
     @xtype char(2),
     @CmpID smallint
     declare MXSYS cursor for
     select name,xtype 
     from sysobjects where
     name like ('ep_Audit%')
     order by name 
     open MXSYS 
     fetch next from MXSYS into @name,@xtype
     while @@fetch_status = 0
     begin
     if @xtype = 'TR' /*trigger*/
     exec('drop trigger '+@name ) 
     fetch next from MXSYS into @name,@xtype
     end 
     close MXSYS 
     deallocate MXSYS
    
    end
    GO
    /*Execute the Stored Proc*/
    execute RemoveAuditTrails
    GO
    /*Drop the Stored Proc*/
    drop proc RemoveAuditTrails
    GO
    SET QUOTED_IDENTIFIER OFF 
    GO
    SET ANSI_NULLS ON 
    GO
    ```

4. If you would like to remove the audits completely from the **Audit Trail Maintenance** window in the test company, you can also run this script against the test company:

    ```sql
    DELETE TEST..MXLS0011 
    
    --Update the TEST placeholder above with the correct company ID for your test company.
    ```

5. In addition, if you would like to disable the test company from being linked to the live audit database, so users are not able to restart the existing audits or create new audits in the text company, run this script against the test company:

    ```sql
    DELETE TEST..MXLS4000
    
    --Update the TEST Placeholder above with the correct company ID for your test company.
    ```

As a result, if the user tries to apply an audit, or create a new audit in the test company, they will get a message that "No Audit Database has been set" and they will not be able to apply the audit.

## More information

If you would like to use/test Audit Trails in the test company, you should still complete all the steps above. Then you should be able to activate Audit Trails in the test company again, and define a new audit database for it to use.
