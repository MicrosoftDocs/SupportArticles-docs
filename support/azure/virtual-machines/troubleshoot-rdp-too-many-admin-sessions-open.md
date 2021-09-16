---
title: Too many admin sessions Open error occurs when you make an RDP connection to Azure Windows VM| Microsoft Docs
description: Learn how to troubleshoot "too many admin sessions Open" error when you connect to Azure VM| Microsoft Docs
services: virtual-machines
documentationCenter: ''
author: genlin
manager: dcscontentpm
editor: ''
ms.service: virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 09/16/2021
ms.author: genli
---

# Too many admin sessions open error when you connect to an Azure Windows VM

This article helps you troubleshoot "Too many admin sessions open" error when you connect to an Azure Windows virtual machine (VM).

## Symptoms

When you connect to an Azure Windows VM by Remote Desktop Protocol (RDP), the following error is received:

   >Too many admin sessions open.

However, you can connect to the VM by using an administrative RDP session (mstsc /admin).

## Cause

The issue can occurs if you have reached maximum allowed number of concurrent RDP connections.

## Solution

Before start troubleshooting, [back up the OS disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk). 

1. Connect to the VM by using the Azure Serial Console and [start a PowerShell session]( serial-console-windows.md#use-serial-console). If the Azure Serial Console does not work, connect the VM by remote PowerShell. For more information, see [How to use remote tools to troubleshoot Azure VM issues](remote-tools-troubleshoot-azure-vm-issues.md).

1. After you connect to the VM by using CMD or PowerShell, run the following command identify the current maximum connection setting for the RDP service:

    ```powershell
   reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\TerminalServerGateway\Config\Core" /v MaxConnections
    ```
    
    If the value exists, run the following command to set the MaxConnections value to 0 that means allow unlimited number of RDP connections. 
    ```powershell
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\TerminalServerGateway\Config\Core" /v MaxConnections /t REG_DWORD /d 0 /f 
    ```
1. Restart the VM, and then try to RDP to the VM.


## Need help? Contact support

If you still need help, [contact support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) to get your issue resolved.