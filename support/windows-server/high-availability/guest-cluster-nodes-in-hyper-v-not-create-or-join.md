---
title: Guest Cluster nodes in Hyper-V may not be able to create or join
description: This article provides workarounds for the issue that Guest Cluster nodes in Hyper-V may not be able to create or join.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: stevenek, kaushika
ms.custom: sap:initial-cluster-creation-or-adding-node, csstroubleshoot
---
# Guest Cluster nodes in Hyper-V may not be able to create or join

This article provides workarounds to an issue that Guest Cluster nodes in Hyper-V may not be able to create or join.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2872325

## Symptoms

Failover clusters that are running in virtual machines (sometimes referred to as "guest clusters") could have problems with nodes joining the cluster.

By using the **Create Cluster Wizard**, the cluster may fail to create. Additionally, the report from the wizard may have the following message:

> An error occurred while creating the cluster.  
An error occurred creating cluster '\<clustername>'.  
This Operation returned because the timeout period expired

> [!NOTE]
> The above errors can also be seen anytime that communications between the servers that are specified to be part of the cluster creation do not complete. A known cause is described in this article.

In some scenarios, the cluster nodes are successfully created and joined if the VMs are hosted on the same node. However, once the VMs are moved to different nodes, the communications between the nodes of the guest cluster starts to fail. Therefore the nodes of the cluster may be removed from the cluster.

## Cause

This issue can occur due to packets not reaching to the virtual machines, when the VMs are hosted on Windows Server 2012 failover cluster nodes, due to a failover cluster component that is bound to the network adapters of the hosts. The component is called the "Microsoft Failover Cluster Virtual Adapter Performance Filter" and it was first introduced in Windows Server 2012.

The problem only affects the network packets addressed to cluster nodes hosted in virtual machines.

## Workaround

It is recommended that, if the Windows Server 2012 failover cluster is going to host virtual machines that are part of guest clusters, you should unbind the "Microsoft Failover Cluster Virtual Adapter Performance Filter" object from all of the virtual switch network adapters on the Windows Server 2012 Failover Cluster nodes.

> [!NOTE]
> This problem can affect any Windows Server Failover Cluster version that is running inside of virtual machines as a guest cluster. The information mentioned in the cause and workaround of this article is specific to Windows Server 2012 Failover Clusters that are used to host virtual machines.

You can disable the "Microsoft Failover Cluster Virtual Adapter Performance Filter" object using one of the methods from below:

Disabling using the GUI

Open **Network Connections** to get the list of network adapters. All network adapters with the "vEthernet" (default name) are the virtual networks (i.e. virtual switch). The physical adapters that also have a Hyper-V virtual adapter configured for it will not have the "Microsoft Failover Cluster Virtual Adapter Performance Filter" binding, so there is nothing to disable for those adapters.

1. Right click on one of the "v" adapters and select **Properties** from the menu.
2. Uncheck the item labeled "Microsoft Failover Cluster Virtual Adapter Performance Filter".
3. Click on **OK** to close the dialog and have the binding disabled for the unchecked item.
4. Repeat for all the adapters.

Disabling using Windows PowerShell

The following process will disable the network adapter, which is binding for "Microsoft Failover Cluster Virtual Adapter Performance Filter" on every adapter on the server that has the Componentid of "vms_mp". This Componentid indicates that the adapter is a Hyper-V adapter used by the virtual switch.

You can run this process on each node of the server so that every server has the binding disabled for the adapters used by the virtual switch.

- Open the Windows PowerShell console with Administrator access using the **Run as Administrator** option.
- Run the following:

    ```powershell
    Get-netadapter | Disable-NetAdapterBinding -DisplayName "Microsoft Failover Cluster Virtual Adapter Performance Filter"
    ```

    > [!NOTE]
    > If you desire to enable the binding again, just replace "Disable-NetAdapterBinding" with "Enable-NetAdapterBinding".

- To verify which network adapters have the "Microsoft Failover Cluster Virtual Adapter Performance Filter" item bound to it, you can run the following process:

    ```powershell
    PS C:\Windows\system32> Get-NetAdapterBinding | Where-Object {$_.DisplayName -eq "Microsoft Failover Cluster Virtual Adapter Performance Filter"} | FT Name,DisplayName,Enabled 
    
    Name         DisplayName                             Enabled
    -------      ---------------                         ----------
    vEthernet    Microsoft Failover Cluster Virtual A... False
    vEthernet 2  Microsoft Failover Cluster Virtual A... False
    vEthernet 3  Microsoft Failover Cluster Virtual A... False
    Ethernet 3   Microsoft Failover Cluster Virtual A... False
    Ethernet 2   Microsoft Failover Cluster Virtual A... False
    Ethernet     Microsoft Failover Cluster Virtual A... False
    ```

    The "Enabled" property of the binding for each adapter is "False", which means it's not bound to that adapter.

## More information

Windows Server 2012 failover cluster has a component that is bound to the network adapters called "Microsoft Failover Cluster Virtual Adapter Performance Filter" and it can cause some of the packets addressed to cluster nodes in the virtual machine to not reach the virtual machine. If this issue occurs while a node is joining the cluster inside of the virtual machine, it may fail to successfully be added to the cluster, or join the cluster.

The "Microsoft Failover Cluster Virtual Adapter Performance Filter" component is used by the failover cluster NetFT virtual adapter to route some cluster specific communications between nodes of the cluster. This item is not required to have it's binding enabled for NetFT to function. Therefore, for Hyper-V hosts running Windows Server 2012, it is recommended to disable the binding of this component on all adapters of Hyper-V hosts that are members of a failover cluster.
