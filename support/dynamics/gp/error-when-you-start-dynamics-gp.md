---
title: You are attempting to log in from a data source when you try to start Dynamics GP
description: Discusses that you receive an error message after you install SQL Server Desktop Engine (also known as MSDE 2000), and then you try to start Microsoft Dynamics GP. Provides a resolution.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Error message when you try to start Microsoft Dynamics GP: "You are attempting to log in from a data source using a trusted connection"

This article provides a solution to an error that occurs when you try to start Microsoft Dynamics GP.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](../../windows-server/performance/windows-registry-advanced-users.md).

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 869956

## Symptoms

When you try to start Microsoft Dynamics GP, you receive the following error message:

> You're attempting to log in from a data source using a trusted connection. Update the SQL Server settings for this data source to disable trusted connections and try logging in again.

## Cause

This problem may have any of the following causes:

### Cause 1

By default, Microsoft SQL Server Desktop Engine (MSDE) 2000 installs the Windows Authentication mode. However, Microsoft Dynamics GP requires both Windows Authentication and SQL Server Authentication. See [Resolution 1](#resolution-1) in the [Resolution](#resolution) section.

### Cause 2

The ODBC System DSN may not be using SQL Server Authentication. See [Resolution 2](#resolution-2) in the [Resolution](#resolution) section.

### Cause 3

If you have recently upgraded from an earlier version, this problem can occur because the user ID contains uppercase letters. However, you entered all lowercase letters. See [Resolution 3](#resolution-3) in the [Resolution](#resolution) section.

## Resolution

### Resolution 1

Check the authentication mode that was originally installed. To do this, use one of the following methods:

#### Method 1: If you use MSDE 2000

To resolve this problem, use the osql command. To do this, follow these steps:

1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
2. Type the `osql -S server_name -E` command at the command prompt.
    > [!NOTE]
    > In this command, **Server_Name** represents the actual name of the server.
3. MSDE 2000 requires Windows Authentication. To determine the authentication mode that was installed, type the following commands at the command prompt. Press ENTER after you type each command.

    ```console
    SELECT
    case 
    when serverproperty('IsIntegratedSecurityOnly') = 1 then 'Windows Only'
    when serverproperty('IsIntegratedSecurityOnly') = 0 then 'SQL and Windows'
    end
    ```

4. If the returned value is Windows Authentication only, change the authentication mode to both Windows Authentication and SQL Server Authentication by changing the LoginMode registry value. To do this, use one of the following methods.

    > [!NOTE]
    > Instead of performing all of step 4, you can reinstall MSDE 2000, and then select both Windows Authentication and SQL Server Authentication during the installation.

    - Use registry editor

        > [!WARNING]
        > Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

        1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
        2. Locate and then click the following registry subkey:

            `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\INSTANCE\MSSQLServer`

        3. In the details pane, double-click **LoginMode**.
        4. In the **Value data** box, type *2*, and then click **OK**.

    - Use the osql command

        1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
        2. At the command prompt, Type the `osql -S Servername -E` command. Then press ENTER.
        3. After you log in, type the following command at the command prompt, and then press ENTER:

            ```console
            xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer', 'LoginMode', N'REG_DWORD', 2
            ```

            If you have multiple instances of MSDE 2000 running, type the following command instead:

            ```console
            xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\Microsoft SQL Server\INSTANCE\MSSQLServer', 'LoginMode', N'REG_DWORD', 2
            ```

            > [!NOTE]
            >
            > - In these commands, **INSTANCE** represents the actual name of the instance of SQL Server.
            > - In the registry, the LoginMode registry subkey can have the following values:
            >
            >   - 1: Windows Authentication
            >   - 2: mixed mode (Windows Authentication and SQL Server Authentication)

        > [!NOTE]
        >
        > - You must restart the computer for the changes to take effect.
        > - These steps can be done more easily by modifying the registry instead of using the osql command.

#### Method 2: If you use SQL Server 2000, SQL Server 2005, or SQL Server 2008

1. Follow the steps for your version of SQL Server:

    - For SQL Server 2005 or SQL Server 2008

        Start SQL Server Management Studio. To do this, click **Start**, point to **Programs**, point to **Microsoft SQL Server 2005** or to **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.

    - For SQL Server 2000

        Start SQL Server Enterprise Manager. To do this, click **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then click **Enterprise Manager**.

2. Right-click the server name, and then click **Properties**.
3. Click the **Security** tab.
4. Determine Check whether this instance of SQL Server uses only Windows Authentication or instead uses both SQL Server Authentication and Windows Authentication.

### Resolution 2

Check your ODBC connection. To do this, follow these steps:

1. Open the ODBC Data Source Administrator window. To do this, click **Start**, click **Run**, type odbcad32.exe, and then click **OK**.
2. Click the **System DSN** tab.
3. Click to select the System DSN that is used to access Microsoft Dynamics GP, and then click **Configure**.
4. Click **Next**.
5. Make sure that the **With SQL Server authentication using a login ID and password entered by the user** option is selected.
6. In the **Login ID** field, Type *sa*. In the **Password** field, type the password. Then, click **Next**.

### Resolution 3

If you recently upgraded Microsoft Dynamics GP from an earlier version, or if you recently applied a service pack, check the password. To do this, follow these steps:

1. Open the User Setup window. To do this, follow these steps:

    - In Microsoft Dynamics GP 10.0

        On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User**.

    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0

        On the **Tools** menu, point to **Setup**, point to **System**, and then click **User**.

2. In the **User ID** field, click the lookup button, click to select the user who is experiencing the problem, and then click **Select**.
3. In the **Password** field, type the password. Then, click **Save**.
