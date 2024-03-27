---
title: Error message when you log on to Microsoft Dynamics GP 
description: This article provides a resolution for the problem that occurs when you try to log on to Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "This login failed. Attempt to log in again or contact your system administrator" error when you log on to Microsoft Dynamics GP

This article helps you resolve the problem that occurs when you try to log on to Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 919345

## Symptoms

When you try to log on to Microsoft Dynamics GP, you may receive the following error message:

> This login failed. Attempt to log in again or contact your system administrator

## Cause 1: Password is changed at another computer

This problem may occur if the password is changed at another computer. If the password is changed at another computer, the user cannot log on to Microsoft Dynamics GP at the user's computer. This situation occurs because the way in which the server name is set up in the Data Source (ODBC) differs from the way in which the server name is set up on the computer where the password is encrypted.

See [Resolution 1](#resolution-1).

## Cause 2: An incorrect case is used

This problem may occur if the user logs on by using the incorrect case for the user ID or for the encrypted password. In this case, the error message is received at the next logon.

See [Resolution 2](#resolution-2).

## Cause 3: The latest service pack for Microsoft Dynamics GP isn't installed

This problem may occur if the following conditions are true:

- You're running Microsoft Dynamics GP.
- A new user is created.
- The new user can't log on.

See [Resolution 3](#resolution-3).

## Cause 4: The "Advanced Password Policies" checkboxes are selected

This problem may occur if the **Advanced Password Policies** checkboxes are selected in the User Setup window when you update from Microsoft SQL Server Desktop Engine (MSDE) to Microsoft SQL Server Express.

See [Resolution 4](#resolution-4).

## Cause 5: The public group doesn't have the Execute permission

This problem may occur if the public group doesn't have the Execute permission on the `smDex_Max_Char` stored procedure in the master database.

See [Resolution 5](#resolution-5).

## Cause 6: You're using mandatory profiles together with Terminal Server

See [Resolution 6](#resolution-6).

## Cause 7: The SQL login for the user is no longer present

See [Resolution 7](#resolution-7).

## Resolution

### Resolution 1

To resolve this problem, verify the Data Source (ODBC) that you use for Microsoft Dynamics GP at the computer at which you receive the error message. To verify the Data Source (ODBC), select **Start** > **Administrative Tools** > **Data Sources (ODBC)**, and then double-click the DSN connection. In the list that appears, you should see one of the following things:

- The name of the computer that is running Microsoft SQL Server
- The TCP/IP address of the computer that is running SQL Server. This address appears in the **Servername** box. If you know neither the name of the computer that is running SQL Server nor the TCP/IP address of the computer that is running SQL Server, you can verify the Data Source (ODBC) on a working computer. For more information about an ODBC setup, see [How to set up an ODBC Data Source on SQL Server for Microsoft Dynamics GP](https://support.microsoft.com/help/870416).

### Resolution 2

The logon **User ID** field is now case-sensitive in Microsoft Dynamics GP. To resolve this problem, you must encrypt the user's password by using the correct case for the user ID. To do this, follow these steps:

1. Log on to Microsoft Dynamics GP as the sa user.
2. Select **Tools**, point to **Setup**, point to **System**, and then select **User** if you use Microsoft Dynamics GP 9.0, or select **Microsoft Dynamics GP**, select **Tools**, point to **Setup**, point to **System** and then select **User** if you use Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010.
3. In the **User ID** box, select the lookup button, and then select the user who cannot log on.
4. In the **Password** box and in the **Confirm Password** box, type a new password.

> [!NOTE]
> If you are using Microsoft SQL Server 2005 or Microsoft SQL Server 2008 and Windows Server 2003 or Windows Server 2008 and are in a Windows Server 2003 or Windows Server 2008 domain, you can select the **Change Password at Next Login** check box in the User Setup window. For this feature to work correctly, the client computers must use SQL Native Client for the DSN connections that they use for Microsoft Dynamics GP.

### Resolution 3

To resolve this problem, obtain the latest service pack for Microsoft Dynamics GP. For more information, visit the following Microsoft Web site.

- [Partners](https://mbs2.microsoft.com/userinfo/associateaccount.aspx)

### Resolution 4

To resolve this problem, follow these steps:

1. Log on as the sa user.
2. On the **Microsoft Dynamics GP** menu, select **Tools**, point to **Setup** > **System**, and then select **User**.
3. Select the user who is experiencing the problem.
4. Select to clear the following checkboxes:

    - **Change Password Next Login**  
    - **Enforce Password Policy**  
    - **Enforce Password Expiration**

5. In the **Password** box and then in the **Confirm Password** box, type the user's password, and then select **OK**.
6. Have the user log on to see whether the problem still occurs.

### Resolution 5

To resolve this problem, follow these steps, depending on the version of SQL Server that you are using.

- SQL Server 2008 or later

   1. Select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005** or to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
   2. Log on as the sa user.
   3. Under the server that is running SQL Server and Microsoft Dynamics GP, expand **Databases**, expand **System Databases**, expand **Master**, expand **Programmability**, and then expand **Stored Procedures**.
   4. Right-click **smDex_Max_Char**, and then select **Properties**.
   5. On the **Permissions** tab, select the **ADD** button under **Users or roles**.
   6. In the "Select Users or Roles" window, select the **Browse** button.
   7. Select to select the **Public** checkbox, and then select **OK** two times.
   8. On the **Permissions** tab, verify that **Public** appears under **Users or roles**.
   9. Select to select the **Execute/Grant** checkbox, and then select **OK**.

### Resolution 6

#### Microsoft Dynamics GP

The mandatory profile should be removed by the system administrator.

### Resolution 7

To resolve this problem, verify that the SQL login exists. If the SQL login does not exist, remove the user ID from the Microsoft Dynamics GP database, and then re-create the SQL login. To do this, follow these steps.

#### Step 1: Verify that the SQL login exists

To verify that the SQL login exists, follow these steps, depending on the version of SQL Server that you are using.

##### SQL Server 2008 or later

1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
2. In the "Connect to Server" window, follow these steps:

   1. In the **Server name** box, type name of the SQL Server.

   2. In the **Authentication** box, select **SQL Authentication**.
   3. In the **Login** box, type *sa*.

   4. In the **Password** box, type the password for the sa user, and then select **Connect**.

3. Select **New Query**, and then paste the following script into the blank query window:

   ```sql
   SELECT name FROM master.sys.sql_logins
   ```

4. On the **File** menu, select **Execute**.
5. In the list of SQL logins, verify that the SQL login that is experiencing the problem exists.

#### Step 2: If the SQL login does not exist, remove the user ID from the Microsoft Dynamics GP database

To remove the user ID from the Microsoft Dynamics GP database, take one of the following actions,

- SQL Server 2008 or later

  Run the following script against the DYNAMICS database and against all company databases:
  
   ```sql
   DROP USER '<XXX>'
   ```

   > [!NOTE]
   > In this script, the placeholder `<XXX>` represents the actual login ID of the user.

#### Step 3: Re-create the SQL login and the user ID in the Microsoft Dynamics GP database

To re-create the SQL login and the user ID in the Microsoft Dynamics GP database, follow these steps:

1. Log on to Microsoft Dynamics GP as the sa user.
2. Open the User Setup window. To do this, take one of the following actions, depending on the version of Microsoft Dynamics GP that you are using.

   Microsoft Dynamics GP 2010 or Microsoft Dynamics GP 10.0

   On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User**.

   Microsoft Dynamics GP 9.0

   On the **Tools** menu, point to **Setup**, point to **System**, and then select **User**.

3. In the User Setup window, follow these steps:

   1. In the **User ID** box, select the **Lookup** button, and then select the user account.

   2. If the SQL login for the user does not exist, you receive the following error message:

      This user does not have a corresponding SQL Login. To create a SQL Login, enter a password and choose save.

   3. Select **OK**.

   4. Re-create the SQL login for the user. To do this, change the password in the **Password** box, and then select **Save**.

   5. Close the User Setup window.

4. Open the User Access Setup window.

   On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Access**.

5. Re-create the user ID for the company databases. To do this, select the user, clear the **Access** check box for all the companies that are selected, and then select the **Access** check box again for the companies to which you want the user to have access.

6. Select **OK** to close the User Access Setup window.

## More information

- [Error message if you try to change the password when you log on to Microsoft Dynamics GP 9.0: "The password change failed for an unknown reason. Enter a different password or contact your system administrator"](fail-to-change-password-when-logging-on.md)
- [Frequently asked questions about the advanced SQL Server options in the User Setup window in Microsoft Dynamics GP](advanced-sql-server-options-user-setup-window.md)
