---
title: You don't have security privileges to this window error when signing in or opening a window or a report
description: Describes an issue that occurs when you start Microsoft Dynamics GP or when you open a window or a report in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, lmiller
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "You don't have security privileges to this window" error when signing in to Microsoft Dynamics GP or open a window or a report

This article provides a resolution for the **You don't have security privileges to this window** error that may occur when you sign in to Microsoft Dynamics GP or open a window or a report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857086

## Symptoms

### Symptom 1

When you start Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains, or when you try to open a restricted window, you receive the following error message:

> You don't have security privileges to this window. Contact your system administrator for assistance.

See Cause 1, Cause 2, and Cause 3.

### Symptom 2

When you open a window or a report in Microsoft Dynamics GP 10.0, you receive the following error message:

> You don't have security privileges to open this window. Contact your system administrator for assistance.

See Cause 4.

## Cause

### Cause 1

This problem occurs because you do not have security access to one or more of the shortcut windows that are listed in the Startup folder.

See Resolution 1.

### Cause 2

In Microsoft Business Solutions - Great Plains 8.0 and in Microsoft Dynamics GP 9.0, this problem occurs because minimum security is not set correctly.

This problem does not occur in Microsoft Dynamics GP 10.0.

See Resolution 2.

### Cause 3

If you can successfully log on when you select **OK** in the error message, a third-party product may be restricting access.

See Resolution 3.

### Cause 4

This problem occurs because the window or the report has insufficient security rights.

See Resolution 4.

## Resolution

### Resolution 1

To resolve this problem, remove the window from the Startup folder. Or, grant the usersecurity access to the window.

### Resolution 2

To resolve this problem in Microsoft Business Solutions - Great Plains 8.0 and in Microsoft Dynamics GP 9.0, set up minimum security. For more information, see [How to set up minimum security access to log in to Microsoft Dynamics GP or to Microsoft Great Plains](https://support.microsoft.com/topic/how-to-set-up-minimum-security-access-to-log-in-to-microsoft-dynamics-gp-or-to-microsoft-great-plains-c5cf0b55-5677-ae0f-a37b-bddda0e01e7b).

This problem does not occur in Microsoft Dynamics GP 10.0.

### Resolution 3

To resolve this problem, remove the third-party product from the Dynamics.set file. For more information about how to remove items from your Dynamics.set file, see [Steps to disable third-party products or temporarily disable additional products in the Dynamics.set file in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-steps-to-disable-third-party-products-or-temporarily-disable-additional-products-in-the-dynamics-set-file-in-microsoft-dynamics-gp-a1fd71d3-7b9f-2827-718c-8c6d5df5f4c5).

### Resolution 4

To resolve this problem, follow these steps:

1. Capture the error in a log file. To do this, follow these steps:
   1. Create a Dexsql.log file. For more information about how to create a Dexsql.log file, see [How to create a Dexsql.log file to troubleshoot error messages in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-850996-how-to-create-a-dexsql-log-file-to-troubleshoot-error-messages-in-microsoft-dynamics-gp-67f4d9e9-51dd-69a8-57d8-6625416e3cb1).

   2. On the workstation, sign in to Microsoft Dynamics GP 10.0 as the user who receives the error.
   3. Re-create the issue, but do not select **OK** to close the message.
   4. Locate the Dexsql.log file, and then rename the file to prevent the file from being written.

        > [!NOTE]
        > The Dexsql.log file will be written to the same Data folder that holds the Dex.ini file.

   5. Open the Dexsql.log file, scroll to the bottom, and then look for the last call to the User Security table (SY10000). For example, the last call would appear as follows:

      { CALL DYNAMICS.dbo.zDP_SY10000SS_1 ( 'sa', -1, 0, 390, 2 ) }

        > [!NOTE]
        > The parameters of this call are as follows:
        >
        > - 'sa' is the ID of the user whose security is being checked.
        > - -1 is the Company ID where the security is being checked.
        > - 0 = (DICTID) is the Product ID of the window or the report that is opened.
        > - 390 = (SECURITYID) is the Unique ID for the window or the report that is opened.
        > - 2 = (SECRESTYPE) is the Resource type. A value of 2 indicates a window, and a value of 23 indicates a report.

2. Populate the Security Resource Description table to translate the Security ID value to a window name or to a report name. To do this, follow these steps:

   1. Sign in to Microsoft Dynamics GP 10.0 as the *sa* when no other users are signed in.
   2. Select **Microsoft Dynamics GP**, point to **Maintenance**, and then select **Clear Data**.
   3. On the **Display** menu, select **Physical**.
   4. In the **Series** field, select **System** in the drop-down list.
   5. Select the **Security Resources Description** table, select **Insert**, and then select **OK** to process.
   6. Print the report to screen, and then check for errors.

3. Check the Security Resource Description table for the window or the report name. To do this, edit and run the following script in Microsoft SQL Server Management Studio or in SQL Query Analyzer against the DYNAMICS database.

    ```sql
    SELECT * FROM DYNAMICS..SY09400
    WHERE DICTID = 
    AND SECURITYID = 
    AND SECRESTYPE = 
    ```

    In this example, the script would appear as follows.

    ```sql
    SELECT * FROM DYNAMICS..SY09400
    WHERE DICTID = 0
    AND SECURITYID = 390
    AND SECRESTYPE = 2
    ```

    Therefore, this script returns the Customer Maintenance window as the source of the issue.

4. Generate a list of Microsoft Dynamics GP 10.0 security tasks and roles that grant access to this window. To do this, edit and then run the following script against the DYNAMICS database.

    ```sql
    SELECT ISNULL(A.SECURITYROLEID,'') AS SECURITYROLEID, 
    ISNULL(M.SECURITYROLENAME,'') AS SECURITYROLENAME, 
    --ISNULL(M.SECURITYROLEDESC,'') AS SECURITYROLEDESC, 
    ISNULL(O.SECURITYTASKID,'') AS SECURITYTASKID, 
    ISNULL(T.SECURITYTASKNAME,'') AS SECURITYTASKNAME, 
    --ISNULL(T.SECURITYTASKDESC,'') AS SECURITYTASKDESC, 
    R.PRODNAME, R.TYPESTR, R.DSPLNAME, R.RESTECHNAME, R.DICTID, R.SECRESTYPE, 
    R.SECURITYID FROM DYNAMICS.dbo.SY09400 R 
    FULL JOIN DYNAMICS.dbo.SY10700 O ON R.DICTID = O.DICTID AND O.SECRESTYPE = R.SECRESTYPE AND O.SECURITYID = R.SECURITYID 
    FULL JOIN DYNAMICS.dbo.SY09000 T ON T.SECURITYTASKID = O.SECURITYTASKID 
    FULL JOIN DYNAMICS.dbo.SY10600 A ON A.SECURITYTASKID = T.SECURITYTASKID 
    FULL JOIN DYNAMICS.dbo.SY09100 M ON M.SECURITYROLEID = A.SECURITYROLEID WHERE R.DSPLNAME = '<Display_Name>'
    ```

    > [!NOTE]
    > Replace **<Display_Name>** with the window name or with the report name from the SY09400 table results.

5. Change the user's Security Role assignment to add them to one of the roles that is listed in the results of step 4. Additionally, you can create a new Security Role based on the Security Tasks that are listed in the results.
