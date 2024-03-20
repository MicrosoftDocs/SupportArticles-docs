---
title: Fail to ping a Clustered Name that runs on Azure IaaS VMs
description: Discusses an issue in which you can't ping a Clustered Name that runs on Azure IaaS virtual machines. Provides a resolution.
ms.date: 07/21/2020
ms.reviewer: mariliu
ms.service: virtual-machines
ms.subservice: vm-common-errors-issues
---
# Error when you try to ping a Clustered Name that runs on Azure IaaS VMs: Request timed out

_Original product version:_ &nbsp; Load Balancer  
_Original KB number:_ &nbsp; 3190161

## Symptoms

Consider the following scenario:

- You set up a Windows Server Failover Cluster on Azure IaaS virtual machines (VMs).
- You configure cluster Network Name resources for the Cluster Name or client access points for applications.
- At a command prompt, you try to ping these IP addresses from VMs that do not currently own the cluster Network Name resources. In this scenario, you receive a "Request timed out" error message. This error suggests that Azure is experiencing a network problem.

## More information

This is expected behavior when Failover Cluster networking interacts with the Azure networking. Clustered IP address resources and their associated Network Name resource differ from a regular IP address. Clustered IP address resources have limited functions and do not respond to ping requests over ICMP.  
> [!NOTE]
> Due to this limitation, the cluster file share creation from non-active cluster nodes fails as the cluster requires to ping the network name before it allows any file share creation. The workaround is to try creating file share from active cluster nodes.

The IP address for Cluster Name is intended to be an endpoint for management of the cluster and is not for network communication. If the Cluster IP Address resource has an invalid IP address, it cannot be used for remote cluster management. Instead, you can manage the cluster locally by specifying a local connect that has a period (.) or by specifying a name for the node.

The IP address for a client access point is an Azure Load Balancer address. It's associated with endpoints or back-end pools in Azure that have specific ports that are used by clustered resources.

For more information, see the following Server & Management Team Blog article: [Building Windows Server Failover Cluster on Azure IAAS VM - Part 2 (Network and Creation)](https://blogs.technet.microsoft.com/askcore/2015/06/24/building-windows-server-failover-cluster-on-azure-iaas-vm-part-2-network-and-creation/)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
