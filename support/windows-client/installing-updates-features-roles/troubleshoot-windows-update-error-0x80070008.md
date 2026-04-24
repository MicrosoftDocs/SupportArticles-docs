---
title: Troubleshoot Windows Update Error 0x80070008
description: Learn how to resolve Windows Update error 0x80070008 (ERROR_NOT_ENOUGH_MEMORY) that occurs when there's insufficient memory to complete the update installation.
manager: dcscontentpm
audience: itpro
ms.date: 04/15/2026
ms.topic: troubleshooting
ms.reviewer: scotro, jarretr, v-gsitser
ms.custom:
- sap:windows servicing,updates and features on demand\Windows Update - Install errors starting with 0x8007 (Win32)
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error 0x80070008

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

Error code 0x80070008 (`ERROR_NOT_ENOUGH_MEMORY`) indicates that the system doesn't have enough memory to complete the Windows Update installation. This error commonly occurs on virtual machines (VMs) with limited RAM or when other processes consume most of the available memory during the update process.

## Prerequisites

For Microsoft Azure virtual machines (VMs) that run Windows, make sure that you back up the OS disk. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

Check the `WindowsUpdate.log` or `CBS.log` for entries that resemble the following example:

```output
Error 0x80070008: Not enough memory resources are available to process this command.
```

You can also check available memory at the time of failure:

1. Open **Event Viewer** > **Windows Logs** > **System**.
2. Look for events from the **Resource-Exhaustion-Detector** source around the time of the update failure.
3. Check for low memory conditions in **Task Manager** or by running `Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 10 Name, @{N='MB';E={[math]::Round($_.WorkingSet64/1MB)}}` in PowerShell.

## Cause

This error occurs when the system doesn't have enough available memory (RAM) to complete the update installation. Common causes include:

- The VM has a small memory allocation (for example, 1 GB or less).
- Other applications or services consume most of the available memory during the update.
- Memory fragmentation prevents allocation of the required contiguous memory blocks.
- The update package is large and requires more memory than is available for extraction and staging.

## Resolution

### Step 1: Free up memory

1. Stop unnecessary services and applications before applying updates.
2. Restart the Windows Update service:

   ```cmd
   net stop wuauserv
   net start wuauserv
   ```

### Step 2: Increase VM memory (Azure)

For Azure VMs, resize the VM to a size with more memory:

1. In the Azure portal, go to the VM resource.
2. Select **Size** under **Settings**.
3. Choose a VM size with more RAM (at minimum 2 GB for update operations).
4. Select **Resize**.

For more information, see [Resize a virtual machine](/azure/virtual-machines/resize-vm).

### Step 3: Configure virtual memory

If increasing physical memory isn't possible, increase the page file size:

1. Open **System Properties** > **Advanced** > **Performance** > **Settings** > **Advanced** > **Virtual Memory**.
2. Set the page file to at minimum 1.5 times the physical RAM.
3. Restart the VM and retry the update.

### Step 4: For Azure VMs — use the Run Command reset tool

If the previous steps don't resolve the issue on an Azure VM, try the [Azure VM Windows Update Reset Tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md). You can run it directly from the Azure portal via **Run Command** without needing RDP access. This tool resets the Windows Update servicing stack, which can clear memory-related lock states in the update agent.

### Step 5: Install updates individually

If the issue persists, install updates one at a time instead of in batches:

```powershell
# List available updates
Get-WindowsUpdate -MicrosoftUpdate

# Install a specific update by KB number
Install-WindowsUpdate -KBArticleID "KB5XXXXXX" -AcceptAll
```
