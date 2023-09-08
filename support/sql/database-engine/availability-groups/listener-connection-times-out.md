---
title: Listener connection times out
description: This article provides resolutions for the timeout error that occurs when you connect to a SQL Server Always On availability group listener in a multi-subnet environment.
ms.date: 08/04/2020
ms.custom: sap:High Availability and Disaster Recovery features
ms.reviewer: ramakoni
---

# Timeout occurs when you connect to an Always On listener in multi-subnet environment

This article helps you resolve the problem that occurs when you connect to a SQL Server Always On availability group listener in a multi-subnet environment.

_Original product version:_ &nbsp; SQL Server 2012 Developer, SQL Server 2012 Enterprise, SQL Server 2012 Express, SQL Server 2012 Standard, SQL Server 2012 Web, SQL Server 2012 Enterprise Core  
_Original KB number:_ &nbsp; 2792139

## Symptoms

After you configure the availability group listener for an Always On Availability Group in Microsoft SQL Server 2012, you may be unable to ping the listener or connect to it from an application.

For example, when you try to connect to a listener of SQL Server by using `SQLCMD`, the connection times out. Additionally, you receive an error message that resembles the following:

> Sqlcmd: Error: Microsoft SQL Native Client: Login timeout expired.

> [!NOTE]
> These symptoms are usually intermittent, or related to failover of the availability group resource.

The following screenshot shows an example of what occurs when you try to ping the listener for the availability of `aglisten`. The screenshot also shows a successful connection to SQL Server by using the `SQLCMD` command when you include the multi-subnet failover parameter `-M`.

:::image type="content" source="media/listener-connection-times-out/ping-aglisten.png" alt-text="Screenshot of the Command Prompt window when you ping the listener for the availability of aglisten.":::

> [!NOTE]
> You can use the `SQLCMD` command together with the `-M` parameter as shown in the screenshot to connect to the listener.

## Cause

This issue occurs because your application either uses a legacy data provider that does not support the new `MultiSubnetFailover` parameter, or isn't configured to use this parameter.

This parameter is supported in newer versions of the SQLClient driver that is included with the .NET Framework 4 and with later versions of the .NET Framework, and is back ported to the .NET Framework 3.5.

> [!NOTE]
> The `PING` command is a simple connectivity testing tool that does not support the new parameter.

## Resolution

You can use one of the following resolutions as applicable to your case:

- To resolve this situation when the data providers support the `MultiSubNetFailover` parameter, add the `MultiSubNetFailover` parameter to your connection string, and set it to **true**.

- To resolve this situation when your legacy clients cannot use the `MultiSubnetFailover` property, you can change the listener's `RegisterAllProvidersIP` value to **0**. To do this, run the following command from the Windows PowerShell command-line interface:

    ```powershell
    Import-Module FailoverClusters
    Get-ClusterResource <*Your listener name*>|Set-ClusterParameter RegisterAllProvidersIP 0
    ```

    :::image type="content" source="media/listener-connection-times-out/change-listener-registeraiiprovidersip.png" alt-text="Screenshot shows the output of an example of the command in Windows PowerShell.":::

> [!NOTE]
> After you set the `RegisterAllProvidersIP` value to **0**, the current online IP address must be un-registered from the DNS server and the offline IP address must be registered to the DNS server when a failover occurs. This may cause a connection delay for the next failover.

## More information

When you try to connect to a listener that is defined on more than one subnet, the operation may fail if the client driver tries to connect by using one of the listener's offline IP addresses.

When a listener is created, an IP address is designated for each unique subnet that an availability group replica is hosted in. For example, if a listener is created for an availability group that has replicas that exist in two subnets, two IP addresses are defined in the listener. One address is used by an application that can connect to an instance of SQL Server in subnet 1, and the other address is used when an application connects to an instance of SQL Server in subnet 2.

Behind the scenes, the listener creates a Windows cluster Client Access Point resource. One of its properties is `RegisterAllProvidersIP`. When a listener is created, this is set to **1**, and all the listener's IP addresses are registered in DNS server. This configuration provides reduced reconnection time for clients.

Because the DNS record contains all the IP addresses, a client that tries to connect to the listener must know how to handle this situation. The `MultiSubnetFailover` parameter enables the client driver to try connections in parallel to all the listener's IP addresses. Without the `MultiSubnetFailover` parameter, the client driver will try to connect sequentially to all IP addresses for the listener. Sequential connections may cause a long logon time or logon time-outs.

> [!NOTE]
> The problem that is mentioned in this article also affects SharePoint environments that are configured to use an Always On Availability Group's secondary read-only replica. To resolve this issue, perform whichever of the following actions applies to your version of SharePoint:

- For SharePoint 2007: This is classified as a legacy application. Therefore, SharePoint 2007 cannot be configured to use the `MultiSubnetFailover` parameter. Instead, you have to use the Windows PowerShell command that is described in the [Resolution](#resolution) section.

- For SharePoint 2010: Cumulative update packages are now available that add support for the `MultiSubnetFailover` parameter. For more information about the update packages, see the following article:

  - [An update introduces support for the Always On features in SQL Server 2012 or a later version to the .NET Framework 3.5 SP1](https://support.microsoft.com/help/2654347)

  - [Description of the SharePoint Foundation 2010 hotfix package (Wss-x-none.msp): October 30, 2012](https://support.microsoft.com/help/2687557)

## References

- [Connection times out when you use Always On availability group listener with MultiSubnetFailover parameter](https://support.microsoft.com/help/2870437)

- [sqlcmd Utility](/sql/tools/sqlcmd-utility)

- [SqlClient Support for High Availability, Disaster Recovery](/previous-versions/dotnet/netframework-4.0/hh205662(v=vs.100))

- [An update introduces support for the Always On features in SQL Server 2012 or a later version to the .NET Framework 3.5 SP1](https://support.microsoft.com/help/2654347)

- [Create or Configure an Availability Group Listener (SQL Server)](/previous-versions/sql/sql-server-2012/hh213080(v=sql.110))

- [SQL Server Multi-Subnet Clustering (SQL Server)](/sql/sql-server/failover-clusters/windows/sql-server-multi-subnet-clustering-sql-server)

- [Connection Timeouts in Multi-subnet Availability Group](/archive/blogs/alwaysonpro/connection-timeouts-in-multi-subnet-availability-group)
