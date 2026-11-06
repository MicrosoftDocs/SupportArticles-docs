---
title: Test OLE DB Connectivity to SQL Server by Using a UDL File
description: Learn how to create a Universal Data Link (UDL) file, test OLE DB connectivity to SQL Server by using different providers, and troubleshoot connection failures.
ms.date: 11/06/2026
ms.custom: sap:Database Connectivity and Authentication
ms.reviewer: jopilov
ai-usage: ai-assisted
---
# Test OLE DB connectivity to SQL Server by using a UDL file

_Applies to:_ &nbsp; SQL Server

## Summary

This article explains how to create a Universal Data Link (UDL) file and use it to test Object Linking and Embedding Database (OLE DB) connectivity to a SQL Server instance. A UDL file lets you check a connection (also called a data link) independent of your application, so you can narrow down whether a connection failure relates to the driver, the network, or the application's connection string. You can test Microsoft OLE DB Driver for SQL Server, the legacy Microsoft OLE DB Provider for SQL Server, the legacy Microsoft OLE DB provider for (ODBC) drivers, and any other OLEDB provider installed on your system. The article also shows how to test 32-bit providers on 64-bit Windows and how to isolate common connection problems.

This article is for database administrators and developers who need to troubleshoot SQL Server connection errors from a Windows client computer.

## Create a UDL file

A UDL file enables you to test OLE DB provider connectivity to any backend database independent of a full application. When you save a UDL file, it generates a well-formed connection string. You can use that string to help build an application's connection string or to check how to set different properties. To obtain the string, open the UDL file in a text editor (e.g. Notepad).

To create a UDL file to test your OLE DB provider, follow these steps:

1. To show file extensions in File Explorer, follow these steps:

    1. Select **Start**, and enter _File Explorer Options_.

    1. Select the **View** tab, uncheck the **Hide extensions for known file types** option, and then select **OK**.

1. Navigate to the folder where you want to create a UDL file. For example, `C:\temp`.

1. Create a new text file (such as `sqlconn.txt`), and then rename the extension from `.txt` to `.udl`. (Select **Yes** to the warning message about changing the file name extension.)

    Alternatively, use the following PowerShell script to create `sqlconn.udl` in your `%temp%` folder and open it. The script sets the server name to `(local)`. Change the `$ServerName` value to test a different server.

    ```powershell
    clear
    $ServerName = "(local)"
    $UDL_String = "[oledb]`r`n; Everything after this line is an OLE DB initstring`r`nProvider=MSOLEDBSQL.1;Integrated Security=SSPI;Persist Security Info=False;User ID=`"`";Initial Catalog=`"`";Data Source=" + $ServerName + ";Initial File Name=`"`";Server SPN=`"`";Authentication=`"`";Access Token=`"`""
    Set-Content -Path ($env:temp + "\sqlconn.udl") -Value $UDL_String -Encoding Unicode

    #open the UDL
    Invoke-Expression ($env:temp + "\sqlconn.udl")
    ```

## Test a connection by using Microsoft OLE DB Driver for SQL Server

Use this procedure when your application connects to SQL Server through an OLE DB driver or provider for SQL Server.

[Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/oledb-driver-for-sql-server) is the current SQL Server OLE DB driver. The current version of the driver registers as `MSOLEDBSQL19`. The driver supports newer features, such as TLS 1.2 and 1.3, [MultiSubnetFailover](/sql/connect/oledb/features/oledb-driver-for-sql-server-support-for-high-availability-disaster-recovery), and Microsoft Entra authentication methods. Use this driver for newer SQL Server databases.

The [legacy Microsoft OLE DB Provider](/previous-versions/sql/ado/guide/appendixes/microsoft-ole-db-provider-for-sql-server) (SQLOLEDB) is no longer maintained and isn't recommended for new development, so use it only to reproduce how an existing application connects.

To test the connection by using the Microsoft OLE DB driver or provider for SQL Server, follow these steps:

1. Open the UDL file.

1. Select the **Provider** tab, select the OLE DB driver or provider that you use in your application, and then select **Next**.

1. On the **Connection** tab, specify the network protocol, the fully qualified domain name (FQDN), and the port number under **Select or enter a server name**. For example, `tcp:SQLProd01.contoso.com,1433`.

    > [!NOTE]
    > This way of entering the server name and port avoids common issues (such as the SQL Server Browser service issues) that could interfere with a connection.

1. Enter other properties on the **Connection** tab.

    > [!NOTE]
    > Most connection tests don't require you to enter a database name.

1. Select **Test Connection**.

You can also select other tabs and explore other driver settings. When the connection test finishes, select **OK** to save the connection string to the UDL file.

> [!NOTE]
> If a test with Microsoft OLE DB Driver 19 for SQL Server fails with a certificate or encryption error, verify that the **Connection encryption** and **Trust Server Certificate** advanced properties support and match the SQL Server encryption configuration. The recommended configuration is to install a certificate on the server that the client can verify. Select **Trust Server Certificate** only as a temporary diagnostic step. For more information, see [Encryption and certificate validation in OLE DB Driver for SQL Server](/sql/connect/oledb/features/encryption-and-certificate-validation).

## Test a connection by using Microsoft OLE DB Provider for ODBC Drivers

Use this procedure to test an Open Database Connectivity (ODBC) driver through Microsoft OLE DB Provider for ODBC Drivers. To run the test, follow these steps:

1. Open the UDL file.

1. Select **Provider** > **Microsoft OLE DB Provider for ODBC Drivers** > **Next**.

1. On the **Connection** tab, use one of the following methods to specify the data source, and then enter other properties:

   - Enter a value in the **Use data source name** field.

   - Alternatively, in the `Use connection string` property, enter a DSN-less connection string like `Driver={ODBC Driver 18 for SQL Server};Server=(local);Database=tempdb;Trusted_Connection=Yes;Encrypt=Optional`.

1. Select **Test Connection**.

> [!NOTE]
> ODBC Driver 18 for SQL Server encrypts connections by default. If the test fails with a certificate error, ensure the server has a certificate that the client can verify. For more information, see [Connection encryption troubleshooting in the ODBC driver](/sql/connect/odbc/connection-troubleshooting#certificate-chain-errors).

## Test 32-bit providers on 64-bit Windows

Use this procedure to test a 32-bit OLE DB provider on a 64-bit operating system. To run the test, follow these steps:

1. In the **Command Prompt** window, run the following command to open the 32-bit **Command Prompt**:

    ```console
    %windir%\SysWoW64\cmd.exe
    ```

1. Run the following command to open the UDL file:

    ```console
    C:\temp\sqlconn.udl
    ```

1. Check the **Provider** tab. If **Microsoft Jet 4.0 OLE DB Provider** is listed, you loaded the 32-bit dialog. You can now select the 32-bit provider to test the connection.

## Launch a UDL file

Double-click a UDL file to launch it. This section describes the underlying process that Windows uses to launch a UDL file.

The UDL file UI is provided by _OLEDB32.DLL_ and hosted in _RUNDLL32.EXE_. Use one of the following commands, depending on your operating system and provider. The examples assume the UDL file is `C:\temp\sqlconn.udl`.

- For 32-bit operating systems or for 64-bit providers on 64-bit operating systems:

  `Rundll32.exe "C:\Program Files\Common Files\System\OLE DB\oledb32.dll",OpenDSLFile C:\temp\sqlconn.udl`

- For 32-bit providers on 64-bit operating systems:

  `C:\Windows\SysWOW64\Rundll32.exe "C:\Program Files (x86)\Common Files\system\Ole DB\oledb32.dll",OpenDSLFile C:\temp\sqlconn.udl`
  
    > [!NOTE]
    > To ensure a successful run, don't wrap the path to the UDL file `C:\temp\sqlconn.udl` in quotes.

To test 32-bit providers on a 64-bit operating system, you can open a 32-bit command prompt and run `C:\TEMP\SQLCONN.UDL`.

1. Select **Start** -> **Run**.
2. Enter `%windir%\SysWOW64\cmd.exe` and select **OK**.
3. Run `C:\TEMP\SQLCONN.UDL`.

Optionally, you can create a [file extension mapping](#create-a-32-bit-udl32-file-extension-mapping) that uses the 32-bit command.

### Create a 32-bit UDL32 file extension mapping

If you frequently use 32-bit providers on a 64-bit operating system, you can map a new file extension (for example, _.udl32_) to launch the 32-bit UDL dialog. Use the following steps.

[!INCLUDE [registry-important-alert](../../../../includes/registry-important-alert.md)]

1. Copy the following script to Notepad and save it as _udl32.reg_.

   ```output
   Windows Registry Editor Version 5.00
   
   [HKEY_CLASSES_ROOT\.UDL32]
   @="ft000001"
   
   [HKEY_CLASSES_ROOT\ft000001]
   @="Microsoft Data Link 32"
   "BrowserFlags"=dword:00000008
   "EditFlags"=dword:00000000
   
   [HKEY_CLASSES_ROOT\ft000001\shell]
   @="open"
   
   [HKEY_CLASSES_ROOT\ft000001\shell\open]
   
   [HKEY_CLASSES_ROOT\ft000001\shell\open\command]
   @="C:\\Windows\\SysWOW64\\Rundll32.exe \"C:\\Program Files (x86)\\Common Files\\system\\Ole DB\\oledb32.dll\",OpenDSLFile %1"
   
   [HKEY_CLASSES_ROOT\ft000001\shell\open\ddeexec]
   ```

1. Double-click the _.reg_ file to create a registry key, which helps you automatically launch UDL32 files.
1. Create a file with the _.udl32_ file extension. For example, _C:\temp\test.udl32_.
1. Double-click the _test.udl32_ to launch the 32-bit UDL dialog. For example, you might see a dialog like this:

   :::image type="content" source="media/test-oledb-connectivity-use-udl-file/32-bit-udl-dialog.png" alt-text="Screenshot shows an example of a 32-bit UDL dialog.":::

## Troubleshoot connection test failures

If a UDL connection test fails, use the following methods to find out why. Try each method separately and compare the results.

- Change the provider.
- Change the protocol. For example, `tcp:`, `np:`, or `lpc:`.
- Test the connection with or without the full domain suffix, or with just the IP address.
- Remove the port number and use the instance name to test the SQL Server Browser service.

If one combination works and another fails, the difference can give you a clue about the problem. For example, if `lpc:` works but `tcp:` doesn't, enable the TCP protocol in [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager).

If this article doesn't resolve your issue, see [Troubleshoot connectivity issues in SQL Server](../connect/resolve-connectivity-errors-overview.md#categories-of-sql-server-connectivity-errors) for more help.

## Related content

- [Universal Data Link (UDL) configuration](/sql/connect/oledb/help-topics/data-link-pages)
- [Using connection string keywords with OLE DB Driver for SQL Server](/sql/connect/oledb/applications/using-connection-string-keywords-with-oledb-driver-for-sql-server)
- [A network-related or instance-specific error occurred while establishing a connection to SQL Server](../connect/network-related-or-instance-specific-error-occurred-while-establishing-connection.md)
