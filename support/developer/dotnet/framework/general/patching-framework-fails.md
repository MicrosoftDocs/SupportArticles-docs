---
title: Patching of .NET Framework fails
description: .NET Framework patches fail if assemblies are in use or locked. This article provides resolutions for this problem.
ms.date: 05/06/2020
ms.reviewer: kelho
---
# Patching of .NET Framework fails with an error: Access is denied or File in Use

This article helps you resolve the problem where the Microsoft .NET Framework patching failures when assemblies are in use or locked when a patch is applied.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 2263996

## Symptoms

If an assembly file in the Global Access Cache (GAC) has been locked or is in use, it can cause .NET Framework patches to fail. This problem can be exacerbated by a bug in the way fusion handles the rollback and can cause files to be deleted. This will result in managed applications (those applications that depend on framework assemblies) to fail.

The failing patch MSI Verbose log might contain something like this:

> 'C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\system.dll' because of system error:Access is denied.  
> 06/22/10 11:57:26 DDSet_Status: Sleeping 100ms...  
> MSI (s) (54!70) [11:57:26:738]: Product: Microsoft .NET Framework 2.0 Service Pack 2 -- There is a problem with this Windows Installer package.  
> Please refer to the setup log for more information.  
> There is a problem with this Windows Installer package.  
> Please refer to the setup log for more information.  
> 06/22/10 11:57:26 DDSet_CARetVal: 0  
> 06/22/10 11:57:26 DDSet_Exit: InstallAssembly ended with return value 1603  
> MSI (s) (54:94) [11:57:26:758]: User policy value 'DisableRollback' is 0  
> MSI (s) (54:94) [11:57:26:758]: Machine policy value 'DisableRollback' is 0  
> Action ended 11:57:26: InstallExecute. Return value 3.

Or

> 02/22/10 08:38:32 DDSet_Status: Sleeping 100ms...  
> 02/22/10 08:38:32 DDSet_Error: Failed to install assembly  
> C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\System.EnterpriseServices.dll. IAssemblyCache->InstallAssembly() returned -2147024864.  
02/22/10 08:38:32 DDSet_Error: Failed to install assembly  
> 'C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\System.EnterpriseServices.dll' because of system error:  
> The process cannot access the file because it is being used by another process.

## Cause

If assemblies are in use or locked when a patch is applied, the patch will fail.

## Resolution

This problem can be avoided by ensuring processes are not running that can put a lock on the assemblies.

To detect whether assemblies are being used, follow these steps:

1. Download [procexp.exe](https://live.sysinternals.com/procexp.exe) to discover process that are locking assemblies.
2. Launch procexp.exe and then press Ctrl+F to open the **Process Explorer Search** window.
3. In the **Handle or DLL substring** textbox, type *Assembly* and then select **Search**.

    :::image type="content" source="./media/patching-framework-fails/search-assembly.png" alt-text="Screenshot shows steps to search assembly.":::

4. All files listed could have an impact on the installation of the patch. Terminate all the listed processes or close the associated applications. To do this, follow these steps:

    1. Select the process name you want to terminate in the **Process Explorer Search** window to locate the process.
    2. Right click the process name in the **Process** pane.
    3. Select **Kill Process** to terminate the Process.

        :::image type="content" source="./media/patching-framework-fails/kill-process.png" alt-text="Screenshot shows steps to kill a process.":::
