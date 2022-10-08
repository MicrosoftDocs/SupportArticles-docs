---
title: Too many admin sessions Open error occurs when you try to make an RDP connection to Azure Windows VM.
description: Learn how to troubleshoot the "too many admin sessions open" error when you try to connect to an Azure VM.
services: virtual-machines
documentationCenter: ''
author: genlin
manager: dcscontentpm
editor: v-jesits
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 09/16/2021
ms.author: genli
---

# Too many admin sessions open error when you try to connect to an Azure Windows VM

This article helps you troubleshoot the "too many admin sessions open" error when you try to connect to an Azure Windows virtual machine (VM).

## Symptoms

When you try to connect to an Azure Windows VM by using Remote Desktop Protocol (RDP), you receive the following error message:

   >Too many admin sessions open.

However, you can connect to the VM by using an administrative RDP session (mstsc /admin).

## Cause

The issue occurs if you have reached the maximum allowed number of concurrent RDP connections.

## Resolution

Before you start troubleshooting, [back up the OS disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk). Then, follow these steps:

1. Connect to the VM by using the Azure Serial Console, and then [start a PowerShell session]( serial-console-windows.md#use-serial-console). If the Azure Serial Console doesn't work, connect to the VM by using remote PowerShell. For more information, see [How to use remote tools to troubleshoot Azure VM issues](remote-tools-troubleshoot-azure-vm-issues.md).

1. After you connect to the VM, run the following command to identify the current maximum connections setting for the RDP service:

    ```powershell
   reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\TerminalServerGateway\Config\Core" /v MaxConnections
    ```

    If the value doesn't exist, the service uses the default setting that allows an unlimited number of RDP connections.

    If the value exists, run the following command to set the **MaxConnections** value to **0** to allow unlimited RDP connections:

    ```powershell
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\TerminalServerGateway\Config\Core" /v MaxConnections /t REG_DWORD /d 0xffffffff /f 
    ```

1. Restart the VM, and then try again to connect to the VM.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
