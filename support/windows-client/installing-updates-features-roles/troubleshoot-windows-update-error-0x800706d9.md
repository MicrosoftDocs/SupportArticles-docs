---
title: Troubleshoot Windows Update Error 0x800706D9
description: Discusses how to fix Windows Update error 0x800706D9 (EPT_S_NOT_REGISTERED). This error occurs if required Windows services aren't available.
manager: dcscontentpm
audience: itpro
ms.date: 05/07/2026
ms.topic: troubleshooting
ms.reviewer: scotro, jarretr, v-gsitser, kaushika, v-appelgatet
ai.usage: ai-assisted
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Install errors starting with 0x8007 (ERROR)
- pcy:WinComm Devices Deploy
appliesto:
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error 0x800706D9

## Summary

Windows Update error `0x800706D9 (EPT_S_NOT_REGISTERED)` occurs when a required service that Windows Update depends on isn't running or isn't configured correctly. Such services include the the Remote Procedure Call (RPC) service, the RPC Endpoint Mapper service, or the Windows Firewall service. This article discusses how to identify the cause of this error, and guides you through steps to resolve it on supported versions of Windows client, Windows Server, and Azure Virtual Machines (VMs).

## Symptoms

You install a Windows update, but the installation fails, and you see error code `0x800706D9 (EPT_S_NOT_REGISTERED)` reported.

To get more information, review the following resources:

1. Review the WindowsUpdate.log file or the CBS.log file. Look for entries that resemble the following example:

   ```output
   COMAPI -- RESUMED -- COMAPI: Install [ClientId = AutomaticUpdates]
   Agent -- WARNING: Failed to evaluate Installable rule, Owner = UpdateId, hr = 0x800706D9
   ```

1. To check the status of the RPC service, open a Command Prompt window, and then run the following commands:

   ```console
   sc query RpcSs
   sc query RpcEptMapper
   ```

## Cause

Any of the following conditions can cause this issue:

- The RPC Endpoint Mapper service (RpcEptMapper) is stopped or disabled.
- The Remote Procedure Call (RPC) service (RpcSs) is stopped or disabled.
- The Windows Firewall service is stopped or disabled (the Windows Update agent depends on the firewall service for network communication).
- A Group Policy setting or security configuration disabled required services.
- The Windows Firewall registry configuration is corrupted.

## Resolution

> [!IMPORTANT]  
> Before you troubleshoot this issue, back up the operating system disk. For information about this process for virtual machines (VMs), see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

### Step 1: Start the required services

 To start the services that Windows Update depends on and configure those services to automatically start, run the following commands at the command prompt:

```console
sc config RpcEptMapper start= auto
sc start RpcEptMapper

sc config RpcSs start= auto
sc start RpcSs

sc config MpsSvc start= auto
sc start MpsSvc
```

> [!IMPORTANT]  
> Even if you use Azure Network Security Groups (NSGs) to filter network traffic, you still have to configure and run the Windows Firewall service (MpsSvc). The Windows Update agent depends on the firewall service for internal communication.

After the commands finish running, try again to install the update. If the update still doesn't install, go to step 2.

### Step 2: Check the Windows Firewall configuration

If the Windows Firewall service doesn't start, the registry configuration might be corrupted. To check the registry entry, run the following command at the command prompt of the affected computer:

```console
reg query "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy" /s
```

If the key is missing or corrupted, reset the firewall service to its default configuration. At the command prompt on the affected computer, run the following command:

```console
netsh advfirewall reset
```

After the commands finish running, try again to install the update. If the update still doesn't install, go to step 3.

### Step 3: Reregister Windows Update components

To reregister the DLLs that the Windows Update agent needs, run the following commands at the command prompt:

```console
net stop wuauserv
net stop cryptSvc
net stop bits

regsvr32 /s wuaueng.dll
regsvr32 /s wuaueng1.dll
regsvr32 /s wucltui.dll
regsvr32 /s wups.dll
regsvr32 /s wups2.dll

net start bits
net start cryptSvc
net start wuauserv
```

After the commands finish running, restart the computer, and try again to install the update. If the update still doesn't install, take one of the following actions:

- If the affected computer is a VM, go to step 4.
- Contact Microsoft Support for assistance.

### Step 4: Use the Run Command reset tool (Azure)

If the previous steps don't resolve the issue on an Azure VM, try the [Azure VM Windows Update Reset Tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md). You can run the tool directly from the VM's Azure portal page by using **Operations** > **Run command**. When you use this method, you don't have to sign in to the VM.

This tool resets the Windows Update servicing stack. This action clears memory-related lock states in the update agent.

After you run the tool, try again to install the update. If it still doesn't install, go to step 5.

### Step 5: Use a repair VM (Azure)

If the reset tool doesn't fix the issue, or the VM doesn't start:

1. Create a repair VM by using [Azure VM repair commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands).

1. Attach the affected operating system disk to the repair VM.

1. Configure the offline registry hive so that the following services start automatically:
   - RpcEptMapper
   - RpcSs
   - MpsSvc

1. Reattach the repaired disk to the original VM.

1. Try again to install the update. If the update still doesn't install, contact Microsoft Support for assistance.
