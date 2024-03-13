---
title: Problems occur when you reconcile inventory accounts to general ledger accounts in Microsoft Dynamics GP
description: Describes a problem that occurs when you reconcile inventory accounts to general ledger accounts in Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Problems occur when you reconcile inventory accounts to general ledger accounts in Microsoft Dynamics GP

This article describes an issue that occurs when you reconcile inventory accounts to general ledger accounts in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855409

## Symptoms

If you change the segment ID for a site in Inventory Control Maintenance in Microsoft Dynamics GP, problems occur when you reconcile inventory accounts to general ledger accounts. Problems also occur if you print reports that are sorted by a site's segment name or segment ID.

## Cause

This problem occurs because the general ledger accounts that you posted to old site segments don't match the relevant accounts in Inventory Control Maintenance for the new site segment.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To resolve this problem, change the segment ID for sites in Inventory Control Maintenance in Microsoft Dynamics GP by following these steps:

1. Delete all sites from the Item Site Setup (IV40700) table by following these steps:

    1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio by using one of the following methods depending on the program that you're using.

        **Method 1: For SQL Server Desktop Engine**

        If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, click **Start**, point to **All Programs** >
         **Microsoft Administrator Console**, and then click **Support Administrator Console**.

        **Method 2: For SQL Server 2000**

        If you're using SQL Server 2000, start SQL Query Analyzer. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server**, and then click **Query Analyzer**.

        **Method 3: For SQL Server 2005**

        If you're using SQL Server 2005, start SQL Server Management Studio. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.  

        **Method 4: For SQL Server 2008**

        If you're using SQL Server 2008, start SQL Server Management Studio. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.

    2. Run the following statement to move your site information from the Item Site Setup (IV40700) table into a temporary table that is named SITES.

        ```SQL
        select * into SITES from IV40700
        ```

    3. Run the following statement, and then verify that the information exists in the SITES table:

        ```SQL
        Select * from SITES
        ```

    4. Run the following statement against your company database to delete the contents of the IV40700 table:

        ```SQL
        delete IV40700
        ```

2. Change the segment IDs for sites in the Inventory Control Setup window by following the appropriate step:

    - In Microsoft Business Solutions - Great Plains 8.0:

       1. On the **Tools** menu, point to **Setup** > **Inventory**, and then click **Inventory Control**.
       2. In the Inventory Control Setup window, change the segment number in the **Segment ID for Sites** field, and then click **Save**.

    - In Microsoft Dynamics GP 9.0:

       1. On the **Tools** menu, point to **Setup** > **Inventory**, and then click **Inventory Control**.
       2. In the Inventory Control Setup window, change the segment number in the **Segment ID for Sites** field, and then click **Save**.

    - In Microsoft Dynamics GP 10.0:

        1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **Inventory**, and then click **Inventory Control**.
        2. In the Inventory Control Setup window, change the segment number in the **Segment ID for Sites** field, and then click **Save**.

    - In Microsoft Dynamics GP 2010:
        1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup**> **Inventory**, and then click **Inventory Control**.
        2. In the Inventory Control Setup window, change the segment number in the **Segment ID for Sites** field, and then click **Save**.

3. Run the following statement to insert the site information from the temporary SITES table into the IV40700 table:

    ```SQL
    insert into IV40700 (LOCNCODE,LOCNDSCR,NOTEINDX,ADDRESS1,ADDRESS2,ADDRESS3, 
    CITY,STATE,ZIPCODE,COUNTRY,PHONE1,PHONE2, 
    PHONE3,FAXNUMBR,Location_Segment,STAXSCHD,PCTAXSCH,INCLDDINPLNNNG,PORECEIPTBIN,PORETRNBIN,SOFULFILLMENTBIN,SORETURNBIN,
    BOMRCPTBIN,MATERIALISSUEBIN,MORECEIPTBIN,REPAIRISSUESBIN,
    WMSINT,PICKTICKETSITEOPT,BINBREAK,CCode,DECLID) select LOCNCODE,
    LOCNDSCR,NOTEINDX,ADDRESS1,ADDRESS2,ADDRESS3,CITY,STATE,
    ZIPCODE,COUNTRY,PHONE1,PHONE2,PHONE3,FAXNUMBR,Location_Segment,
    STAXSCHD,PCTAXSCH,INCLDDINPLNNNG,PORECEIPTBIN,PORETRNBIN,SOFULFILLMENTBIN,SORETURNBIN,BOMRCPTBIN,
    MATERIALISSUEBIN,MORECEIPTBIN,REPAIRISSUESBIN,WMSINT,PICKTICKETSITEOPT,BINBREAK,CCode, 
    DECLID from SITES 
    ```

4. Update the account segment number for the sites by following these steps:

    1. On the **Cards** menu, point to **Inventory**, and then click **Site**.
    2. In the Site Maintenance window, select a site in the **Site ID** field.
    3. Under **Account Segment ID**, update the account segment number in the **Segment 1** field for the site.
    4. Repeat steps 4b and 4c to update the account segment number for all sites that you want to update.

> [!NOTE]
> This change does not update transactions in the Sales Order Processing module, in the Inventory module, or in the Invoicing module.
