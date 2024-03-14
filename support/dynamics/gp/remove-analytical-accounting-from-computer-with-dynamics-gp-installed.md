---
title: Remove Analytical Accounting from a computer that has Dynamics GP installed
description: Describes how to completely remove Analytical Accounting from a computer that has Microsoft Dynamics GP installed.
ms.topic: how-to
ms.reviewer: theley, ryanklev
ms.date: 03/13/2024
ms.custom: sap:Financial - Analytical Accounting
---
# How to remove Analytical Accounting from a computer that has Microsoft Dynamics GP installed

This article describes how to completely remove (uninstall) Analytical Accounting from a computer that has Microsoft Dynamics GP installed.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 915903

> [!NOTE]
> The steps below will remove Analytical Accounting from all companies, so you cannot use these steps if you are using AA in any of your companies (that use the same Dynamics database).

## How to completely remove Analytical Accounting

To completely remove Analytical Accounting, follow the appropriate steps for the version of Microsoft Dynamics GP that you are using:

> [!NOTE]
>
> - Historical AA tables were added in GP 10.0 so the scripts work for GP 10.0 and later versions.
> - Make sure to perform all 13 steps listed below. The last step is often missed.
> - If you wish to continue to use Analytical Accounting in one or more of your companies, then do not use the steps below. These steps will remove AA from *all* of the companies.

## Microsoft Dynamics GP 10.0 and higher versions

1. Make a full backup of the Microsoft Dynamics GP databases. Make sure that this backup does not overwrite an existing backup.
2. Click **Start**, click **Run**, type appwiz.cpl, and then click **OK**.
3. In the left pane, click **Change or Remove Programs**.
4. Click on the **Microsoft Dynamics GP** version listed that you have installed and then click **Change**.
5. Click **Add/Remove Features**.
6. In the Select Features window, click **Do not install feature** in the **Analytical Accounting** list.
7. Click **Next**, and then click **Install**.
8. In the Installation Complete window, click **Finish**.
9. Close the **Add Or Remove Programs** window.
10. Remove all AA SQL objects from the DYNAMICS database by [downloading the KB915903_AA_Remove_AACompete_DYNAMICS_10.sql script](https://mbs2.microsoft.com/fileexchange/?fileid=f642f40c-fdc2-4d9d-8d48-26c5583f0c6e) and execute it against the Dynamics database:

11. Remove all AA SQL objects from COMPANY databases by [downloading the KB915903_10.sql script](https://mbs2.microsoft.com/fileexchange/?fileid=2dd9a8ed-cf8d-449c-b20b-23f012ec532d) and execute it against EACH company database.

12. Execute the scripts that you downloaded in steps 10 and 11.
    1. Click **Start**, point to **Programs**, point to **Microsoft SQL Server** version you have installed, and then click **SQL Server Management Studio**.
    2. Log on by using the sa password.
    3. On the **File** menu, click **Open**, and then click **File**.
    4. Locate and then click the KB915903_10.sql script file, click the "company" database in the list, and then press F5 to run the script.  

        > [!NOTE]
        >  The KB915903_10.sql script must be run against each and all Microsoft Dynamics GP company databases.
    5. Locate and then click the KB915903_AA_Remove_AAComplete_DYNAMICS_10.sql script file, and then run the script against the "DYNAMICS" database. To do this, click **DYNAMICS** in the database list, and then press F5.

13. Remove the Product ID for AA from the system tables. To do this, run the following statements against the DYNAMICS database in SQL Server Management Studio:

    ```sql
    Delete DB_Upgrade where PRODID='3180' Delete DU000020 where PRODID='3180'
    ```

    > [!NOTE]
    > "PRODID of '3180'" represents the Analytical Accounting module.
