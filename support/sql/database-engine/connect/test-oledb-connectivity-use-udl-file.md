---
title: Test OLE DB connectivity to SQL Server by using a UDL file
description: Describes how to create a UDL file and use it to test OLE DB connectivity to SQL Server.
ms.date: 07/01/2025
ms.custom: sap:Database Connectivity and Authentication
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: jopilov
---

# Test OLE DB connectivity to SQL Server by using a UDL file

_Applies to:_ &nbsp; SQL Server

> [!NOTE]
> Before you start troubleshooting, check the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and go through the checklist.

This article describes how to create a Universal Data Link (UDL) file and use different providers to test the connection to a SQL Server instance through the file.

## Create a UDL file

> [!NOTE]
> A UDL file enables you to test Object Linking and Embedding Database (OLE DB) providers connectivity to any backend database independent of a full application. Saving a UDL file generates a well-formed connection string, which you can use to help build an application's connection string or check how to set different properties. To get the string, open the file in Notepad.

To create a UDL file to test your OLE DB provider, follow these steps:

1. To show file extensions in File Explorer, follow these steps:

    1. Select **Start**, and enter *File Explorer Options*.

    1. Select the **View** tab, uncheck the **Hide extensions for known file types** option, and then select **OK**.

1. Navigate to the folder where you want to create a UDL file. For example, *c:\\temp*.

1. Create a new text file (such as *sqlconn.txt*), and then rename the extension from *.txt* to *.udl*. (Select **Yes** to the warning message about changing the file name extension.)

    You can also use the following PowerShell script to create *sqlconn.udl* in your *%temp%* folder.

      ```Powershell
      clear
      $ServerName = "(local)"
      $UDL_String = "[oledb]`r`n; Everything after this line is an OLE DB initstring`r`nProvider=MSOLEDBSQL.1;Integrated Security=SSPI;Persist Security Info=False;User ID=`"`";Initial Catalog=`"`";Data Source=" + $ServerName + ";Initial File Name=`"`";Server SPN=`"`";Authentication=`"`";Access Token=`"`""
      Set-Content -Path ($env:temp + "\sqlconn.udl") -Value $UDL_String -Encoding Unicode
      
      #open the UDL
      Invoke-Expression ($env:temp + "\sqlconn.udl")
      ```

## Test the connection by using the SQL Server OLE DB provider

[Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/oledb-driver-for-sql-server#3-microsoft-ole-db-driver-for-sql-server-msoledbsql) (MSOLEDBSQL) is the latest SQL Server OLE DB provider. The provider has all the new features, such as TLS 1.2 and 1.3, [MultiSubnetFailover](/dotnet/api/system.data.sqlclient.sqlconnectionstringbuilder.multisubnetfailover), and Azure authentication options (Microsoft Entra ID). We recommend this provider for newer SQL Server databases.


[Microsoft OLE DB Provider for SQL Server](/sql/connect/oledb/oledb-driver-for-sql-server) (SQLOLEDB) is the legacy OLE DB connectivity provider. It's built into Windows and can connect to any version of SQL Server that's not configured to require TLS 1.2/1.3 channel bindings.

To test the connection by using the Microsoft OLE DB driver for SQL Server, follow these steps:

1. Open the *.udl* file.

1. Select the **Provider** tab, select the OLE DB driver or provider that you use in your application, and then select **Next**.

1. On the **Connection** tab, specify the network protocol, the fully qualified domain name (FQDN), and the port number under **Select or enter a server name**. For example, `tcp:SQLProd01.contoso.com,1433`.

    > [!NOTE]
    > This way of entering the server name and port avoids common issues (such as the SQL Server Browser service issues) that could interfere with a connection.

1. Enter other properties on the **Connection** tab. Most connection tests don't require you to enter a database name.

1. Select **Test Connection**.

You can also select other tabs and explore other driver settings. When the connection test finishes, select **OK** to save the connection string to a file.

## Test connection by using Microsoft OLE DB Provider for ODBC Drivers

To test Open Database Connectivity (ODBC) drivers by using Microsoft OLE DB Provider for ODBC Drivers, follow these steps:

1. Open the *.udl* file.

1. Select **Provider** > **Microsoft OLE DB Provider for ODBC Drivers** > **Next**.

1. On the **Connection** tab, you can use one of the following methods to specify the source of data, and then enter other properties.

   - Enter a value in the **Use data source name** field.

   - Enter a DSN-less connection string like `Driver={ODBC Driver 17 for SQL Server};Server=SQLProd01;Database=Northwind;Trusted_Connection=Yes`.

1. Select **Test Connection**.

## Test 32-bit providers on 64-bit machines

To test the connection of 32-bit providers in 64-bit operating systems, follow these steps:

1. In the **Command Prompt** window, run the following command to open the 32-bit **Command Prompt**:

    ```console
    %windir%\SysWoW64\cmd.exe
    ```

1. Run the following command to open the UDL file:

    ```console
    c:\temp\test.udl
    ```

1. If you see **Microsoft Jet 4.0 OLE DB Provider** on the **Provider** tab that means you successfully loaded the 32-bit dialog and can now select the 32-bit provider to test the connection.

### How to launch a UDL file

The simplest way to use an UDL is to double-click it. But if you need to understand the internals of how it works, review the following information. 

The UDL file UI is provided by *OLEDB32.DLL* and hosted in *RUNDLL32.EXE*.

- For 32-bit systems or for 64-bit providers on 64-bit systems, use the following command (assuming c:\temp\test.udl):

  `Rundll32.exe "C:\Program Files\Common Files\System\OLE DB\oledb32.dll",OpenDSLFile C:\temp\test.udl`

- For 32-bit providers on 64-bit systems, use the following command:

  `C:\Windows\SysWOW64\Rundll32.exe "C:\Program Files (x86)\Common Files\system\Ole DB\oledb32.dll",OpenDSLFile c:\temp\test.udl`

The *.UDL* file extension is mapped to the first command. For the second, you can simplify things by running a 32-bit command prompt and then running `START C:\TEMP\TEST.UDL` to test 32-bit providers. Another way is to map the *.UDL32* file extension to the 32-bit command.

#### A 32-bit .udl32 file extension mapping

If you frequently use 32-bit providers, you can map a new file extension, for example *.udl32*, to launch the 32-bit UDL dialog. Follow these steps:

[!INCLUDE [registry-important-alert](../../../../includes/registry-important-alert.md)]

1. Copy the following script to Notepad and save it as *udl32.reg*.

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
   @="C:\\\\Windows\\\\SysWOW64\\\\Rundll32.exe \"C:\\\\Program Files (x86)\\\\Common Files\\\\system\\\\Ole DB\\\\oledb32.dll\",OpenDSLFile %1"
   
   [HKEY_CLASSES_ROOT\ft000001\shell\open\ddeexec]
   ```

1. Double-click the *.reg* file to create a registry key, which helps you automatically launch UDL32 files
1. Then create a file with a *.udl32* file extension. For example, *c:\temp\test.udl32*. 
1. Double-click the *test.udl32* to launch the 32-bit UDL dialog. For example, you might see a dialog like this:

   :::image type="content" source="media/oledb-driver-install-check/32-bit-udl-dialog.png" alt-text="Screenshot shows an example of a 32-bit UDL dialog.":::


## Tips to troubleshoot connection issues

You can use the following methods to check why the connection fails.

- Change the provider.
- Change the protocol. For example, `tcp:`, `np:`, or `lpc:`.
- Test the connection with or without the full domain suffix or with just the IP address.
- Remove the port number and use the instance name to test the SQL Server Browser service.

For each of the above methods, if one combination works and another fails, it could give a clue as to the problem. For example, when you use the second method, if the `lpc:` works and the `tcp:` doesn't, try to enable the TCP protocol in [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager).

## See also

[Universal Data Link (UDL) configuration](/sql/connect/oledb/help-topics/data-link-pages)

> [!NOTE]
> If this article doesn't resolve your issue, you can check [Troubleshoot connectivity issues in SQL Server](../connect/resolve-connectivity-errors-overview.md#common-connectivity-issues) for more help.
