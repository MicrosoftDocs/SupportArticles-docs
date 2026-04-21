---
title: Troubleshoot Windows Installation Error 0x800f0831
description: Learn how to resolve Windows Update installation error 0x800f0831 (CBS E STORE CORRUPTION).
ms.date: 04/22/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: scotro,mwesley,kaushika,v-appelgatet
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
appliesto:
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
---
# Troubleshoot Windows Update installation error 0x800f0831 (CBS_E_STORE_CORRUPTION)

Windows Update error 0x800f0831 (`CBS_E_STORE_CORRUPTION`) typically occurs if an update doesn't install the required package files correctly. This article helps you understand the root cause of the issue and the necessary steps to resolve it effectively.

## Symptoms

When you try to install any update by using the standalone installer (.msu), or you try to install a Windows update, you receive one of the following error messages:

> Some updates were not installed

  :::image type="content" source="media/following-updates-were-not-installed.png" alt-text="Screenshot of the installation error message.":::

> Updates failed

  :::image type="content" source="media/windows-update-failed.png" alt-text="Screenshot of the Windows Update failed error message.":::

> [!NOTE]
> The symptoms might vary depending on each case, but the cause of this issue remains the same.

## Cause

This error can occur for one of the following reasons:

- The update was never installed.
- The update is installed but some packages aren't applied to the registry.

To locate the installation packages in the system, search for the following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages`

To investigate the cause further, examine the CBS.log file (C:\windows\logs\CBS). For more information on how to collect the CBS.log file, see [Fix Windows Update corruptions and installation failures](fix-windows-update-errors.md#logging). Search for output that resembles the following example:

```output
Info CBS Store corruption, manifest missing for package: Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4

Error CBS Failed to resolve package 'Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4' [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]

Info CBS Mark store corruption flag because of package: Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4. [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]

Info CBS Failed to resolve package [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]
```

> [!NOTE]
> For more information about how to collect more update logs by using the TroubleshootingScript (TSS) tool version 2, see [Introduction to TroubleShootingScript toolset (TSS)](../../windows-client/windows-tss/introduction-to-troubleshootingscript-toolset-tss.md).

## Resolution

> [!IMPORTANT]  
> Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

If the update is installed, remove it and then reinstall it. If the update isn't installed, install it.

### Method for Azure virtual machines: perform an in-place upgrade

If the affected computer is a VM that's running in Azure, we strongly suggest that you perform an in-place upgrade (IPU) to fix the issue. The in-place upgrade reinstalls the operating system while retaining the VMs current configuration.

For additional information, see [In-place upgrade for supported VMs running Windows in Azure](../../azure/virtual-machines/windows/in-place-system-upgrade.md).

### Method for physical computers

#### Step 1: Obtain a fresh copy of the update

1. To make sure that the CBS log contains the latest data, reproduce the issue by trying to install the affected update or feature.
1. Review the CBS log to identify the update or feature package by its KB number.
1. Navigate to [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx), and search for the KB number that you identified.
1. For that KB number, select the package that's appropriate for the operating system version and architecture of the affected computer.1. Download the package to a temporary folder ("temp") on drive C of the affected computer.
1. On the affected computer, open an administrative Command Prompt window, and then run the following commands, in sequence:

   ```console
   cd \
   cd temp
   expand -F:* <PackageName>.msu C:\temp
   ```

   > [!NOTE]  
   > In these commands, \<PackageName> represents the file name of the package that you downloaded. The name contains operating system, architecture, and KB information (for example, windows10.0-kb4462937-x64_9e250691ae6d00cdf677707e83435a612c3264ea.msu).

1. Review the expanded contents of the package, and locate the .cab file that matches your operating system version (for example, windows 10.0-KB4462937-x64.cab).

#### Step 2 (if needed): Remove the update

Follow this step if the update appears to be partly or completely installed on the affected computer.

1. At the command prompt, run the following command:

   ```console
   Dism /online /remove-package /packagepath:C:\temp\<CabFileName>.cab
   ```

   > [!NOTE]  
   > In this command, \<CabFileName> represents the name of the .cab file.

1. If you're prompted to restart the computer, do so.

#### Step 3: Install the update

1. At the command prompt, run the following command:

   ```console
   Dism /online /add-package /packagepath:C:\temp\<CabFileName>.cab
   ```

1. Restart the computer.
1. Try again to install the update or feature.

