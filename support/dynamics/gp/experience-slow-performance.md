---
title: Experience slow performance
description: Provides information that you can use to troubleshoot performance problems. Also contains a list of questions that you should answer before you contact a support professional.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 02/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# You experience slow performance when you do specific processes in Microsoft Dynamics GP

This article provides a solution to an issue where you experience slow performance when you do specific processes in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 898982

## Symptoms

You experience slow performance when you do specific processes, such as posting an inquiry or doing an inquiry, in Microsoft Dynamics GP.

## Resolution

### Posting problems

- If posting is slow or hanging, open the Dynamics.set file from the Dynamics GP code folder with Notepad. Review the installed products to see if **Payment Document Management (2150)** is installed. This module is typically not installed on a U.S. installation and changes behavior in payment windows, so may cause performance issues. Uninstall this module if you aren't using it.
- If you experience performance issues when you post, run the following SELECT statement on the `PJOURNAL` table. Run the statement against all the company databases.

    ```sql
    SELECT * FROM PJOURNAL
    ```

    If rows are returned, we recommend that you clear the contents of the table by running the following statement against all the company databases.

    ```sql
    DELETE PJOURNAL
    ```

> [!NOTE]
>
> - If you're using Microsoft SQL Server Management Studio for Microsoft SQL Server (any version), select **Start**, point to **Programs**, point to **Microsoft SQL Server 20XX** **(XX=your version)**, and then select **SQL Server Management Studio**.
> - The `PJOURNAL` table is a temporary table and doesn't affect data.
> - All users must exit Microsoft Dynamics GP before you run the DELETE statement.
> - A `PJOURNAL` job is also created when you install Microsoft Dynamics GP. The `PJOURNAL` job must be turned on manually for the job to manage the `PJOURNAL` table so that the table does not grow larger and affect performance.

### Printer settings that affect Microsoft Dynamics GP performance

Client workstations should have a default printer set up and online. Other added printers should also be online or should be removed if they're no longer valid.

If you can, we recommend that you use a local printer as the default printer instead of a network printer. It's for performance reasons.

### Performance issues that occur when you open windows

The AutoComplete feature may cause performance issues when you open windows in Microsoft Dynamics GP. To turn off the AutoComplete feature, follow these steps:

1. Open the user preferences. To do it, follow these steps:
   - In Microsoft Dynamics GP 10.0 and later versions, select **Microsoft Dynamics GP**, and then select **User Preferences**.
2. Select **AutoComplete**.
3. Select to clear the **Show AutoComplete Suggestions** checkbox, and then select **OK**.
4. In Windows Explorer, delete the AutoCmpl.dat file and the AutoCmpl.idx file. These files are in the following folder:
   - In Microsoft Dynamics GP 10.0 and later versions, the files are in the following location:
       `Document and Settings\username\Application Data\Microsoft Business Solutions\Microsoft Dynamics GP\dbname\`
5. Repeat step 1 through step 5 for each user.

### Performance issues that occur when you sign into Microsoft Dynamics GP

1. The location of the modified Reports.dic file and the modified Forms.dic file may affect the sign-in performance. If the modified dictionaries are on a network share, copy the dictionaries to the local Microsoft Dynamics GP folder, and then try to sign in. To do it, follow these steps
2. Certain SmartList reminders may cause sign-in issues, depending on the homepage role for that user. To verify the reminders for a user, use the following method:
   - In Microsoft Dynamics GP 10.0 and later versions, select **Microsoft Dynamics GP**, and then select **Reminders**. Select **Change Reminder Preferences**, and then remove the reminders in the Custom Reminder section at the bottom of the window.
3. You may have shortcuts to network locations that are no longer mapped or available. Microsoft Dynamics GP will try to validate those locations. However, if they aren't reachable, the process will time out after several seconds.
   - In Microsoft Dynamics GP 10.0 and later versions, expand the Shortcuts folder in the Navigation pane on the left side of the Home Page. If you notice any unnecessary or invalid shortcuts, remove them.
   - You can also validate the links that are stored in the Shortcut Bar Master (SY01990) table. Run the following script in Query Analyzer or in SQL Server Management Studio:

        ```sql
        SELECT * FROM DYNAMICS..SY01990
        ```

        If you see any network paths in the ScbTargetStringOne column that are no longer valid, delete the associated shortcut. You can delete the shortcut in Microsoft Dynamics GP or from the table.
4. For Microsoft Dynamics GP performance, an OLE Notes path in the Dex.ini file that is local instead of on a network is recommended. If the OLE path has to be a network path, verify that it's a valid path and that there's good bandwidth.
5. Verify that the SQL database options AutoClose and AutoShrink are set to FALSE.
   - If you use SQL Server Management Studio, follow these steps:
      1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008** (or later), and then select **SQL Server Management Studio**.
      2. In the Connect to Server window, follow these steps:
         1. In the **Server Name** box, type the name of the server that is running SQL Server.
         2. In the **Authentication** box, select **SQL Authentication**.
         3. In the **Login** box, type **sa**.
         4. In the **Password** box, type the password for the sa user, and then select **Connect**.
      3. In the Object Explorer window, under the SQL Server instance, expand **Databases**.
      4. Right-click the DYNAMICS database, and then select **Properties**.
      5. In the Database Properties window, select the **Options** page.
      6. Under the **Automatic** options, verify that both the **Auto Close** and the **Auto Shrink** fields are set to **FALSE**.

        If one of these fields is set to **TRUE**, select **True** and then select **FALSE** in the drop-down window.
      7. Select **OK** to save changes.
      8. Repeat steps d through g for all Dynamics GP company databases.
   - If you use SQL Enterprise Manager, follow these steps:
      1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2000**, and then select **Enterprise Manager**.
      2. Expand **Microsoft SQL Servers**, expand **SQL Server Group**, and then expand the name of the server that is running SQL Server.
      3. Expand **Databases**.
      4. Right-click the DYNAMICS database, and then select **Properties**.
      5. In the Properties window, select the **Options** tab.
      6. Under **Settings**, select to clear the **Auto Close** checkbox and the **Auto Shrink** checkbox.
      7. Select **OK** to save changes.
      8. Repeat steps d through g for all Dynamics GP company databases.
   - If you use the Support Administrator Console, follow these steps:
      1. Select **Start**, point to **All Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**.
      2. In the Connect to SQL Server window, follow these steps:
         1. In the **SQL Server** box, type the name of the new server.
         2. In the **Login Name** box, type sa .
         3. In the **Password** box, type the password for the sa user, and then select **OK**.
      3. Copy the following script to the New Query 1 window:

         ```sql
         ALTER DATABASE DYNAMICS SET AUTO_SHRINK OFF, AUTO_CLOSE OFF
         ```

      4. Press F5 or select **Execute** to run the script.
      5. Run this script against each Dynamics GP company database by changing the DYNAMICS database name to the name of the company database.

6. Verify that the ODBC System DSN data source connection on each computer tests successfully for connectivity with the SQL Server holding the Dynamics GP or the Great Plains databases:
   1. Select **Start**, select **Control Panel**, select **Administrative Tools**, and then select **Data Sources (ODBC)**.
   2. Select the **System DSN** tab, select the data source that is being used to start Microsoft Dynamics GP or Microsoft Business Solutions-Great Plains, and then select **Configure**.
   3. Verify that the Server name shows the correct SQL Server instance, and then select **Next**.
   4. Type the password for the sa sign-in ID, and then select **Next**.
   5. Verify that the **Change the default database to**, **Attach database filename**, **Use ANSI quoted identifiers**, and **Use ANSI nulls, paddings and warnings** options aren't selected, and then select **Next**.
   6. Make sure that none of the options in the next window are selected, and then select **Finish**.
   7. Select **Test Data Source** and verify that you receive the following message:

       > TESTS COMPLETED SUCCESSFULLY!

   8. Select **OK** to exit all windows.

You can also create a new ODBC data source for troubleshooting sign-in performance issues with Microsoft Dynamics GP and Great Plains.

For more information, see [How to set up an ODBC Data Source on SQL Server for Microsoft Dynamics GP](https://support.microsoft.com/help/870416)

### Virus scanner setup

We recommend the following exclusions.

**On the Microsoft Dynamics GP client**  
Exclude the Dynamics\GP folder. By default, this folder is in the following location:  
`C:\Program Files\Microsoft Dynamics\GP`

The following file name extensions should be excluded:

- .cnk
    These files are used when service packs are installed. These files shouldn't be in a directory for a significant time.
- .dic and .chm

    These files are the Help files for Microsoft Dynamics GP.
- .set

    These files are the start files. These files contain information about the products that are installed and where the products are located.
- .ini

    These files are the configuration files. These files hold information about which user logged on most recently, what data source is used, and the paths.
- .dat

    These files are ctree .dat files that are used with an SQL database.
- .idx

    These files are ctree index files that are used with an SQL database.
- .vba

    These files are used if there are Microsoft Visual Basic for Applications (VBA) modifications for Microsoft Dynamics GP.
- .log

    These files are used by a Dexsql.log file if you use a Dexsql.log file to troubleshoot an error message.

On the computer that is running SQL Server  
Exclude the `*.ldf` database files, and the `*.mdf` database files.

On any computer that is running Integration Manager  
Exclude the .MDB or .IMD files and the Integration Manager code folder which default, this folder is in the following location:

`C:\Program Files\Microsoft Dynamics\Integration Manager`

### Performance problems that occur on the home page in Microsoft Dynamics GP

One or more of the home page sections may cause performance problems when you sign in or when you refresh the home page. To determine the cause of this problem, follow these steps:

1. On the home page, select the **Customize this page** link.
2. In the **Mark content to display** section, select to clear each area.
3. To apply the changes, select **OK**.
4. In the Customize your home page window, add items back to the home page. To do it, select the checkbox next to an item. To test how long the page takes to load, refresh the home page after you add each item.

The following features may affect home page performance:

- The Outlook integration

    Latency with the Microsoft Exchange server can cause performance problems on the home page in Microsoft Dynamics GP.
- The SmartList favorites in the Reminders area of the To Do home page section

    Reminders that are linked to the SmartList favorites that have many returned records may cause performance problems on the home page in Microsoft Dynamics GP. For example, this problem may occur if there are more than 1,000 returned records.

## Technical support-assisted troubleshooting

If you can't resolve the performance issue, you can contact Technical Support for Microsoft Dynamics. Before you contact Technical Support for Microsoft Dynamics, review the following list of questions. The answers to these questions will help the support professional troubleshoot the performance issue:

1. What are the steps that let you reproduce the performance issue?
2. If you experience performance issues when you post, answer the following questions:
   - What module or modules are you posting?
   - How many transactions are in the batch?
   - How long does the posting process last?
   - How long did the posting process last before you began to experience the performance issue? Or, has the posting process always been slow?
3. Can you easily reproduce the performance issue, or does the performance issue occur randomly?
4. Can you reproduce the performance issue on all the computers?
5. Specifically, can you reproduce the performance issue when you're sitting directly at the computer that is running Microsoft SQL Server?
6. When you experience the performance issue, do you receive an error message? Or, does the process merely stop responding?
7. What other products or third-party products do you use together with Microsoft Dynamics GP?

    > [!NOTE]
    > Obtain this information from the Dynamics.set file on the computer that is experiencing the performance issue.
8. Are you using any customizations in Microsoft Dynamics GP?
9. Have any changes or problems occurred in the network? These changes and problems might include the following ones:
   - New hardware
   - New software such as antivirus software
   - Recent server crashes
10. Is the computer that is running SQL Server a dedicated server for Microsoft Dynamics GP? Are there any other processes that are running on the computer that is running SQL Server, such as integrations or replications?
11. How many users are logged on to the system when the performance issue occurs?
12. Are there any physical symptoms on the computer that is running SQL Server? For example, is processor usage at 100 percent? Is the processor light on?

## Sources of more troubleshooting information

The following sources are the more troubleshooting information.

### The System Information tool

Run the System Information tool to obtain the hardware specifications of the following computers:

- The computer that is running SQL Server
- The client workstations
- The computer that is running Terminal Server

To obtain this information, follow these steps on each computer:

1. Select **Start**, select **Run**, type **msinfo32**, and then select **OK**.
2. Select **File**, and then select **Save** to save this information to a file.

### Trace logs

Create a Dexsql.log file and a SQL trace when you reproduce the performance issue.

For more information, see:

- [How to create a Dexsql.log file to troubleshoot error messages in Microsoft Dynamics GP](create-a-dexsql-dot-log-file-troubleshoot.md)
- [How to create a SQL Trace with Profiler on Microsoft SQL Server 2000-2014](https://support.microsoft.com/help/857246)

To enable more tracing, use SQL Query Analyzer to run the following script against the master database.

```sql
DBCC Traceon (1204,3605 -1)
```

> [!NOTE]
> This trace flag captures more information about deadlocks in the SQL Server error logs. To view the SQL Server error logs, start SQL Enterprise Manager. Select **Management**, and then select **SQL Server Logs**.

### The SQLDIAG tool

Create a *Sqldiag.txt* output file when you reproduce the performance issue. For more information, see [Description of the SQLDIAG diagnostic tool](/sql/tools/sqldiag-utility).

### The Application log

Information that is logged in the Application log on the computer that is running SQL Server may be helpful. To obtain the information that is logged in the Application log, follow these steps:

1. Select **Start**, point to **Administrative Tools**, and then select **Event Viewer**.
2. In Event Viewer, select **Application**, select **Action**, and then select **Save Log File As**.

## More information

For Performance issues, see [Performance with Microsoft Dynamics GP: Where do I Start?](https://community.dynamics.com/blogs/post/?postid=b0ee4783-d6d4-46b9-8601-f152d5b04aac).
