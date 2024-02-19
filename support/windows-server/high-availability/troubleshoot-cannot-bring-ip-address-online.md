---
title: Can't bring an IP Address online in a cluster
description: Provides guidance for when an IP address fails to come online in a Windows-based failover cluster
ms.date: 12/26/2023
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
---
# Can't bring an IP address online in a failover cluster

## Troubleshooting checklist

1. Review the system and the cluster log to find the exact errors or warnings that prevent the IP address from coming online.

2. Check the IP address for this resource and ensure that the status of the corresponding cluster network is **UP** under **Networks** in Failover Cluster Manager.

3. If you create a new IP address within an empty group from the same cluster network, does it come online?

4. Check the output of the `ipconfig /all` command and compare the information of the affected network with a working one.

5. Disable or enable the Network Interface Card (NIC) that's corresponding to the cluster network for the affected IP address.

6. Update the driver for the NIC or teaming.

## Common issues and solutions

Try one of the following solutions according to the Event ID:

- For Event ID 1046, 1047, 1048, 1049, 1078, and 1223, [check the role that is configured for a cluster network](#check-the-role-that-is-configured-for-a-cluster-network).

- For Event ID 1360, 1361, and 1362, [review the logs to find more information about the issue](#review-the-logs-to-find-more-information-about-the-issue).

### Event ID 1046

> Cluster IP address resource '%1' cannot be brought online because the subnet mask value is invalid.
>
> In a cluster, an IP Address resource is important because in most cases, other resources (such as a Network Name resource) depend on it. An IP Address resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

### Event ID 1047

> Cluster IP address resource '%1' cannot be brought online because the address value is invalid.
>
> In a cluster, an IP Address resource is important because in most cases, other resources (such as a Network Name resource) depend on it. An IP Address resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

### Event ID 1048

> Cluster IP address resource '%1' failed to come online.
>
> In a cluster, an IP Address resource is important because in most cases, other resources (such as a Network Name resource) depend on it. An IP Address resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

### Event ID 1049

> Cluster IP address resource '%1' cannot be brought online because a duplicate IP address '%2' was detected on the network.
>
> In a cluster, an IP Address resource is important because in most cases, other resources (such as a Network Name resource) depend on it. An IP Address resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

### Event ID 1078

> Cluster IP address resource '%1' cannot be brought online because WINS registration failed on interface '%2' with error '%3'.
>
> In a cluster, an IP Address resource is important because in most cases, other resources (such as a Network Name resource) depend on it. An IP Address resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

This event indicates that there's a problem with the Windows Internet Name Service (WINS) configuration.

### Event ID 1223

> Cluster IP address resource '%1' cannot be brought online because the cluster network '%2' is not configured to allow client access.
>
> In a cluster, an IP Address resource is important because in most cases, other resources (such as a Network Name resource) depend on it. An IP Address resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.
>
> Cluster networks are automatically created for all logical subnets connected to all nodes in the Cluster.  Each network adapter card connected to a common subnet will be listed in Failover Cluster Manager. Cluster networks can be configured for different uses.

### Check the role that is configured for a cluster network

For Event ID 1046, 1047, 1048, 1049, 1078, and 1223, follow these steps:

1. In **Failover Cluster Manager**, if the cluster you want to configure isn't displayed, in the console tree, right-click **Failover Cluster Manager**, select **Manage a Cluster**, and then select or specify the cluster that you want.

2. If the console tree is collapsed, expand the tree under the cluster that you want to configure.

3. Expand **Networks**.

4. Right-click the network that you want to check settings for and select **Properties**.

5. If you want to use this network for the cluster, make sure that the **Allow the cluster to use this network** option is selected. If you select this option and want the network to be used by clients (not just the nodes), make sure that the **Allow clients to connect through this network** option is selected.

If you change any of the settings, try to bring the resource online again before you proceed.

### Event ID 1360

> Cluster IP address resource '%1' failed to come online.
>
> A failover cluster requires network connectivity among nodes and between clients and nodes. Problems with a network adapter or other network device (either physical problems or configuration problems) can interfere with connectivity.

### Event ID 1361

> IPv6 Tunnel address resource '%1' failed to come online because it does not depend on an IP Address (IPv4) resource.
>
> In a cluster, an IP Address resource is important because in most cases, other resources (such as a Network Name resource) depend on it. An IP Address resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

This event indicates that the correct dependencies aren't configured for the IPv6 Tunnel Address resource.

### Event ID 1362

> Cluster IP address resource '%1' failed to come online because the '%2' property could not be read.
>
> In a cluster, an IP Address resource is important because in most cases, other resources (such as a Network Name resource) depend on it. An IP Address resource can come online only if it is configured correctly, and is supported correctly by available networks and network configurations.

### Review the logs to find more information about the issue

For Event ID 1360, 1361, and 1362, follow these steps:

1. Use Event Viewer to review the application and system logs.

   > [!NOTE]
   > In particular, search for any events related to domain controller functionality.

2. To search for information about an error code, use one of the following methods:

   - See [system error codes](/windows/win32/debug/system-error-codes).

   - At a command prompt, run the following command:

     ```console
     NET HELPMSG <Code>
     ```

     > [!NOTE]
     > The placeholder \<Code> represents the error code.

3. Generate a fresh cluster log and review it. To generate a fresh cluster log, reproduce the issue and open an elevated PowerShell prompt. At the elevated PowerShell prompt, run the following cmdlet:

   `Get-ClusterLog -Destination C:\temp\ -TimeSpan 5 -UseLocalTime`

If you identify an issue that you can fix, fix it and try to start the affected clustered resource again.
