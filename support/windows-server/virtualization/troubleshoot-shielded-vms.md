---
title: Troubleshoot shielded VMs
description: Helps troubleshoot shielded VMs.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, dongill, inhenkel, v-lianna
ms.custom: sap:Virtualization and Hyper-V\Shielded Virtual Machines, csstroubleshoot
---
# Troubleshoot shielded VMs

This article helps troubleshoot shielded VMs.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016

Beginning with Windows Server version 1803, Virtual Machine Connection (VMConnect) enhanced session mode and PowerShell Direct are re-enabled for fully shielded VMs. The virtualization admin still requires VM guest credentials to get access to the VM, but this makes it easier for a hoster to troubleshoot a shielded VM when its network configuration is broken.

To enable VMConnect and PowerShell Direct for your shielded VMs, move them to a Hyper-V host that runs Windows Server version 1803 or later. The virtual devices allowing for these features will be re-enabled automatically. If a shielded VM moves to a host that runs and earlier version of Windows Server, VMConnect and PowerShell Direct will be disabled again.

For security-sensitive customers who worry if hosters have any access to the VM and wish to return to the original behavior, the following features should be disabled in the guest OS:

- Disable the PowerShell Direct service in the VM:

  ```powershell
  Stop-Service vmicvmsession
  Set-Service vmicvmsession -StartupType Disabled
  ```

- VMConnect Enhanced Session mode can only be disabled if your guest OS is at least Windows Server 2019 or Windows 10, version 1809. Add the following registry key in your VM to disable VMConnect Enhanced Session console connections:

  ```console
  reg add "HKLM\Software\Microsoft\Virtual Machine\Guest" /v DisableEnhancedSessionConsoleConnection /t REG_DWORD /d 1
  ```
