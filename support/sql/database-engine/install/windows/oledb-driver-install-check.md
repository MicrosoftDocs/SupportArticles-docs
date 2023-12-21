---
title: OLE DB Driver Install Checking
description: 
ms.date: 12/13/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer:
---
OLE DB Driver Install Checking
In this article
  About UDL Files
  32-Bit .UDL32 File Extension Mapping
  Validating an OLE DB Provider
  Support for 3rd-Party Providers

OLE DB (Object Linking and Embedding Database) is a Microsoft data access technology used to connect applications to various data sources using OLE DB providers. Troubleshooting OLE DB driver installations and validations can be complex but crucial for seamless database interactions. One of the simplest ways to test an OLE DB provider is via the UDL (Universal Data Link) file. This troubleshooting guide aims to provide insights into the installation, validation, and resolution of issues related to OLE DB drivers.

About UDL Files
The simplest way to test an OLE DB Provider is via the UDL file. Create any text file in Windows Explorer and rename to have a .UDL file extension. Make sure you have file extensions turned on to make the change.

Double-click the file and a dialog will open where you can see the installed Providers and test their connection.

:::image type="content" source="media/oledb-driver-install-check/Picture1.png" alt-text=".":::

Hint: If you click OK on the dialog, you can open the UDL file in Notepad to see a connection string you can use in your application.

[oledb]
; Everything after this line is an OLE DB initstring
Provider=SQLNCLI11.1;Integrated Security="";Persist Security Info=False;User ID=sa;Initial Catalog=northwind;Data Source=tcp:SQLProd01.contoso.com,1433;Initial File Name="";Server SPN=""

The UDL file UI is provided by OLEDB32.DLL and hosted in RUNDLL32.DLL. The command for this is rather lengthy:

Rundll32.exe "C:\Program Files\Common Files\System\OLE DB\oledb32.dll",OpenDSLFile C:\test.udl
or
C:\Windows\SysWOW64\Rundll32.exe C:\PROGRA~2\COMMON~1\System\OLEDB~1\oledb32.dll,OpenDSLFile C:\test.udl32

The first command is for 32-bit systems or 64-bit Providers on 64-bit systems.
The second command is for 32-bit Providers on 64-bit systems.

The .UDL file extension is mapped to the first command. For the second, you can simplify things by running the 32-bit command prompt and then START C:\TEMP\TEST.UDL to test 32-bit Providers.
Even simpler is to map the .UDL32 file extension to the 32-bit command.

32-Bit .UDL32 File Extension Mapping

If you use 32-bit providers a lot, you can map the file extension .UDL32 to launch the 32-bit UDL dialog.
Copy the script to Notepad and save as udl32.reg.

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
@="C:\\Windows\\SysWOW64\\Rundll32.exe C:\\PROGRA~2\\COMMON~1\\System\\OLEDB~1\\oledb32.dll,OpenDSLFile %1"

[HKEY_CLASSES_ROOT\ft000001\shell\open\ddeexec]

Double-click the .REG file and then you can create a file with a .udl32 file extension, e.g. test.udl32, and it will launch the 32-bit UDL dialog.

:::image type="content" source="media/oledb-driver-install-check/Picture2.png" alt-text=".":::
Validating an OLE DB Provider

The first step for validating a Provider is to see whether the name appears in the list of installed Providers of a 64-bit or 32-bit UDL dialog as shown above. If it doesn't, then you need to reinstall the Provider or consult the vendor.

You can also trace the driver location in the registry. The driver name is a COM PROGNAME and you look it up in HKEY_CLASSES_ROOT.

In the following image, you can see the mapping between the PROGID SQLNCLI11.1 and the Provider Name SQL Server Native Client 11.0.

:::image type="content" source="media/oledb-driver-install-check/Picture3.png" alt-text=".":::

The PROGID of both 32-bit and 64-bit Providers appears under this key.

You will also note that in addition to SQLNCLI11.1, there is also a PROGID called SQLNCLI11. The reason for this is that a Provider developer may allow for multiple versions of the same provider to be installed side-by-side, each with a different numeric suffix. The unnumbered name is the version independent PROGID. Applications can point to this and get redirected to the latest version of the provider.

For all intents and purposes, these two different PROGID names should be equivalent. However, there have been a small number of cases where they were not. Applications using the version-independent name failed to connect, but if using the versioned PROGID were able to connect. The reason is that the two entries pointed to different CLSID values, which is how we find the provider DLL.

:::image type="content" source="media/oledb-driver-install-check/Picture4.png" alt-text=".":::

The CLSID is the COM GUID. The COM infrastructure locates the GUID from the PROGID. It then looks under HKEY_CLASSES_ROOT\CLSID key for a key with the matching GUID for the key name:

:::image type="content" source="media/oledb-driver-install-check/Picture5.png" alt-text=".":::

The InProcServer32 value points to the Provider DLL.

For 32-bit Providers, COM uses the same GUID, but looks for it under HKEY_CLASSES_ROOT\Wow6432Node\CLSID.

:::image type="content" source="media/oledb-driver-install-check/Picture6.png" alt-text=".":::

In this case the provider is located in the SysWow64 folder.

Note: These examples are from 64-bit machines. On 32-bit machines, there is no Wow6432Node in the registry.

These are the paths for SQL Native Client 11.0 in REGEDIT for 64-bit machines:

HKEY_CLASSES_ROOT\SQLNCLI.1\CLSID
HKEY_CLASSES_ROOT\CLSID\{guid}\InProcServer32
HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{guid}\InProcServer32

These are the paths in REGEDIT for 32-bit machines:

HKEY_CLASSES_ROOT\SQLNCLI.1\CLSID
HKEY_CLASSES_ROOT\CLSID\{guid}\InProcServer32

Support for 3rd-Party Providers
As with ODBC drivers, support for 3rd-party Providers is limited to validating the PROGID points to a valid CLSID and that the InProcServer32 sub key points to the right DLL. If the path is incorrect or the registry entry does not exist, reinstall the Provider or contact the vendor. If the files exist but the registry entries do not, you can manually register the Provider using REGSVR32. To register a COM DLL, type the following command at an Administrator command prompt:

:::image type="content" source="media/oledb-driver-install-check/Picture7.png" alt-text=".":::

If there are both 32-bit and 64-bit versions of the Provider, run the command against both DLLs. Use a 32-bit command prompt to register the 32-bit DLL.

See also