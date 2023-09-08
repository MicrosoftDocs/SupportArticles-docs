---
title: Warning about network binding order
description: Provides a resolution for the problem that occurs when you install SQL Server 2008 in a failover cluster.
ms.date: 11/04/2020
ms.custom: sap:Installation, Patching and Upgrade (Failover Cluster)
ms.reviewer: russg
---

# Warning about the network binding order on the Setup Support Rules page

This article helps you resolve the problem that occurs when you install SQL Server 2008 in a failover cluster.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 955963

## Symptoms

When you install Microsoft SQL Server 2008 in a failover cluster, you receive a warning message about the network binding order on the Setup Support Rules page.

> [!NOTE]
> The warning is displayed even though the binding order is correct: `IsDomainNetworkTopOfBindings`.

Check to see if the computer domain server is on the network that's bound to the top of the network order.

The domain network isn't the first bound network. This will cause domain operations to run slowly and can cause timeouts that result in failures. Use the Windows network advanced configuration to change the binding order.

## Cause

This issue may occur when you have a disabled network adapter or a ghosted network adapter on the computer.

> [!NOTE]
> A network adapter that is enumerated in the Windows registry but that is hidden in Device Manager is called a ghosted network adapter. This issue may occur when you change a network connection's TCP/IP configuration from DHCP to a static IP. This issue may also occur when you have added and removed network adapters multiple times.

## Resolution

To resolve this issue, remove disabled or ghosted network adapters. To do this, follow these steps:

1. At a command prompt, type the following command lines:

    ```console
    set devmgr_Show_Nonpresent_Devices=1
    start devmgmt.msc
    start ncpa.cpl
    ```

    > [!NOTE]
    > Make sure that you press ENTER after each line.

2. In **Device Manager**, expand **Network adapters**.
3. Compare the list of network adapters in **Device Manager** to the list of network adapters that are displayed in **Network Connections**. Network adapters that are present in **Device Manager** but not in **Network Connections** are ghosted network adapters.
4. If there are any disabled network adapters, enable these adapters in **Device Manager** or in **Network Connections**.
5. If there are any ghosted network adapters, remove them in **Device Manager**.
6. Start the SQL Server setup.
7. After setup is complete, open **Network Connections**, and then disable any network adapters that you don't want.

## References

- [Create a New Always On Failover Cluster Instance (Setup)](/sql/sql-server/failover-clusters/install/create-a-new-sql-server-failover-cluster-setup)

- [Always On Failover Cluster Instances (SQL Server)](/sql/sql-server/failover-clusters/windows/always-on-failover-cluster-instances-sql-server).
