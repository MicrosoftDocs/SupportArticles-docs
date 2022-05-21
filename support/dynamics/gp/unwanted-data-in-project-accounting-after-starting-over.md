---
title: Unwanted data in Project Accounting after starting over
description: You see unwanted data in Project Accounting after you start over in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# You see unwanted data in Project Accounting after you start over in Microsoft Dynamics GP

This article describes how to keep setup records and master records while removing transaction records.  

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 869556

## Symptoms

After you start over in Microsoft Dynamics Great Plains (GP), Project Accounting, you see unwanted data, such as old transaction records.  

## Resolution

To remove transaction records, and keep setup records and master records, follow these steps:

1. Close Microsoft Dynamics GP.
2. Make a backup of the company database.

3. In Microsoft SQL Management Studio, run delete statements on all PA tables in the company database except `PA0*` tables (master records) and `PA4*` tables (setup tables).

   The following tables are not Project Accounting tables and should not be deleted:

    - Refund Checks tables

      PA00001  
      PA00002  
      PA00010  
      PA50100  
      PA50102  
      PA50103  
      PA50105

    - Lockbox tables

      paActvty  
      palbCash  
      palbdtl  
      palbInvc  
      palbmstr  
      palbrdty  
      palbsetp

4. If you want to remove the **Templates** in Project accounting, then run delete statements on the following tables:

     PA41301  
     PA41304  
     PA41401  
     PA41409

5. Make another backup of the database and then run PA Reconcile to clear the summary figures in the tables. To do this, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, select **Tools**, select **Utilities**, select **Project**, and then select **PA Reconcile**.
    2. Run **PA Reconcile** for all of the options listed on under Reconcile Totals by selecting the appropriate options.
    3. Select **OK**  

6. Run PA Reconcile Periodic to clear the periodic records in the PA01304, PA01221, PA01121, and PA00511 tables. To do this, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, select **Tools**, select **Utilities**, select **Project**, and then select **PA Reconcile Periodic**.
    2. Select to include all customers.
    3. Select **OK**  

7. Run PA Check Links to clear the files. To do this, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, select **Maintenance**, and then select **PA Check Links**.
    2. Select **All** to add all of the Logical Tables.
    3. Select **OK**
