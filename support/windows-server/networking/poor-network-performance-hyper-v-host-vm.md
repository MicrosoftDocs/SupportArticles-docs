---
title: Poor network performance on virtual machines
description: Describes an issue that may occur if you have a Windows Server 2012 Hyper-V host that uses a Broadcom network adapter. Provides a workaround.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-nic-teaming-load-balance-failover, csstroubleshoot
---
# Poor network performance on virtual machines on a Windows Server 2012 Hyper-V host if VMQ is enabled

This article provides a workaround for an issue that occurs if you have a Windows Server 2012 Hyper-V host that uses a Broadcom network adapter.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2902166

## Symptoms  

Consider the following scenario:

- You have a Windows Server 2012 Hyper-V host that uses a Broadcom network adapter.
- You create a virtual switch that binds to the network adapter.
- You enable virtual machine queue (VMQ) on the Hyper-V host.

In this scenario, you experience poor network performance on the virtual machines that are hosted on the Hyper-V host.

## Cause

This is a known issue with Broadcom network adapter drivers when VMQ is enabled. The following Broadcom network adapters are affected:

- 57712
- 57800
- 57810
- 57840

## Resolution

Broadcom is aware of this issue and will release a driver update to resolve the issue. Until the driver update is available, you can work around the issue by taking one of the following actions:

- Disable VMQ on the Virtual Network Adapter by using the following Windows PowerShell cmdlet:

    ```powershell
    Set-VMNetworkAdapter -ManagementOS -Name <VirtualNetworkAdapterName> -VmqWeight 0
    ```

    > [!NOTE]
    > If the problem is not solved, disable VMQ on the Broadcom network adapter.

- Change the Media Access Control (MAC) address of the virtual switch.

    > [!NOTE]
    > IP address of the Hyper-V host may change if DHCP is used.

If you use System Center Virtual machine Manager (SCVMM), SCVMM can automatically assign a new MAC address.

To manually assign a MAC address, follow these steps:

1. Assign a MAC address by using the following Windows PowerShell cmdlet:

   ```powershell
   Set-VMNetworkAdapter -ManagementOS -Name <VirtualNetworkAdapterName> -StaticMacAddress <MacAddress>
   ```

2. Assign a dynamically generated MAC address by using the following Windows PowerShell cmdlet:

    ```powershell
    Set-VMNetworkAdapter -ManagementOS -Name <VirtualNetworkAdapterName> -DynamicMacAddress
    ```

- If there's another unaffected network adapter on the Hyper-V host, bind the virtual switch to that network adapter.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
