---
title: Troubleshoot Windows Update Error Code 0x800f0823
description: Discusses how to resolve an issue that prevents Windows updates from installing.
ai-usage: ai-assisted
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, dougking, v-appelgatet
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Install errors starting with 0x800F (CBS E)
- pcy:WinComm Devices Deploy
appliesto:
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Azure Virtual Machines</a>
---
# Troubleshoot Windows Update error code 0x800f0823

This article discusses how to resolve an issue that prevents Windows updates from installing.

## Symptoms

When you try to install a Windows update, the installation fails, and you receive error code `0x800f0823 (CBS_E_NEW_SERVICING_STACK_REQUIRED)`. This issue might occur when you install updates whether you use a direct connection to Windows Update or an offline MSI file. To verify the details of this issue, search for an entry in the CBS.log file that resembles the following example (from Windows Server 2016):

```output
2023-09-04 15:01:53, Error            CBS    Package "Package_for_KB5012170~31bf3856ad364e35~amd64~~14393.5285.1.4" requires Servicing Stack v10.0.14393.5285 but current Servicing Stack is v10.0.14393.4349. [HRESULT = 0x800f0823 - CBS_E_NEW_SERVICING_STACK_REQUIRED]
```

For more information about the CBS log, see [Windows Update log files](/windows/deployment/update/windows-update-logs).

## Cause

This error code means that the affected computer's servicing stack is out of date. The servicing stack is the component that installs Windows updates. If this error occurs, the computer can't process new updates correctly.

Typically, Windows Update automatically keeps the servicing stack up to date by installing [servicing stack updates (SSUs)](/windows/deployment/update/servicing-stack-updates). However, it's possible for a physical computer or virtual machine (VM) to fall out of sync by skipping updates.

## Resolution

> [!IMPORTANT]  
> Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

> [!NOTE]  
> If the affected computer is a VM, consider using the technique that's mentioned in [Azure Virtual Machine (VM) Windows servicing stack reset tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md).

### Step 1: Get the most recent SSU

For earlier versions of Windows, you can search for specific SSUs in the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com). For example, depending on the operating system that you're using, search for the following strings:

- Windows 10, version 1607, and earlier versions: **ssu "Windows 10"**
- Windows Server 2016: **ssu "Windows Server 2016"**

Identify the update that has the latest release date.

> [!NOTE]  
> You can also verify the latest SSU for those Windows versions by reviewing the [MSRC Servicing Stack Update](https://msrc.microsoft.com/update-guide/vulnerability/ADV990001) page. In the Frequently Asked Questions list, look for the following question:
>
> "When was the most recent SSU released for each version of Microsoft Windows?"

For later versions of Windows and Windows Server, security updates include both SSUs and the latest cumulative updates (LCUs). Before you try to locate the security update that you need in the catalog, use the update history listings to identify the appropriate KB number. The following table provides links to these listings.

| Windows version | Update history |
| --- | --- |
| Windows Server 2025, all versions | [Windows Server 2025 update history](https://support.microsoft.com/help/5047442) |
| Windows Server 2022, all versions | [Windows Server 2022 update history](https://support.microsoft.com/help/5005454) |
| Windows 11, all versions | [Windows 11 update history](https://support.microsoft.com/help/5065323) |
| Windows 10, version 2004, and later versions | [Windows 10 update history](https://support.microsoft.com/help/5018682) |
| Windows 10, version 1809, and Window Server 2019, all versions | [Windows 10 and Windows Server 2019 update history](https://support.microsoft.com/topic/windows-10-and-windows-server-2019-update-history-725fc2e1-4443-6831-a5ca-51ff5cbcb059) |

After you locate the update that you want, search for the update's KB number in the Microsoft Update Catalog.

> [!NOTE]  
> The text of an update's KB article might refer to its associated SSU by using a KB number that's different from the main article number. However, in the catalog, you can search for only the main article's KB number. The catalog doesn't have separate entries for these SSU numbers.

### Step 2: Download and install the update

Typically, your update search results include more than one update for a single KB number. Check the update title to identify the update that applies to the affected computer's architecture. Select **Download** to download the appropriate file to the affected physical computer or VM. After you install the update, restart the physical computer or VM.

### Step 3: Install the update that failed

Try again to install the original update.

### Next steps

After you resolve the issue, monitor the computer's update status to make sure that it stays up to date.

If the issue persists, contact Microsoft Support for further assistance. Attach copies of any relevant CBS.log data to your support request.
