---
title: Managing Hyper-V hosts fails with error 0x8033803b
description: Fixes an issue in which you receive error 0x8033803b when you manage a Hyper-V host in Virtual Machine Manager.
ms.date: 07/09/2020
ms.reviewer: jeffpatt
---
# Managing Hyper-V hosts using VMM fails with error 0x8033803b after installing WMF 3.0

This article helps you fix an issue in which you receive error 0x8033803b when you manage a Hyper-V host in Virtual Machine Manager (VMM).

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2795043

## Symptoms

On System Center Virtual Machine Manager, you may experience one of the following symptoms:

- A Windows Server 2008 R2 SP1 Hyper-V host has a status of **Needs Attention** in the VMM console.
- Adding a Hyper-V host or cluster fails.

In the **Jobs** view, the following error is logged:

> Warning (2927)  
> A Hardware Management error has occurred trying to contact server servername.contoso.com \: a \:DestinationUnreachable :The WS-Management service cannot process the request. The service cannot find the resource identified by the resource URI and selectors.  
> Unknown error (0x8033803b)

This issue applies to System Center 2012 Virtual Machine Manager and System Center 2012 Virtual Machine Manager 2012 Service Pack 1 (SP1).

## Cause

This issue can occur if [Windows Management Framework (WMF) 3.0](https://support.microsoft.com/help/2506143) is installed on a Windows Server 2008 R2 SP1 Hyper-V host. When WMF 3.0 is installed, all PUT operations through Windows Remote Management (WinRM) to Hyper-V fail.

## Resolution 1

Install the following hotfix on Hyper-V hosts that have WMF 3.0 installed:

[WinRM operations to Hyper-V fail on a Windows 7 SP1-based or Windows Server 2008 R2 SP1-based computer that has Windows Management Framework 3.0 installed](https://support.microsoft.com/help/2781512)

## Resolution 2

Uninstall Windows Management Framework 3.0 on the Hyper-V host. To uninstall the update, perform the following steps on the Hyper-V host:

1. In Control Panel, open **Programs and Features**.
2. Select **View installed updates**.
3. Right-click **Microsoft Windows Management Framework 3.0 (KB2506143)** and select **Uninstall**.
4. Once the uninstall is complete, restart the server.
5. Once the server is restarted, open an evaluated command prompt, type the following command and hit enter:

   ```console
   winrm qc
   ```

6. Follow the prompts to enable WinRM requests on the server.
7. Restart the server.
8. Once the server is restarted, open the VMM console and verify the issue is resolved.
