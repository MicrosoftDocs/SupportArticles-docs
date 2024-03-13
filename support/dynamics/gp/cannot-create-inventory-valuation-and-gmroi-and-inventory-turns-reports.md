---
title: How to create Inventory Valuation and GMROI and Inventory Turns reports
description: Inserts historical data into the new fields that were added as part of Microsoft Dynamics RMS 2.0 Feature Pack 1. This enables users to generate Inventory Valuation and GMROI and Inventory Turns reports for dates before Microsoft Dynamics RMS 2.0 Feature Pack 1 is installed.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Cannot create "Inventory Valuation" and "GMROI and Inventory Turns" reports for dates before applying Dynamics RMS 2.0 Feature Pack 1

This article provides a resolution to make sure the **Inventory Valuation** and **GMROI and Inventory Turns** reports for dates can be created successfully before Microsoft Dynamics RMS 2.0 Feature Pack 1 is installed.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2451854

## Symptoms

You are not able to generate **Inventory Valuation** and **GMROI and Inventory Turns** reports for dates before Microsoft Dynamics RMS 2.0 Feature Pack 1 is installed.

## Cause

When you apply Microsoft Dynamics RMS 2.0 Feature Pack 1 (FP1), new tables and fields are added to the Store Operations and Headquarters databases that store the necessary data that is used to generate the new Inventory Valuation and GMROI and Inventory Turns reports. When you apply FP1, it does not retroactively insert data into these tables and fields for historical inventory data.

## Resolution

1. Back up the Store Operations database.
2. On the **File** menu in Store Operations Administrator, select **Configuration**, and then, on the **Database** tab, note the database server name, the SQL Server instance name (if there is one), and the database name. You will need this information to complete this fix.

3. Close Store Operations Administrator and discontinue activity in all Microsoft Dynamics RMS applications.
4. Select the Fix this problem button or link.

    > [!NOTE]
    > if you are not on the database server, save the Fix it solution to a flash drive or a CD and then run it on the database server.

5. In the **File Download** dialog box, select **Run**.
6. Read the Microsoft Software Licensing Terms, select **I Agree** if you accept the license terms, and then select **Next**.
7. In the **RMS Store Operations SQL Server** box, type the server name and, if you have a named instance, the SQL Server instance name.

    > [!NOTE]
    > Type this exactly as it appears in the **Store Operations Administrator Configuration** dialog box as noted in step 2.

8. In the **RMS Store Operations SQL Server Database Name** box, type the name of the Store Operations database.

    > [!NOTE]
    > Type this exactly as it appears in the **Store Operations Administrator Configuration** dialog box as noted in step 2.

9. In the **RMS Store Operations SQL Server sa password** box, type the SQL Server sa password.

    > [!NOTE]
    > If you do not know your **SQL Server sa password**, consult your Microsoft Dynamics RMS partner.

10. Select **Next**.

    The Fix it begins processing data. When it is finished, the Microsoft Fix it 50537 dialog box appears and displays the following message:

    > This Microsoft Fix it has been processed

    In this dialog box, you also have the opportunity to tell Microsoft what you think of the Fix it, get online help, and read more about Microsoft Fix it.

11. Select **Close**.

> [!NOTE]
>
> - Deployments of Microsoft Dynamics RMS can include customizations and interaction with third-party products, so the accuracy of the results of this Fix it may vary. Although this Fix it has been tested with sample databases, it is provided as is and is not supported by Microsoft.
> - When you use Microsoft Dynamics RMS Headquarters, run this Fix it only on the Store Operations databases. The changes will be uploaded to the Headquarters database with the next Style 401: Request Data Upload worksheet. Depending on the size of the database, number of years of data, and the number of stores in your enterprise, the worksheet may take several minutes to process. Therefore, you may want to run this Fix it one store at a time and at a time when the next Style 401: Request Data Upload worksheet will not process until after business hours.
> - This Fix it must be run locally on the computer where the Store Operations database resides. You can copy the automatic fix to a flash drive or CD to transfer it to the database computer.
> - If you receive an error message while running this Fix it, create a Technical Support incident with the Microsoft Dynamics Retail Support team by calling 888-477-7877.
