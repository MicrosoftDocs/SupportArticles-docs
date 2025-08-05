---
title: Troubleshoot Windows Installation Error 0x800f0831
description: Learn how to resolve Windows Update installation error 0x800f0831.
ms.date: 07/31/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: scotro,mwesley
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---

# Troubleshoot Windows Update installation error 0x800f0831

> [!WARNING]
> This error is flagged to prompt an in-place upgrade to recover the virtual machine (VM) if these instructions don't resolve the issue.

Windows Update error 0x800f0831 typically occurs if an update doesn't install the required manifest files correctly. This article helps you understand the root cause of the issue and the necessary steps to resolve it effectively.

## Prerequisites

Before you troubleshoot, follow the steps in [this article](https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/495352/Network-Level-Authentication_RDP-SSH?anchor=%3Cspan-class%3D%22mw-customtoggle-mydivision%22%3Ebackup-os-disk%3C/span%3E) to back up the OS disk.

## Symptoms

When you try to install any update by using the standalone installer (.msu), or you try to install a Windows update, you receive one of the following error messages:

> Some updates were not installed

:::image type="content" source="media/install-error-new.jpg" alt-text="Screenshot of the installation error message.":::

> Updates failed

:::image type="content" source="media/windows-update-new.jpg" alt-text="Screenshot of the Windows Update error message.":::

> Retry

:::image type="content" source="media/retry-deba-new.jpg" alt-text="Screenshot of the Retry error message.":::

## Cause

The issue might occur for one of the following reasons:

- An assembly from the KB3192392 update (specifically: "Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4") is missing or corrupted.
- The update was never installed. Or, the update is installed but some packages aren't applied to the registry.

To locate the installation packages in the system, search for the following registry subkey:

    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages
 
> [!IMPORTANT]
> This issue might vary depending on each case, but the baseline of the issue remains the same.

To investigate the cause further, examine the CBS.log file (C:\windows\logs\CBS), and search for output that resembles the following example:

```output
Info CBS Store corruption, manifest missing for package: Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4

Error CBS Failed to resolve package 'Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4' [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]

Info CBS Mark store corruption flag because of package: Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4. [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]

Info CBS Failed to resolve package [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]
```

> [!NOTE]
> For more information about how to collect the CBS.log file or any log that uses the TroubleShootingScript (TSS) tool version 2, see, [CBS logs](https://aka.ms/dndlogs).

## Resolution

To resolve this issue, manually add the problematic update to the system or remove it from the system, depending on whether the update is installed. 

### If the update is installed

1. Reproduce the issue by trying to install the update or feature that's experiencing issues. This action logs the latest data into the CBS log.
1. Verify that you have the correct update after you identify the package that the CBS process is calling out.
1. Navigate to [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx), and search for the KB number that you identified.
1. Select the appropriate KB version for the OS version and architecture, and then download the file to a temporary folder ("temp") on drive C.
1. Open an administrative Command Prompt window, and run the following command on the folder:

   ```output
   cd \
   cd temp
   expand -F:* windows10.0-kb4462937-x64_9e250691ae6d00cdf677707e83435a612c3264ea.msu C:\temp
   ```

   **Note:** In this command, substitute the actual name of the downloaded file.

1. In the expanded packages, locate the .cab file that uses the following format, depending on the OS version:

      windows 10.0-KB*xxxxxxx*-x64.cab
   
1. Run the following command at an administrative command prompt:

   ```output
   Dism /online /remove-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
   ```

   **Note:** In this command, substitute the actual name of the .cab file.

1. Restart the computer if you're prompted to do that.
2. Run the following command at an administrative command prompt:

   ```output
   Dism /online /add-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
   ```

1. Restart the computer.
1. Try again to install the update or feature.

### If the update isn't installed

1. Navigate to the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx), and download the update to a temporary folder ("temp") on drive C.
1. At an administrative command prompt, run the following command on the folder:

   ```output
   cd \
   cd temp
   expand -F:* windows10.0-kb4462937-x64_9e250691ae6d00cdf677707e83435a612c3264ea.msu C:\temp 
   ```

   **Note:** In this command, substitute the actual name of the downloaded file.
   
1. In the expanded packages, locate the .cab file that uses the following format, depending on the OS version:

      windows 10.0-KB*xxxxxxx*-x64.cab
   
1. At an administrative command prompt, run the following command:

   ```output
   Dism /online /add-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
   ```

   **Note:** In this command, substitute the actual name of the .cab file.

1. Restart the computer.

1. Try again to install the update or feature.

### In-place upgrade process

> [!NOTE]
> If the suggested fixes don’t resolve the issue, this specific Windows Update (WU) error code might require an in-place upgrade (IPU) as a simple and effective solution to recover the VM. For Windows on Azure (WOA) scenarios, these kinds of WU errors are reviewed and approved as eligible for IPU. This is especially true if you're trying to resolve issues quickly.
