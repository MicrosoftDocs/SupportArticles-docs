---
title: Signed drivers are displayed as unsigned
description: Fixes an issue in which signed drivers imported into Configuration Manager are listed as unsigned.
ms.date: 12/05/2023
ms.reviewer: kaushika, frankroj
---
# Signed drivers are displayed as unsigned in Configuration Manager

This article provides a solution for the issue that signed drivers are shown as unsigned in Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3025925

## Symptoms

Consider the following scenario:

- An administrator tries to import drivers into Configuration Manager.
- The site server is running Windows Server 2008 R2.
- The drivers are signed.

In this scenario, the drivers may be imported successfully, but they may be displayed as unsigned in the Configuration Manager console. You can see this through either of the following methods:

- Navigate to the **Software Library** > **Operating Systems** > **Drivers** node in the Configuration Manager console. When the **Signed** and **Signed By** columns are added, the **Signed** column for the imported drivers displays **No**, and the **Signed By** column is blank.
- When you inspect the properties of the imported drivers in the **Software Library** > **Operating Systems** > **Drivers** node of the Configuration Manager console, the **Digital signer** field in the **General** tab displays **Unsigned**.

The Configuration Manager logs do not reveal any errors. However, when you view the **Setupapi.app.log** file in the `C:\Windows\inf directory`, you'll see this error:

> \>>> [SetupVerifyInfFile - \\\\<UNC_Path_To_Driver>\\\<Driver>.inf]  
> \>>> Section start \<Date> \<Time>  
> cmd: C:\Windows\system32\wbem\wmiprvse.exe -Embedding  
> ! sig: Verifying file against specific (valid) catalog failed! (0x80096002)  
> ! sig: Error 0x80096002: The certificate for the signer of the message is invalid or not found.  
> ! sig: Verifying file against specific Authenticode(tm) catalog failed! (0x800b0100)  
> ! sig: Error 0x800b0100: No signature was present in the subject.  
> <<< Section end \<Date> \<Time>  
> <<< [Exit status: FAILURE(0x800b0100)]

## Cause

Some drivers are signed by a newer signing method that is not recognized or natively supported by Windows Server 2008 R2. Therefore, these drivers cannot be imported into Configuration Manager if the site server is running Windows Server 2008 R2.

## Resolution

To resolve the problem, install one or both of the following updates on the site server that's experiencing the problem:

- [KB 2837108 You cannot import a Windows 8 signed driver on a Windows Server 2008 R2-based WDS server](https://support.microsoft.com/help/2837108)
- [KB 2921916 The "Untrusted publisher" dialog box appears when you install a driver in Windows 7 or Windows Server 2008 R2](https://support.microsoft.com/help/2921916)

> [!NOTE]
>
> - Hotfix 2837108 will resolve the issue even if WDS is not installed on the site server.
> - These hotfixes will add the necessary support to Windows Server 2008 R2 to natively recognize the newer signing methods.

To fully fix the problem, restart the site server after you install KB 2837108 or KB 2921916 even if the installation process does not prompt you to restart.

After you install KB 2837108 or KB 2921916 and then restart the server, any affected driver that's already in the Configuration Manager console will have to be removed and then reimported.

## More information

Surface Pro 3 drivers are an example of drivers that exhibit this problem. Because Surface Pro 3 drivers are signed by the newer signing method, they are affected by this issue. You may be able to import them into Configuration Manager when the site server is running Windows Server 2008 R2, but they will be displayed as unsigned until either KB 2837108 or KB 2921916 is installed on the site server.

If you cannot import the drivers at all, see [Can't import drivers into Configuration Manager](fail-to-import-drivers.md).
