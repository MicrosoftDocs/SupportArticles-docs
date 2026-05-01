---
title: Troubleshoot Windows Update Error 0x800706D9
description: Learn how to resolve Windows Update error 0x800706D9 (EPT_S_NOT_REGISTERED) that occurs when the RPC endpoint mapper service isn't available.
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

# Troubleshoot Windows Update error 0x800706D9

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

Error code 0x800706D9 (`EPT_S_NOT_REGISTERED`) indicates that the Remote Procedure Call (RPC) endpoint mapper service isn't available or that a required service endpoint isn't registered. This error prevents Windows Update from communicating with the necessary system services to install updates.

## Prerequisites

For Microsoft Azure virtual machines (VMs) that run Windows, make sure that you back up the OS disk. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

Check the `WindowsUpdate.log` for entries that resemble the following example:

```output
COMAPI -- RESUMED -- COMAPI: Install [ClientId = AutomaticUpdates]
Agent -- WARNING: Failed to evaluate Installable rule, Owner = UpdateId, hr = 0x800706D9
```

You can also check the RPC service status:

```cmd
sc query RpcSs
sc query RpcEptMapper
```

## Cause

This error occurs when one of the following conditions exists:

- The **RPC Endpoint Mapper** service (`RpcEptMapper`) is stopped or disabled.
- The **Remote Procedure Call (RPC)** service (`RpcSs`) is stopped or disabled.
- The **Windows Firewall** service is stopped or disabled (the Windows Update agent depends on the firewall service for network communication).
- A Group Policy or security configuration has disabled required services.
- The Windows Firewall registry configuration is corrupted.

## Resolution

### Step 1: Verify and start required services

Start the services that Windows Update depends on:

```cmd
sc config RpcEptMapper start= auto
sc start RpcEptMapper

sc config RpcSs start= auto
sc start RpcSs

sc config MpsSvc start= auto
sc start MpsSvc
```

> [!NOTE]
> The Windows Firewall service (`MpsSvc`) is required even if you use Azure Network Security Groups (NSGs) for network filtering. The Windows Update agent depends on the firewall service for internal communication.

### Step 2: Check the Windows Firewall configuration

If the Windows Firewall service fails to start, the registry configuration might be corrupted. Verify the firewall registry key:

```cmd
reg query "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy" /s
```

If the key is missing or corrupted, reset the firewall to defaults:

```cmd
netsh advfirewall reset
```

### Step 3: Re-register Windows Update components

If the issue persists after starting the services, re-register the Windows Update DLLs:

```cmd
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

### Step 4: For Azure VMs

First, try the [Azure VM Windows Update Reset Tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md). You can run it directly from the Azure portal via **Run Command** without needing RDP access. This tool resets the Windows Update servicing stack, which often resolves RPC-related registration failures.

If the reset tool doesn't resolve the issue or you can't access the VM through RDP, use the Azure Serial Console or run a repair through an attached OS disk:

1. Use [Azure VM repair commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands) to create a repair VM.
2. Attach the affected OS disk to the repair VM.
3. Start the required services in the offline registry hive.
