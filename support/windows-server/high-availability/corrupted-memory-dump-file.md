---
title: Corrupted memory dump file is generated
description: Resolves an issue where a corrupted memory dump file is generated when you try to obtain a full memory dump file from a virtual machine.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:cluster-node-is-hanging, csstroubleshoot
ms.technology: windows-server-high-availability
---
# Corrupted memory dump file when you try to obtain a full memory dump file from a virtual machine that is running in a cluster environment

This article provides a solution to an issue where a corrupted memory dump file is generated when you try to obtain a full memory dump file from a virtual machine.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2913486

## Symptoms

You have a virtual machine that is running in a cluster environment in Windows Server 2012 or Windows Server 2008 R2. When you try to obtain a full memory dump file from the virtual machine, a corrupted memory dump file is generated. While the memory dump file is loading, you may receive the following message:

**************************************************************************

THIS DUMP FILE IS PARTIALLY CORRUPT.

KdDebuggerDataBlock is not present or unreadable.

**************************************************************************

GetContextState failed, 0xD0000147

Unable to get program counter

GetContextState failed, 0xD0000147

Unable to get current machine context, NTSTATUS 0xC0000147

Additionally, you may notice that writing a full memory dump file does not finish and that the virtual machine is restarted on another node in the cluster.

## Cause

This issue occurs because the **Enable heartbeat monitoring for the virtual machine**  option is selected for the virtual machine. This option resets the clustered virtual machine after one minute (the default value), and the clustered virtual machine requires longer that one minute to finish writing the memory dump.

> [!NOTE]
> Heartbeats between the virtual machine and Virtual Machine Manager occur every few seconds. It can require up to one minute to detect that the virtual machine is down because the virtual machine resource checks the heartbeat status from Virtual Machine Manager in its isAlive  entry-point function. By default, isAlive  occurs one time every minute. However, the heartbeats may stop 30 seconds before the one-minute interval. In this case, the cluster can restart the virtual machine on the same server or fail it over to another node.

## Resolution

To resolve this issue, disable the **Enable heartbeat monitoring for the virtual machine** option.

### Option 1: Change the settings from the GUI

1. Open Failover Cluster Manager.
2. Click **Roles**, and then find the virtual machine resource. 
3. On the Resources tab, right-click the virtual machine. 
4. Click **Properties**, and then click the **Settings**  tab.
5. In **Heartbeat Setting**, click to clear the **Enable automatic recovery for application health monitoring**  check box.
6. Click to clear the **Enable heartbeat monitoring for the virtual machine**  check box, and then click **OK**.

### Option 2: Change the settings by using Windows PowerShell

1. Start Windows PowerShell.
2. Check the virtual machine name. To do this, type the following Windows PowerShell command:

    ```powershell
    PS C:\> Get-ClusterResource
    ```

3. Check whether the **Enable heartbeat monitoring for the virtual machine**  and **Enable automatic recovery for application health monitoring**  options are selected. To do this, type the following Windows PowerShell command:

    ```powershell
    PS C:\> Get-ClusterResource <VirtualMachineName> | Get-ClusterParameter CheckHeartbeat
    ```

4. When the CheckHeartbeat value is 1, both options are selected. To cancel both options, change this value to 0. To do this, type the following Windows PowerShell command:

    ```powershell
    PS C:\> Get-ClusterResource <VirtualMachineName> | Set-ClusterParameter CheckHeartbeat 0
    ```

    If you want to cancel only the **Enable automatic recovery for application health monitoring**  option, you should run the following Windows PowerShell command:

    ```powershell
    PS C:\> (Get-ClusterResource <Object>).EmbeddedFailureAction = 1
    ```

## More information

Mini and kernel memory dump files are written successfully. This occurs because the time that is required to write these files doesn't exceed the one-minute threshold.
