---
title: Troubleshoot Windows Update error 0x80070008
description: Describes how to resolve Windows Update error 0x80070008 (ERROR_NOT_ENOUGH_MEMORY). This error indicates that the computer doesn't have enough memory to complete the update installation.
manager: dcscontentpm
audience: itpro
ms.date: 04/28/2026
ms.topic: troubleshooting
ms.reviewer: scotro, jarretr, v-gsitser, kaushika, v-appelgatet
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Install errors starting with 0x8007 (ERROR)
- pcy:WinComm Devices Deploy
appliesto:
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error 0x80070008

## Summary

Windows Update error 0x80070008 (ERROR_NOT_ENOUGH_MEMORY) occurs when the computer doesn't have enough available memory (RAM) to install an update. This error commonly occurs on virtual machines (VMs) that have limited RAM, or when other processes consume most of the available memory during the update process. This article describes how to identify the cause of the error. The article walks you through several steps to resolve the error, including freeing up memory, adjusting virtual memory settings, and resizing Azure VMs.

## Symptoms

You install a Windows update, but the installation fails, and you see error code 0x80070008 reported.

To get more information, review the following resources:

1. Review the WindowsUpdate.log file or the CBS.log file. Look for entries that resemble the following example:

   ```output
   Error 0x80070008: Not enough memory resources are available to process this command.
   ```

1. Open Event Viewer, and go to **Windows Logs** > **System**. Look for events from the **Resource-Exhaustion-Detector** source that occurred around the time of the update failure.
1. Check for low memory conditions. Use one of the following methods:
   - Open **Task Manager**, select **Performance**, and then select **Memory**.
   - Open a Windows PowerShell command prompt, and then run the following cmdlets:

     ```powershell
     Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 10 Name, @{N='MB';E={[math]::Round($_.WorkingSet64/1MB)}}
     ```

## Cause

This error occurs when the computer doesn't have enough available memory (RAM) to install the update. Common causes include:

- The computer is a VM that has a small memory allocation (for example, 1 GB or less).
- During the update, other applications or services consume most of the available memory.
- The computer can't allocate contiguous memory blocks of sufficient size because of memory fragmentation.

This issue is more likely to occur if the update package is large. Such updates might require more memory than what's available for extraction and staging.

## Resolution

> [!IMPORTANT]  
> Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

### Step 1: Free up memory

1. Before you install updates, stop all unnecessary services and applications.
1. After you stop services and applications, restart the Windows Update service. For example, open a Command Prompt window, and then run the following commands:

   ```console
   net stop wuauserv
   net start wuauserv
   ```

1. Try again to install the update. If the update still doesn't install, go to step 2 (for virtual machines) or step 3 (for all computers).

### Step 2: Increase VM memory (Azure)

If the affected computer is an Azure VM, resize the VM by following these steps:

1. In the Azure portal, go to the VM resource.
1. Under **Availability + scale**, select **Size**.
1. Select a VM size that uses more RAM. To make sure that updates install smoothly, select a size that uses at least 2 GB of RAM.
1. Select **Resize**.
1. Try again to install the update. If it still doesn't install, continue to step 3.

For more information, see [Resize a virtual machine](/azure/virtual-machines/resize-vm).

### Step 3: Configure virtual memory

If increasing physical memory isn't possible, increase the page file size. This setting allows the computer to use larger sections of the hard disk for memory. Follow these steps:

1. On the affected computer, open **Settings**, and select **System**.
1. Under **Related links**, select **Advanced system settings**.
1. On the **Advanced** tab of the **System Properties** dialog box, locate the **Performance** section, and then select **Settings**.
1. Select **Advanced**, locate the **Virtual memory** section, and then select **Change**.
1. If the **Automatically manage paging file size for all drives** checkbox is selected, clear it.
1. Select **Custom size**, and then type new values for the initial and maximum paging file size. The new values should be greater than 1.5 times the physical RAM capacity.
1. Restart the computer.
1. Try again to install the update. If it still doesn't install, continue to step 4 (for virtual machines) or step 5 (for all computers).

### Step 4: Use the Run command reset tool (Azure)

If the previous steps don't resolve the issue on an Azure VM, try the [Azure VM Windows Update Reset Tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md). You can run the tool directly from the VM's Azure portal page by using **Operations** > **Run command**. When you use this method, you don't have to sign in to the VM.

This tool resets the Windows Update servicing stack. The reset can clear memory-related lock states in the update agent.

After you run the tool, try again to install the update. If it still doesn't install, go to step 5.

### Step 5: Install updates individually

If the issue persists, install updates one at a time instead of in batches.

To get a list of the pending updates, run the following cmdlet at a PowerShell command prompt on the affected computer:

```powershell
Get-WindowsUpdate -MicrosoftUpdate
```

To install one of the updates from the list, run the following cmdlet:

```powershell
Install-WindowsUpdate -KBArticleID "KB5XXXXXX" -AcceptAll
```

> [!NOTE]  
> In this cmdlet, *XXXXXX* represents the identification number of the update.
