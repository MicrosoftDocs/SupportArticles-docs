---
title: Dynamics SQL Database has not been setup for this version error when starting Microsoft Dynamics GP
description: Describes a problem that occurs because the values in the tables in the DYNAMICS database do not correspond to the version or because the Client installation was installed instead of the Server installation. Provides steps to resolve the problem.
ms.reviewer: kyouells
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Dynamics SQL Database has not been setup for this version" error when you start Microsoft Dynamics GP

This article provides resolutions to solve the **Dynamics SQL Database has not been setup for this version** error message that may occur when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850662

## Symptoms

When you start Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains, you may receive the following error message:

> Dynamics SQL Database has not been setup for this version.

## Cause 1

This problem occurs because the values in the tables in the DYNAMICS database do not correspond to the version of Microsoft Dynamics GP or of Microsoft Business Solutions - Great Plains that you are using. See resolution 1.

## Cause 2

This problem occurs because the Client installation of Microsoft Dynamics GP was installed instead of the Server installation. You must install the Server installation before you can update the databases in Utilities. See resolution 2.

## Cause 3

This problem occurs because the ODBC connection that was selected at the login screen does not point to the instance of Microsoft SQL Server where the Microsoft Dynamics GP databases are located. See resolution 3.

## Resolution 1

1. Make sure that you have a good backup of the DYNAMICS database.
2. Use Query Analyzer or SQL Management Studio to run the following script against the DYNAMICS database.

    ```sql
    SELECT * FROM DYNAMICS..DU000020
    SELECT * FROM DYNAMICS..DB_Upgrade
    ```

    Notes

    - In the results for the DU000020 table, verify that the values in the following columns correspond to the version of Microsoft Dynamics GP or of Microsoft Great Plains that you are using:

      - The **versionMajor** column
      - The **versionMinor** column

      For example, if you are using Microsoft Dynamics GP 9.0, you should see the following values:

      - The **versionMajor** column: **9**
      - The **versionMinor** column: **0**
    - In the DB_Upgrade table results, verify that the values in the following columns correspond to the version of Microsoft Dynamics GP or of Microsoft Great Plains that you are using:

      - The **db_verMajor** column
      - The **db_verMinor** column
      - The **db_verOldMajor** column
      - The **db_verOldMinor** column

      For example, if you are using Microsoft Dynamics GP 9.0, you should see the following values:

      - The **db_verMajor** column: **9**
      - The **db_verMinor** column: **0**
      - The **db_verOldMajor** column: **9**
      - The **db_verOldMinor** column: **0**

3. If the values in the columns that are listed in step 2 do not correspond to the version of Microsoft Dynamics GP that you are using, run the following scripts in Query Analyzer or in SQL Server Management Studio.

### Script 1

```sql
update DYNAMICS..DU000020 
set versionMajor = VERSIONMAJOR, versionMinor = VERSIONMINOR
where companyID = COMPANYID
```

> [!NOTE]
>
> - Replace the `VERSIONMAJOR` placeholder and the `VERSIONMINOR` placeholder with the numbers of the version that you are currently using. For example, if you are using Microsoft Dynamics GP 9.0, the `VERSIONMAJOR` placeholder should be 9 and the `VERSIONMINOR` placeholder should be 0.
> - Replace the `COMPANYID` placeholder with the company ID of the company that has the incorrect version information. To determine the company ID, run the following statement:  
> `SELECT * FROM DYNAMICS..SY01500`

### Script 2

```sql
update DYNAMICS..DB_Upgrade 
set db_verMajor = VERSIONMAJOR, db_verMinor = VERSIONMINOR
where db_name = DATABASENAME
```

> [!NOTE]
>
> - Replace the `VERSIONMAJOR` placeholder and the `VERSIONMINOR` placeholder with the numbers of the version that you are currently using. For example, if you are using Microsoft Dynamics GP 9.0, the `VERSIONMAJOR` placeholder should be 9 and the `VERSIONMINOR` placeholder should be 0.
> - Replace the `DATABASENAME` placeholder with the name of the database for the company.

## Resolution 2

### Microsoft Dynamics GP

If you are using Microsoft Dynamics GP, remove the Client installation and reinstall the Server installation. To do this, follow these steps:

1. Select **Start**, select **Control Panel**, and then select **Add or Remove Programs**.
2. On the list, select **Microsoft Dynamics GP**, and then select **Change**.
3. Select **Remove** to remove the Client installation of Microsoft Dynamics GP.
4. When you reinstall Microsoft Dynamics GP, select **Server** in the Installation Type window, and then select **Next**.
5. Finish the installation.

### Microsoft Business Solutions - Great Plains

If you are using Microsoft Business Solutions - Great Plains, convert the Client installation to a Server installation. To do this, follow these steps:

1. Start the installation by using CD 1 of the Microsoft Business Solutions - Great Plains installation CD set. To do this, double-click the CDSetup.exe file.
2. Select **Install Great Plains**, and then accept the same default settings that you used for the Client installation except for the following settings:
   1. At the **Select to Install Server or Client** window, select **Server and Client Installation**.
   2. At the **Select Great Plains Components** window, select **SQL Server Objects**.
3. Finish the installation.

## Resolution 3

At the login screen, select the correct ODBC connection in the **Server** drop-down list. Follow the steps in the following article to verify that the ODBC connection has been set up correctly and that the connection references the correct instance of SQL Server that contains your Microsoft Dynamics GP databases:

[How to set up an ODBC Data Source on SQL Server for Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-set-up-an-odbc-data-source-on-sql-server-for-microsoft-dynamics-gp-06f8c9e7-7493-1b91-d764-318910ebb9e5)
