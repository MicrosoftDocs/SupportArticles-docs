---
title: Cluster service fails to start troubleshooting guidance
description: Provides guidance for when a cluster service fails to start in a Windows-based failover cluster.
ms.date: 09/16/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:clustering and high availability\cluster service fails to start
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Cluster service fails to start troubleshooting guidance

## Troubleshooting checklist

### Check the ports that the cluster service uses

Make sure that the following ports are open to cluster traffic on any firewalls:

- Port 135: Remote procedure call (RPC) endpoint mapper or distributed component object model (DCOM).

- Port 135: RPC endpoint mapper over user datagram protocol (UDP).

- Port 3343: Cluster network driver.

- Port 445: Server message block (SMB).

- Port 139: NetBIOS session service.

- Ports in the range of 5000 to 5099: If Event ID 1721 is logged when you connect to a cluster as a cluster administrator, try opening the ports in this range (or other ports) to RPC traffic. The ports support communication through RPC unless you just type a period character (.).

  This issue can occur because the cluster service uses at least 100 ports for RPC communication. The number of ports available to the cluster service can become too small when other services use some of the necessary ports. These services might include Windows DNS service, Windows Internet Name service (WINS), or Microsoft SQL Server service.

- Ports in the range of 8011 to 8031: If firewalls separate the cluster nodes, you must open the ports in the range of 8011 to 8031 to internode RPC traffic. Otherwise, errors in the cluster log indicate that a sponsor node isn't available. These errors occur because there aren't enough ports available for RPC communication between a node that tries to join the cluster and a node that can sponsor that node.

For more information about how to configure a network and network ports for a cluster, see the following articles:

- [Enable a network for cluster use](/previous-versions/windows/it-pro/windows-server-2003/cc728293(v=ws.10))

- [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md#system-services-ports)

After you change the port settings, try to bring the node online again before you proceed.

### Run the cluster validation tool

1. Open the **Failover Cluster Manager** snap-in (*CluAdmin.msc*).

1. Select **Failover Cluster Manager** in the top left column.

1. Select **Validate Configuration**.

1. Type the name of each node in the cluster and select **Add** after each one.

1. When you add all nodes to the **Selected servers:** list, select **Next**.

1. Select **Run all tests (recommended)** > **Next** > **Next**.

1. Wait for the test to finish. When it completes, select **View Report**.

1. Review any test results that are labeled as **Failed** or **Warning**. This information can help you fix the issue.

1. To get a downloadable file, go to the *C:\Windows\Cluster\Reports* folder and open the Validation Report (*.MHT*) file.

   > [!NOTE]
   > In Windows Server 2016 and later versions, it's an *.HTM* file.

### Check the security policies that might affect the cluster node

In the Group Policy Object Editor, you can find these policy objects in *Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment*.

> [!NOTE]
> To access the local security policy settings, select **Start**, enter **local security policy**, and then select **Local Security Policy**.

- Ensure the list of accounts includes the accounts that run the cluster node. For more information, see [How to access this computer from the network](/windows/security/threat-protection/security-policy-settings/access-this-computer-from-the-network) and [Allow log on locally security policy setting](/windows/security/threat-protection/security-policy-settings/allow-log-on-locally).

- Ensure the list of accounts doesn't include local accounts. For more information, see [How to deny access to this computer from the network](/windows/security/threat-protection/security-policy-settings/deny-access-to-this-computer-from-the-network).

- Ensure the list of accounts and groups doesn't include the "Everyone" group. For more information, see [Deny log on locally security policy setting](/windows/security/threat-protection/security-policy-settings/deny-log-on-locally).

After you change the policy settings, try to bring the node online again before you proceed.

> [!NOTE]
> If the Group Policy setting **Allow Custom SSPs and APs to be loaded into LSASS** is set to **Disabled**, the Failover Cluster service (ClusSvc) fails to start correctly, and Event 7024 ("A specified authentication package is unknown") is logged. To fix this issue, remove this policy setting, or set it to **Disabled** on the domain controller and **Enabled** on member servers such as failover cluster nodes.

### Temporarily disable firewalls

Disable the firewall between the node and the rest of the cluster, and then try to bring the node online again. If the node still doesn't come online, the firewall might be the cause.

> [!IMPORTANT]
> Don't leave this change in place after you finish troubleshooting. After you use this change for testing, return these settings to the original configuration.

### Check the network hardware and software for issues

- Check the System event log for hardware or software errors that are related to the network adapters on this node.

- Check the network adapter, cables, and network configuration for the networks that connect the nodes.

- If you're teaming the network adapters, ensure that the teaming configuration is correct.

- Check hubs, switches, or bridges in the networks that connect the nodes.

### Review log files

To identify the source of the issue, review log information from multiple sources. For example:

- In Event Viewer, navigate to *Applications and Services Logs\Microsoft\Windows\FailoverClustering-Client\Diagnostic*, and review the Cluster API Debug Tracing logs.

- Generate a fresh cluster log for the node. On the server that runs the affected node, open an elevated PowerShell prompt and run the following cmdlet:

   `Get-ClusterLog -Node 'Local Node Name' -Destination c:\temp -UseLocalTime`

To generate a more detailed trace, follow these steps:

1. At an elevated PowerShell prompt, run the following cmdlet to start the trace:

   `logman create trace "base_cluster" -ow -o c:\base_cluster.etl -p "Microsoft-Windows-FailoverClustering-Client" 0xffffffffffffffff 0xff -nb 16 16 -bs 1024 -mode Circular -f bincirc -max 4096 -ets`

1. Reproduce the issue.

1. To stop the trace, run the following cmdlet:

   `Logman stop base_cluster.etl -ets`

1. To convert the trace, run the following cmdlet:

   `Netsh trace convert base_cluster.etl`

1. To generate a cluster log from the data, run the following cmdlet:

   `Get-ClusterLog -Node 'Local Node Name' -Destination c:\temp -UseLocalTime`

For more information about tracing and other issues to look out for, see [How to Troubleshoot Create Cluster Failures](https://techcommunity.microsoft.com/t5/failover-clustering/how-to-troubleshoot-create-cluster-failures/ba-p/371780).
