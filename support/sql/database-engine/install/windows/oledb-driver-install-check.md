---
title: OLE DB driver installation check
description: Provides insights into the installation, validation, and resolution of issues related to OLE DB drivers.
ms.date: 06/29/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: mastewa, jopilov, prmadhes, v-sidong
---
# OLE DB driver installation check

Object Linking and Embedding Database (OLE DB) is a Microsoft data access technology used to connect applications to various data sources using OLE DB providers. Troubleshooting OLE DB driver installations and validations can be complex, but is crucial for seamless database interaction. This troubleshooting guide aims to provide insights into the installation, validation, and resolution of issues related to OLE DB drivers.

## Validate OLE DB driver or provider via PowerShell

To validate if the latest OLE DB driver for SQL Server is installed on the operating system, run the following PowerShell cmdlet as an administrator.

```PowerShell
Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft", "HKLM:\SOFTWARE\Wow6432Node\Microsoft" |
    Where-Object { $_.Name -like "*MSOLEDBSQL*" } |
    ForEach-Object { Get-ItemProperty $_.PSPath }
```

If you have version 18 and 19 installed on the operating system, The output might look something like this.

```output
InstalledVersion : 18.7.4.0
PSPath           : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSOLEDBSQL
PSParentPath     : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft
PSChildName      : MSOLEDBSQL
PSProvider       : Microsoft.PowerShell.Core\Registry

InstalledVersion : 19.4.1.0
PSPath           : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSOLEDBSQL19
PSParentPath     : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft
PSChildName      : MSOLEDBSQL19
PSProvider       : Microsoft.PowerShell.Core\Registry

InstalledVersion : 18.7.4.0
PSPath           : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\MSOLEDBSQL
PSParentPath     : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft
PSChildName      : MSOLEDBSQL
PSProvider       : Microsoft.PowerShell.Core\Registry

InstalledVersion : 19.4.1.0
PSPath           : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\MSOLEDBSQL19
PSParentPath     : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft
PSChildName      : MSOLEDBSQL19
PSProvider       : Microsoft.PowerShell.Core\Registry
```

To check for an OLE DB provider interface (SQLNCLI) installation, run the following PowerShell cmdlet as an administrator.

```PowerShell
Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft", "HKLM:\SOFTWARE\Wow6432Node\Microsoft" |
   Where-Object { $_.Name -like "*SQLNCLi*" } |
   ForEach-Object {   Get-ItemProperty $_.PSPath}
```

## Validate OLE DB driver via a UDL

One of the easiest ways to test an OLE DB provider is by using a Universal Data Link (UDL) file. Create any text file in Windows Explorer and rename it to have the *.udl* file extension. Make sure you have [file extensions turned on](https://support.microsoft.com/windows/da4a4430-8e76-89c5-59f7-1cdbbc75cb01) to make the change. Double-click the file to open a dialog where you can see the installed providers and test their connections. For more information, see [Test OLE DB connectivity to SQL Server by using a UDL file](../../connect/test-oledb-connectivity-use-udl-file.md).

:::image type="content" source="media/oledb-driver-install-check/udl-test-oledb-provider.png" alt-text="Screenshot shows how to use UDL file to test OLE DB provider.":::

Select **OK** in the dialog to confirm the configuration.

### Examine the UDL file content

If you open the UDL file in a text editor like Notepad, copy the connection string to use in your application. Here are two examples:

```output
Provider=MSOLEDBSQL.1;Integrated Security=SSPI;Persist Security Info=False;User ID="";Initial Catalog=master;Data Source=localhost;Initial File Name="";Server SPN="";Authentication="";Access Token=""
```

```output
Provider=SQLNCLI11.1;Integrated Security="";Persist Security Info=False;User ID=sa;Initial Catalog=AdventureWorks;Data Source=tcp:SQLProd01.contoso.com,1433;Initial File Name="";Server SPN=""
```

### Validate an OLE DB driver

The first step for validating a driver is to see whether the name appears in the list of installed providers of a 64-bit or 32-bit UDL dialog, as shown in the previous section. If it doesn't, you need to reinstall the provider or consult the vendor.

You can also trace the driver location in the registry. The driver name is a COM [ProgID](/windows/win32/com/-progid--key) and you can find it in [HKEY_CLASSES_ROOT](/windows/win32/sysinfo/hkey-classes-root-key).

Let's use the SQL Server Native Client driver to illustrate the details. In the following image, you can see the mapping between the ProgID **SQLNCLI11.1** and the provider name **SQL Server Native Client 11.0**.

:::image type="content" source="media/oledb-driver-install-check/mapping-progid-provider-name.png" alt-text="Screenshot shows the mapping between the ProgID SQLNCLI11.1 and the Provider name SQL Server Native Client 11.0.":::

The ProgID of both 32-bit and 64-bit providers appears under the same key.

In addition to **SQLNCLI11.1**, there's also a ProgID called **SQLNCLI11**. The reason for this is that a provider developer might allow multiple versions of the same provider to be installed side by side, each with a different numeric suffix. The unnumbered name is the version-independent ProgID. Applications can point to this and be redirected to the latest version of the provider.

For all intents and purposes, these two different ProgID names should be equivalent. However, there were a few cases where they weren't. Applications using the version-independent name can't connect, but they can connect if using the versioned ProgID. The reason is that the two entries point to different [CLSID](/windows/win32/com/clsid-key-hklm) values, which is how to find the provider DLL.

:::image type="content" source="media/oledb-driver-install-check/find-provider-dll-versioned-progid.png" alt-text="Screenshot shows how to find the provider dll using the versioned ProgId.":::

The `CLSID` is the COM GUID. The COM infrastructure locates the GUID from the ProgID. It then looks under the `HKEY_CLASSES_ROOT\CLSID` key for a key whose GUID matches the key name:

:::image type="content" source="media/oledb-driver-install-check/locate-guid-progid.png" alt-text="Screenshot shows how to locate a GUID from ProgId under HKEY_CLASSES_ROOT\CLSID.":::

The `InProcServer32` value points to the provider DLL.

For 32-bit providers, COM uses the same GUID but looks for it under `HKEY_CLASSES_ROOT\Wow6432Node\CLSID`.

:::image type="content" source="media/oledb-driver-install-check/provider-folder-syswow64.png" alt-text="Screenshot shows the provider is located in the SysWow64 folder.":::

In this case, the provider is located in the *SysWow64* folder.

> [!NOTE]
> These examples are from 64-bit machines. On 32-bit machines, there's no `Wow6432Node` in the registry.

These registry keys are the paths to **SQL Native Client 11.0** in Registry Editor for 64-bit machines:

- `HKEY_CLASSES_ROOT\SQLNCLI.1\CLSID`
- `HKEY_CLASSES_ROOT\CLSID\<guid>\InProcServer32`
- `HKEY_CLASSES_ROOT\Wow6432Node\CLSID\<guid>\InProcServer32`

These are the paths in Registry Editor for 32-bit machines:

- `HKEY_CLASSES_ROOT\SQLNCLI.1\CLSID`
- `HKEY_CLASSES_ROOT\CLSID\{guid}\InProcServer32`

## Support for non-Microsoft providers

Technical support for non-Microsoft OLE DB providers is limited to validating the ProgID points to a valid CLSID and that the `InProcServer32` subkey points to the correct DLL. If the path is incorrect or the registry entry doesn't exist, reinstall the provider or contact the vendor. If the files exist but the registry entries don't, you can manually register the provider using `REGSVR32`. To register a COM DLL, run the following command at an elevated command prompt:

```cmd
Regsvr32 sqlncli11
```

:::image type="content" source="media/oledb-driver-install-check/register-com-dll-command.png" alt-text="Screenshot shows an administrator command to register a COM DLL.":::

If there are both 32-bit and 64-bit versions of the provider, run the command against both DLLs. Use a 32-bit command prompt to register the 32-bit DLL.

## More information

- [ODBC driver installation check](odbc-driver-install-checking.md)
- [.NET data provider installation check](net-driver-install-check.md)
- [Driver installation check](driver-install-checking.md)
