---
title: Troubleshoot Microsoft Entra Connect upgrade issues
description: Troubleshoot why you can't upgrade to the latest version of Microsoft Entra Connect on a server that has previous installations of Connect, AD Sync, or DirSync.
ms.date: 12/15/2021
author: nualex
ms.author: nualex
ms.reviewer: DennisLee-DennisLee
ms.service: active-directory
ms.subservice: hybrid
#Customer intent: As a Microsoft Entra administrator, I want to successfully upgrade to the latest version of Microsoft Entra Connect so that each Active Directory user can use a single identity in hybrid environments.
---
# Troubleshoot Microsoft Entra Connect upgrade issues

This article describes how to troubleshoot problems that can occur when you upgrade to the latest version of Microsoft Entra Connect from previous installations of Microsoft Entra Connect, Azure AD Sync, or DirSync.

> [!WARNING]
> You might find some online documentation that includes steps to directly edit the Windows registry. However, editing the registry can cause serious problems if you modify the registry incorrectly. The Microsoft Entra Connect product team **doesn't support** editing the Windows registry.

*Original product version:* Microsoft Entra ID  
*Original KB number:* 4051210  

## Symptoms

Every time that you start the Microsoft Entra Connect setup wizard, the program evaluates all the related products and Windows Installer packages (.msi) that are currently installed. To trace this activity, follow these steps:

1. Start the Microsoft Entra Connect wizard, and wait for the first page to open.

2. Open the `%ProgramData%\AADConnect\` folder, and analyze the latest installation trace log.

3. Locate the entries for `GetInstalledPackagesByUpgradeCode`, where the wizard evaluates all the related Windows Installer packages that are installed in Windows. For example:

   ```output
   [10:44:23.095] [ 1] [INFO ] Performing direct lookup of upgrade codes for: Azure AD Sync Engine
   [10:44:23.095] [ 1] [VERB ] Getting list of installed packages by upgrade code
   [10:44:23.095] [ 1] [INFO ] GetInstalledPackagesByUpgradeCode {545334d7-13cd-4bab-8da1-2775fa8cf7c2}: verified product code {7c4397b7-9008-4c23-8cda-3b3b8faf4312}.
   [10:44:23.095] [ 1] [INFO ] GetInstalledPackagesByUpgradeCode {dc9e604e-37b0-4efc-b429-21721cf49d0d}: no registered products found.
   [10:44:23.095] [ 1] [INFO ] GetInstalledPackagesByUpgradeCode {bef7e7d9-2ac2-44b9-abfc-3335222b92a7}: no registered products found.
   ```

You can find two similar symptoms near this part of the trace log:

<details>
<summary>Product was uninstalled but an inconsistent product code is still present in Windows</summary>
The wizard is detecting an old installation of the sync engine: "Product Azure AD Sync Engine (version 1.1.343.0) is installed, needs to be upgraded to version 1.1.380.0."

```output
[10:44:23.095] [ 1] [VERB ] Package=Microsoft Azure AD Connect synchronization services, Version=1.1.343.0, ProductCode=7c4397b7-9008-4c23-8cda-3b3b8faf4312, UpgradeCode=545334d7-13cd-4bab-8da1-2775fa8cf7c2
[10:44:23.095] [ 1] [INFO ] Determining installation action for Azure AD Sync Engine (545334d7-13cd-4bab-8da1-2775fa8cf7c2)
[10:44:23.298] [ 1] [VERB ] Check product code installed: {4e67cad2-d71b-4f06-a7ae-bb49c566bb93}
[10:44:23.298] [ 1] [INFO ] GetProductInfoProperty({4e67cad2-d71b-4f06-a7ae-bb49c566bb93}, VersionString): unknown product
[10:44:23.298] [ 1] [INFO ] AzureADSyncEngineComponent: Product Azure AD Sync Engine (version 1.1.343.0) is installed, needs to be upgraded to version 1.1.380.0.
```

However, the Windows Installer information might be inconsistent after this product is uninstalled and the sync engine is no longer present.

Because the setup wizard is still detecting an old product code, it decides to upgrade Azure AD Sync Engine instead of doing a clean installation. Later in the upgrade process, while the installer is checking for the current service status, the installation fails because the ADSync service isn't present:

```output
[10:44:28.260] [ 1] [INFO ] ServiceControllerProvider: verifying ADSync is in state (Running)
[10:44:28.291] [ 1] [ERROR] Caught an exception while creating the initial page set on the root page.
Exception Data (Raw): System.InvalidOperationException: Service ADSync was not found on computer '.'. ---> System.ComponentModel.Win32Exception: The specified service does not exist as an installed service
```

</details>

<details>
<summary>Product was uninstalled but a stale product code is still present in Windows</summary>

A stale product code that you find in Windows Installer packages can also cause upgrade issues.

```output
[15:29:06.958] [ 1] [INFO ] Performing direct lookup of upgrade codes for: Azure AD Sync Engine
[15:29:06.959] [ 1] [VERB ] Getting list of installed packages by upgrade code
[15:29:06.959] [ 1] [INFO ] GetProductInfoProperty({7c4397b7-9008-4c23-8cda-3b3b8faf4312}, VersionString): unrecognized error (1608)
[15:29:06.959] [ 1] [INFO ] GetInstalledPackagesByUpgradeCode {545334d7-13cd-4bab-8da1-2775fa8cf7c2}: stale product code {7c4397b7-9008-4c23-8cda-3b3b8faf4312}.
[15:29:06.959] [ 1] [INFO ] GetInstalledPackagesByUpgradeCode {545334d7-13cd-4bab-8da1-2775fa8cf7c2}: no registered products found.
[15:29:06.959] [ 1] [INFO ] GetInstalledPackagesByUpgradeCode {dc9e604e-37b0-4efc-b429-21721cf49d0d}: no registered products found.
[15:29:06.959] [ 1] [INFO ] GetInstalledPackagesByUpgradeCode {bef7e7d9-2ac2-44b9-abfc-3335222b92a7}: no registered products found.
[15:29:06.963] [ 1] [INFO ] Determining installation action for Azure AD Sync Engine (545334d7-13cd-4bab-8da1-2775fa8cf7c2)
[15:29:07.059] [ 1] [INFO ] Product Azure AD Sync Engine is not installed.
```

Microsoft Entra Connect Setup wizard can't detect that an Azure AD Sync Engine is installed. Setup fails and returns the following error message:

```output
[15:52:17.674] [ 13] [ERROR] PerformConfigurationPageViewModel: Caught exception while installing synchronization service.
Exception Data (Raw): System.Exception: Unable to install the Synchronization Service. Please see the event log for additional details. ---> Microsoft.Azure.ActiveDirectory.Client.Framework.ProcessExecutionFailedException: Error installing msi package 'Synchronization Service.msi'. Full log is available at 'C:\ProgramData\AADConnect\Synchronization Service_Install-20170525-155217.log'.
...
MSI (s) (C0!08) [15:52:17:605]: Product: Microsoft Azure AD Connect synchronization services -- Error 25019.The Microsoft Azure AD Connect synchronization services setup wizard cannot open registry key SYSTEM\CurrentControlSet\Services\ADSync\Parameters. Try verifying the key and running this wizard again. The system cannot find the file specified.
CustomAction DetectStoreServer returned actual error code 1603 (note this may not be 100% accurate if translation happened inside sandbox)
Action ended 15:52:17: DetectStoreServer.
---> Microsoft.Azure.ActiveDirectory.Client.Framework.ProcessExecutionFailedException: Exception: Execution failed with errorCode: 1603.
```

This error occurs because the MSIEXEC process still tries to upgrade the Azure AD Sync Engine, as shown in the *Synchronization Service_Install-20170525-155217.log* file:

```output
MSI (s) (C0:0C) [15:52:17:386]: PROPERTY CHANGE: Adding WIX_UPGRADE_DETECTED property. Its value is '{7C4397B7-9008-4C23-8CDA-3B3B8FAF4312}'.
MSI (s) (C0:0C) [15:52:17:386]: PROPERTY CHANGE: Adding MIGRATE property. Its value is '{7C4397B7-9008-4C23-8CDA-3B3B8FAF4312}'.
...
MSI (s) (C0:D4) [15:52:17:598]: Invoking remote custom action. DLL: C:\Windows\Installer\MSI1D9A.tmp, Entrypoint: DetectStoreServer
Action start 15:52:17: DetectStoreServer.
MSI (s) (C0!08) [15:52:17:605]: Product: Microsoft Azure AD Connect synchronization services -- Error 25019.The Microsoft Azure AD Connect synchronization services setup wizard cannot open registry key SYSTEM\CurrentControlSet\Services\ADSync\Parameters. Try verifying the key and running this wizard again. The system cannot find the file specified.
```

As in the previous case, the Windows Installer upgrading process fails because the ADSync service entries in the registry aren't present. The product has been previously uninstalled, leaving the Windows Installer database inconsistent.
</details>

## Solution

You can clean up the inconsistency on the Windows Installer database for the Azure AD Sync Engine product code that's identified in the trace log. (The product code can vary. For the previous examples, the problematic product code is 7c4397b7-9008-4c23-8cda-3b3b8faf4312.)

After you identify the problematic product code from the trace log, use the following methods, as appropriate.

<details>
<summary>Fix Windows Installer issues (if applicable)</summary>
The KB3139923 Windows hotfix can cause these Windows Installer issues. Therefore, we recommend that you uninstall it.

To check whether KB3139923 is installed, go to **Settings** > **Windows Update** > **Update history**. Or use PowerShell to export a list of all installed hotfixes:

```powershell
Get-Hotfix |
Select-Object HotFixID, InstalledOn, Description, InstalledBy |
Sort-Object –Property InstalledOn –Descending |
Out-File –FilePath ".\$env:COMPUTERNAME-HotFixes.txt"
```

1. If the KB3139923 hotfix is present, uninstall it, and then restart the server.

1. Download and install the [KB3072630 Windows hotfix](https://www.microsoft.com/download/details.aspx?id=47955), and then restart again.

</details>

<details>
<summary>Use the Windows Installer command-line tool to uninstall product code</summary>

To uninstall the product code for the Azure AD Sync Engine, run the Windows Installer command-line tool ([MsiExec.exe](/windows-server/administration/windows-commands/msiexec)) as follows:

1. Identify the inconsistent or stale product code from the trace log (GUID), as shown in the "Symptoms" section.

1. Open an administrative Command Prompt window.

1. Enter the following line by susbtituting the actual GUID of the problematic product code:

    ```cmd
    SET productcode={<12345678-0000-abcd-0000-0123456789ab>}
    ```

1. Enter the following command, repeat the command, and then restart the server.

    > [!NOTE]
    > You might see numerous reported errors because of the corrupted Windows Installer database. For any dialog box that appears, select **Yes**.

    ```cmd
    SET /a counter+=1
    & MSIEXEC /x %productcode% /qn /norestart /l*v "%ProgramData%\AADConnect\AADConnect_Uninstall-ForcedUninstall_%counter%.log" EXECUTE_UNINSTALL="1"
    ```

1. Start the Microsoft Entra Connect wizard, and wait for the first page to open.

1. Open the `%ProgramData%\AADConnect\` folder, and analyze the latest installation trace log.

1. If the inconsistent or stale product code is no longer present in the log file, continue the wizard, and complete the installation. Otherwise, go to the next solution.

</details>

<details>
<summary>Use Program Install and Uninstall troubleshooter tool</summary>

The Program Install and Uninstall troubleshooter helps you automatically repair issues if you're blocked from installing or removing programs. It also fixes corrupted registry keys.

[Fix problems that block programs from being installed or removed (microsoft.com)](https://support.microsoft.com/en-us/topic/fix-problems-that-block-programs-from-being-installed-or-removed-cca7d1b6-65a9-3d98-426b-e9f927e1eb4d)

After you run the tool, restart the server, and then follow these steps:

1. Start the Microsoft Entra Connect wizard, and wait for the first page to open.

1. Open the `%ProgramData%\AADConnect\` folder, and analyze the latest installation trace log.

1. If the inconsistent or stale product code is no longer present in the log file, continue the wizard, and complete the installation. If the stale product code is present, we recommend that you reinstall the Windows operating system because you can't recover the Windows Installer database from an inconsistent state.

</details>

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
