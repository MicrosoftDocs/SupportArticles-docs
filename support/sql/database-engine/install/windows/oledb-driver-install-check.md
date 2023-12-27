---
title: OLE DB driver installation check
description: Provides insights into the installation, validation, and resolution of issues related to OLE DB drivers.
ms.date: 12/18/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: mastewa, jopilov, prmadhes, v-sidong
---
# OLE DB driver installation check

Object Linking and Embedding Database (OLE DB) is a Microsoft data access technology used to connect applications to various data sources using OLE DB providers. Troubleshooting OLE DB driver installations and validations can be complex, but is crucial for seamless database interaction. This troubleshooting guide aims to provide insights into the installation, validation, and resolution of issues related to OLE DB drivers.

## About UDL files

One of the simplest ways to test an OLE DB provider is via the Universal Data Link (UDL) file. Create any text file in Windows Explorer and rename it to have a *.UDL* file extension. Make sure you have file extensions turned on to make the change. For more information, see [Test OLE DB connectivity to SQL Server by using a UDL file](../../connect/test-oledb-connectivity-use-udl-file.md)

Double-click the file to open a dialog where you can see the installed providers and test their connections.

:::image type="content" source="media/oledb-driver-install-check/udl-test-oledb-provider.png" alt-text="Screenshot shows how to use UDL file to test OLE DB provider.":::

> [!NOTE]
> If you select **OK** in the dialog, you can open the UDL file in Notepad to see the connection string you can use in your application. For example:
>
> ```output
> Provider=SQLNCLI11.1;Integrated Security="";Persist Security Info=False;User ID=sa;Initial Catalog=northwind;Data Source=tcp:SQLProd01.contoso.com,1433;Initial File Name="";Server SPN=""
> ```

The UDL file UI is provided by *OLEDB32.DLL* and hosted in *RUNDLL32.DLL*.

- For 32-bit systems or for 64-bit providers on 64-bit systems, use the following command:

  `Rundll32.exe "C:\Program Files\Common Files\System\OLE DB\oledb32.dll",OpenDSLFile C:\test.udl`

- For 32-bit providers on 64-bit systems, use the following command:

  `C:\Windows\SysWOW64\Rundll32.exe C:\PROGRA~2\COMMON~1\System\OLEDB~1\oledb32.dll,OpenDSLFile C:\test.udl32`

The *.UDL* file extension is mapped to the first command. For the second, you can simplify things by running a 32-bit command prompt and then running `START C:\TEMP\TEST.UDL` to test 32-bit providers. Even simpler is to map the *.UDL32* file extension to the 32-bit command.

## 32-bit .udl32 file extension mapping

If you frequently use 32-bit providers, you can map the file extension *.udl32* to launch the 32-bit UDL dialog. Follow these steps:

1. Copy the script to Notepad and save it as *udl32.reg*.

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
    @="C:\\Windows\\SysWOW64\\Rundll32.exe C:\\PROGRA~2\\COMMON~1\\System\\OLEDB~1\\oledb32.dll,OpenDSLFile %1"
     
    [HKEY_CLASSES_ROOT\ft000001\shell\open\ddeexec]
    ```

1. Double-click the *.reg* file and then you can create a file with a *.udl32* file extension. For example, *test.udl32*. And it will launch the 32-bit UDL dialog. For example:

   :::image type="content" source="media/oledb-driver-install-check/32-bit-udl-dialog.png" alt-text="Screenshot shows an example of a 32-bit UDL dialog.":::

## Validate an OLE DB Provider

The first step for validating a provider is to see whether the name appears in the list of installed providers of a 64-bit or 32-bit UDL dialog, as shown above. If it doesn't, you need to reinstall the provider or consult the vendor.

You can also trace the driver location in the registry. The driver name is a COM [ProgID](/windows/win32/com/-progid--key) and you can find it in [HKEY_CLASSES_ROOT](/windows/win32/sysinfo/hkey-classes-root-key).

In the following image, you can see the mapping between the ProgID **SQLNCLI11.1** and the provider name **SQL Server Native Client 11.0**.

:::image type="content" source="media/oledb-driver-install-check/mapping-progid-provider-name.png" alt-text="Screenshot shows the mapping between the ProgID SQLNCLI11.1 and the Provider name SQL Server Native Client 11.0.":::

The ProgID of both 32-bit and 64-bit providers appears under this key.

In addition to **SQLNCLI11.1**, there's also a ProgID called **SQLNCLI11**. The reason for this is that a provider developer might allow multiple versions of the same provider to be installed side by side, each with a different numeric suffix. The unnumbered name is the version-independent ProgID. Applications can point to this and be redirected to the latest version of the provider.

For all intents and purposes, these two different ProgID names should be equivalent. However, there have been a few cases where they weren't. Applications using the version-independent name can't connect, but they can connect if using the versioned ProgID. The reason is that the two entries point to different [CLSID](/windows/win32/com/clsid-key-hklm) values, which is how to find the provider DLL.

:::image type="content" source="media/oledb-driver-install-check/find-provider-dll-versioned-progid.png" alt-text="Screenshot shows how to find the provider dll using the versioned ProgId.":::

The `CLSID` is the COM GUID. The COM infrastructure locates the GUID from the ProgID. It then looks under the `HKEY_CLASSES_ROOT\CLSID` key for a key whose GUID matches the key name:

:::image type="content" source="media/oledb-driver-install-check/locate-guid-progid.png" alt-text="Screenshot shows how to locate a GUID from ProgId under HKEY_CLASSES_ROOT\CLSID.":::

The `InProcServer32` value points to the provider DLL.

For 32-bit providers, COM uses the same GUID but looks for it under `HKEY_CLASSES_ROOT\Wow6432Node\CLSID`.

:::image type="content" source="media/oledb-driver-install-check/provider-folder-syswow64.png" alt-text="Screenshot shows the provider is located in the SysWow64 folder.":::

In this case, the provider is located in the *SysWow64* folder.

> [!NOTE]
> These examples are from 64-bit machines. On 32-bit machines, there's no `Wow6432Node` in the registry.

These are the paths to **SQL Native Client 11.0** in Registry Editor for 64-bit machines:

- `HKEY_CLASSES_ROOT\SQLNCLI.1\CLSID`
- `HKEY_CLASSES_ROOT\CLSID\<guid>\InProcServer32`
- `HKEY_CLASSES_ROOT\Wow6432Node\CLSID\<guid>\InProcServer32`

These are the paths in Registry Editor for 32-bit machines:

- `HKEY_CLASSES_ROOT\SQLNCLI.1\CLSID`
- `HKEY_CLASSES_ROOT\CLSID\{guid}\InProcServer32`

## Support for third-party providers

Support for third-party OLE DB providers is limited to validating the ProgID points to a valid CLSID and that the `InProcServer32` subkey points to the correct DLL. If the path is incorrect or the registry entry doesn't exist, reinstall the provider or contact the vendor. If the files exist but the registry entries don't, you can manually register the provider using `REGSVR32`. To register a COM DLL, run the following command at an elevated command prompt:

```cmd
Regsvr32 sqlncli11
```

:::image type="content" source="media/oledb-driver-install-check/register-com-dll-command.png" alt-text="Screenshot shows an administrator command to register a COM DLL.":::

If there are both 32-bit and 64-bit versions of the provider, run the command against both DLLs. Use a 32-bit command prompt to register the 32-bit DLL.

## More information

- [ODBC driver installation check](odbc-driver-install-checking.md)
- [.NET data provider installation check](net-driver-install-check.md)
- [Driver installation check](driver-install-checking.md)
