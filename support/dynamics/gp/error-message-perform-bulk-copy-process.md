---
title: Error when you perform a Bulk Copy Process
description: This article describes how to troubleshoot common issues that you encounter when the database does not start and the Bulk Copy Process (BCP) does not start during the installation of Microsoft Dynamics GP.
ms.reviewer: kyouells
ms.topic: how-to
ms.date: 03/31/2021
---
# Error message when you perform a Bulk Copy Process (BCP) in Microsoft Dynamics GP or Microsoft Dynamics GP Utilities (An error occurred while using the BCP utility--data was not correctly copied to the server)

This article describes how to troubleshoot common issues that you encounter when the database does not start and the Bulk Copy Process (BCP) does not start during the installation of Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 869315

## Symptoms

When you perform a Bulk Copy Process (BCP) in Microsoft Dynamics GP or Microsoft Dynamics GP Utilities, you receive the error messages as follows:

- Error message 1

  > An error occurred while using the BCP utility--data was not correctly copied to the server. Please verify your ODBC settings and that BCP has been correctly installed.

- Error message 2

  > An error occurred while using the BCP utility--data was not correctly copied to the server.

- Error message 3

  > BCP.EXE does not exist at this workstation.

To troubleshoot the possible causes of this error, use the following checklist:

1. If the **User Account Control** (UAC) is turned on in Windows Vista, Windows 7 or Windows Server 2008, follow one of these options:

   - Option 1: Run Microsoft Dynamics GP Utilities as administrator.

     1. Click **Start**, click **Programs**, click **Microsoft Dynamics**, and then click **GP**.

     2. Right-click **GP Utilities**, and then click **Run As Administrator**.

   - Option 2: Temporarily turn off the **User Account Control (UAC)** feature in Windows Vista and Windows Server 2008.

     1. Click **Start**, and then click **Control Panel**.
     2. Follow one of these methods:

        - If you view **Control Panel** in **Category View**, follow these steps:

          1. Click **User Accounts** two times.
          2. Click **Turn User Access Control On or Off**.
          3. Click to clear the **Use User Account Access Control (UAC) to help protect your computer** check box, and then click **OK**.

        - If you view **Control Panel** in **Classic View**, follow these steps:

          1. Click **User Accounts**, and then click **Turn User Access Control On or Off**.
          2. Click to clear the **Use User Account Access Control (UAC) to help protect your computer** check box, and then click **OK**.

     3. Restart the computer when you are prompted.
     4. Turn back on the **User Account Control (UAC)** feature.

   - Option 3: Temporarily turn off the **User Account Control (UAC)** feature in Windows 7.

      1. Click **Start**, and then click **Control Panel**.
      2. Follow one of these methods:

         - If you view **Control Panel** in **Category View**, follow these steps:

          1. Click **User Accounts** two times.
          2. Click **Change User Account Control settings**.
          3. Slide the Notify bar down to the bottom or where **Never Notify** is located, and then click **OK**.

         - If you view **Control Panel** with **Small Icons** or **Large Icons**, follow these steps:

          1. Click **User Accounts**, and then click **Change User Account Control settings**.
          2. Slide the Notify bar down to the bottom or where **Never Notify** is located, and then click **OK**.

      3. Restart the computer when you are prompted.
      4. Turn back on the **User Account Control (UAC)** feature.

2. Determine whether you use the SQL Server Native Client 10.0 for the ODBC DSN. This ODBC driver currently does not work with Microsoft Dynamics GP 9.0 or with Microsoft Dynamics GP 10.0. However, you can set up a new ODBC DSN by using the SQL Native Client or the SQL Server driver.

   For more information, see [How to set up an ODBC Data Source on SQL Server for Microsoft Dynamics GP](https://support.microsoft.com/help/870416).

   > [!NOTE]
   > This issue is fixed in the Microsoft Dynamics GP 10.0 March hotfix 968118. To obtain the latest hotfix, visit the following Web site:

    - [PartnerSource](https://partner.microsoft.com/solutions/business-applications/dynamics-onprem?printpage=false)

3. Verify that your ODBC connection uses SQL Server Authentication. BCP will not start if you use only Windows authentication without also using SQL Server authentication.
4. Verify that the computer that is running Microsoft SQL Server has sufficient free disk space on the drive that is storing the DYNAMICS database physical files. Examples of these physical files are the GPSDynamicsDat.mdf file and the GPSDynamicsLog.ldf file.
5. Verify that the DYNAMICS database is configured so that there are no restrictions to the maximum file size of the database. To do this, follow these steps, depending on the version of SQL Server that you use.

   In Microsoft SQL Server Management Studio for Microsoft SQL Server 2005 or Microsoft SQL Server 2008

    1. In **Object Explorer**, expand the
    **Databases** folder, right-click the **DYNAMICS** database, and then click **Properties**.
    2. Under **Select a Page**, click
    **Files**.
    3. Under **Database Files**, click the ellipsis button next to each file, and then verify that the **Enable Autogrowth** check box is selected.
  
   In SQL Server Enterprise Manager for Microsoft SQL Server 2000

    1. Expand the **Microsoft SQL Servers** folder.
    2. Expand the **SQL Server Group** folder, and then expand the folder of the computer that is running SQL Server.
    3. Expand the **Databases** folder, right-click the **DYNAMICS** database, and then click **Properties**.
    4. Click the **Data Files** tab, and then verify that the **Automatically grow file** check box is selected.
    5. Click **Unrestricted file growth.**

6. To determine the cause of the error, examine the TestBCP.bcp file in the %programfiles%\Microsoft Business Solutions\Great Plains\ folder.
7. Verify the server name

   1. On the computer that is running SQL Server, BCP does not start if the **server_name** differs from the computer name, or if the server name contains invalid characters. Determine the name of the server that is running SQL Server by running the following statements against the MASTER database in SQL Server Management Studio or in Microsoft SQL Query Analyzer.

        ```sql
        SELECT @@servername 
        SELECT * from master..sysservers 
        ```

   2. If the names that are generated by the statements in step 5a do not match, change the name of the server that is running SQL Server. To do this, follow these steps:

      1. In the Query Editor window in SQL Server Management Studio, or in the Query Analyzer window, run the following statements one at a time against the MASTER database.

          ```sql
          sp_dropserver '<WrongSERVERNAME>' 
          sp_addserver '<RightSERVERNAME>', local 
          ```

         > [!NOTE]
         > In these statements, **\<WrongSERVERNAME>** represents the actual server name that does not match, and **\<RightSERVERNAME>** represents the actual computer name.

      2. Stop Microsoft SQL Server services. Then, start Microsoft SQL Server services.

         > [!NOTE]
         > In SQL Server 7.0, run SQL Server Setup from the original product CD. Continue the setup until the **Typical, Minimal, and Custom** page appears. At this point, you will not have installed any SQL Server components. However, this partial installation process will update SQL Server internally to reflect the computer name.

   3. If the names that are generated by the statements in step 5a do match, examine the **SRVID** value for the server name. The **SRVID** value should be **0**. This value informs the operating system that this computer is the local server. If the **SRVID** value is not **0**, make the computer the local server. Additionally, verify the computer name. To do this, follow these steps:

      1. Click **Start**. Then, click **Run**.
      2. Type *cmd*. Then, click **OK**.
      3. At the command prompt, type **hostname**, and then click **Enter**.

         > [!NOTE]
         > In this step, **hostname** represents the actual host computer name.

      4. Verify that the computer name that is returned matches the name that is returned in step 5a.
      5. If the computer name differs from the computer name in step 5a, run the scripts in step 5b to correct the server name. The server name must match the computer name.

8. Verify the following conditions:

   1. That the path of the BCP.exe file is correct
   2. That there is only one BCP.exe file
   3. That you are using the correct version of SQL Server

   To verify the path of the folder that contains the BCP.exe file, type path at the command prompt. The following path will be displayed, depending on the version of SQL Server that you are using.

    - SQL Server 2000 `C:\Program Files\Microsoft SQL Server\80\Tools\Bin`

    - SQL Server 2005 `C:\Program Files\Microsoft SQL Server\90\Tools\Bin`

    - SQL Server 2008 `C:\Program Files\Microsoft SQL Server\100\Tools\Bin`

   > [!NOTE]
   >
   > - In these paths, **C** represents the actual root directory.
   > - If there is more than one BCP.exe file on the computer, and if the files are different versions, rename any BCP.exe file that is not the version that you are using.

9. Examine the ODBCBCP.dll file and the SQLSRV32.dll file. These files must be the same version. If they are different versions, rename the SQLSRV32.dll file, and then reinstall MDAC(ODBC). The ODBCBCP.dll and SQLSRV32.dll files are located in the WINNT\System32 folder. The version numbers of these files must be the same to the last digit.

10. Check the ODBC connectivity. To do this, verify that the system DSN can test successfully. If you are using SQL Server 7.0, verify that you can successfully run odbcping. To do this, type the command at the command prompt: `Odbcping - D Datasource -U Username -P Password`. Then, set up a new system DSN by using a name that has not been used before.

11. If you are at the client computer, type *AllowBCPTest=FALSE* in the Dex.ini file. Then, start Microsoft Dynamics GP Utilities.

    > [!NOTE]
    > This step does not apply to the initial installation of Microsoft Dynamics GP if you are creating the databases.

12. To troubleshoot this problem more, follow these steps:

    1. Create a Dexsql.log file.
    2. Start Microsoft Dynamics GP Utilities.
    3. Re-create the scenario that caused the error message.
    4. Examine the end of the Dexsql.log file. Look for any errors that could have caused the error message.

For more information about how to create a Dexsql.log file, see [KB 850996 - How to create a Dexsql.log file to troubleshoot error messages in Microsoft Dynamics GP](https://support.microsoft.com/help/850996).
