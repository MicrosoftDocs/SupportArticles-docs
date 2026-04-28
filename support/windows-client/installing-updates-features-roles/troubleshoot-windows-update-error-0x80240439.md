---
title: Troubleshoot Windows Update error 0x80240439
description: Describes how to fix Windows Update error 0x80240439 (WU_E_NOT_INITIALIZED). this error occurs when the Windows Update agent starts but can't complete its startup sequence.
manager: dcscontentpm
audience: itpro
ms.date: 04/29/2026
ms.topic: troubleshooting
ms.reviewer: scotro, jarretr, v-gsitser, kaushika, v-appelgatet
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Install errors starting with 0x8024 (WU E Setup)
- pcy:WinComm Devices Deploy
appliesto:
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error 0x80240439

## Summary

Windows Update error 0x80240439 (WU_E_NOT_INITIALIZED) occurs when the Windows Update agent starts but can't complete its startup sequence. This article describes the symptoms of this error and provides step-by-step instructions to help you resolve it.

## Symptoms

You install a Windows update, but the installation fails, and you see error code 0x80240439 reported.

To get more information, follow these steps:

1. Check the WindowsUpdate.log file for entries that resemble the following example:

   ```output
   Agent -- WARNING: WU client failed Searching for update with error 0x80240439
   Agent -- WARNING: Exit code = 0x80240439
   ```

1. To check the state of the Windows Update service, open a Windows PowerShell command prompt, and then run the following cmdlets:

   ```powershell
   Get-Service wuauserv | Select-Object Name, Status, StartType
   Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" -ErrorAction SilentlyContinue
   ```

## Cause

This error occurs when the Windows Update service starts but can't finish its startup sequence. Any of the following conditions can cause this issue:

- The Windows Update agent data store is corrupted.
- The Windows Update registry configuration is damaged or incomplete.
- The state files in the %windir%\SoftwareDistribution folder are corrupted.
- A system policy or Group Policy setting blocks the agent from starting.
- A recent Windows Update reset didn't finish the re-initialization process.

## Resolution

> [!IMPORTANT]  
> Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

### Step 1: Reset the Windows Update agent

To reset the Windows Update agent, open a Command Prompt window and then run the following commands:

```console
net stop wuauserv
net stop bits
net stop cryptSvc

ren %windir%\SoftwareDistribution SoftwareDistribution.old
ren %windir%\System32\catroot2 catroot2.old

net start cryptSvc
net start bits
net start wuauserv
```

This sequence of commands stops the Windows Update service, clears the data store, and then restarts the service.

After the commands finish running, try again to install the update. If the update still doesn't install, go to step 2.

### Step 2: Re-register Windows Update components

To re-register the DLLs that the Windows Update agent needs, run the following commands at the command prompt:

```console
regsvr32 /s atl.dll
regsvr32 /s urlmon.dll
regsvr32 /s mshtml.dll
regsvr32 /s shdocvw.dll
regsvr32 /s browseui.dll
regsvr32 /s jscript.dll
regsvr32 /s vbscript.dll
regsvr32 /s scrrun.dll
regsvr32 /s msxml.dll
regsvr32 /s msxml3.dll
regsvr32 /s msxml6.dll
regsvr32 /s actxprxy.dll
regsvr32 /s softpub.dll
regsvr32 /s wintrust.dll
regsvr32 /s dssenh.dll
regsvr32 /s rsaenh.dll
regsvr32 /s gpkcsp.dll
regsvr32 /s sccbase.dll
regsvr32 /s slbcsp.dll
regsvr32 /s cryptdlg.dll
regsvr32 /s oleaut32.dll
regsvr32 /s ole32.dll
regsvr32 /s shell32.dll
regsvr32 /s initpki.dll
regsvr32 /s wuapi.dll
regsvr32 /s wuaueng.dll
regsvr32 /s wuaueng1.dll
regsvr32 /s wucltui.dll
regsvr32 /s wups.dll
regsvr32 /s wups2.dll
regsvr32 /s wuweb.dll
regsvr32 /s qmgr.dll
regsvr32 /s qmgrprxy.dll
regsvr32 /s wucltux.dll
regsvr32 /s muweb.dll
regsvr32 /s wuwebv.dll
```

After the commands finish running, restart the computer. Then, try again to install the update. If the update still doesn't install, go to step 3.

### Step 3: Verify Group Policy settings

To generate a Group Policy report, run the following command at the command prompt:

```console
gpresult /h gpresult.html
```

In the report, review **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Windows Update** for policies that might block initialization. If you find such policies, reconfigure or disable them.

If you make changes, run the following command:

```console
gpupdate /force
```

Restart the computer, and then try again to install the update. If the update still doesn't install, take one of the following actions:

- If the affected computer is a VM, continue to step 4.
- Continue to [step 5](#step-5-check-update-service-configuration).

### Step 4: Use the Run command reset tool (Azure)

If the previous steps don't resolve the issue on an Azure VM, try the [Azure VM Windows Update Reset Tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md). You can run the tool directly from the VM's Azure portal page by using **Operations** > **Run command**. When you use this method, you don't have to sign in to the VM.

This tool resets the Windows Update servicing stack. The reset can clear memory-related lock states in the update agent.

After you run the tool, try again to install the update. If it still doesn't install, go to step 5.

### Step 5: Check update service configuration

If you use Windows Server Update Services (WSUS) or a similar service to manage updates, follow these steps:

1. Verify that the VM can connect to the WSUS server URL.
1. Make sure that firewalls and NSG rules (for VMs) allow outbound connections to the WSUS server or Windows Update endpoints.
1. If you use Azure Update Management, verify that the Hybrid Runbook Worker agent is healthy.
1. Try again to install the update. If the update still doesn't install, contact Microsoft Support for assistance.
