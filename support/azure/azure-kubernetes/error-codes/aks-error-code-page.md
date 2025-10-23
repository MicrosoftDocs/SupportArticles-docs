---
title: Azure Kubernetes Service (AKS) Error Codes
description: List of common AKS error codes
ms.date: 10/23/2025
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.topic: error-reference
ms.reviewer: v-ryanberg, chiragpa, albarqaw
ms.service: azure-kubernetes-service
ms.custom: sap:AKS error codes, AKS errors
---
# Azure Kubernetes Service (AKS) error codes

This article describes common AKS errors and how to resolve them.

## A-K error codes

| **Error code** | **Description** | **Details and mitigation** |
| --- | ---------- | ----------------- |
| AADSTS7000222 - BadRequest or InvalidClientSecret | Authentication failure with Azure Active Directory. | This involves invalid or expired service principal credentials. For more information, see [AADSTS7000222 - BadRequest or InvalidClientSecret error](../create-upgrade-delete/error-code-badrequest-or-invalidclientsecret.md). |
| Argument list too long | Application fails due to command line argument limitations. | The command line arguments exceed system limits in containerized applications. For more information, see [Application failures caused by the "argument list too long" error message](../create-upgrade-delete/application-fails-argument-list-too-long.md). |
| AksCapacityHeavyUsage | Insufficient capacity in the Azure region. | There's high demand or limited resources in the selected region. For more information, see [Troubleshoot the AksCapacityHeavyUsage error code](akscapacityheavyusage-error.md). |
| AKSOperationPreempted | Cluster operation is interrupted by a higher priority operation. | There are concurrent operations on the cluster, causing conflicts. For more information, see [AKSOperationPreempted or AKSOperationPreemptedByDelete error when performing a new operation](aksoperationpreempted-error.md). |
| AKS upgrade blocked | Upgrade fails due to version compatibility issues. | There's version skew, incompatibility, or an unsupported upgrade path. For more information, see [Troubleshoot AKS upgrade errors because of version skew, incompatibility, or lack of support](aks-upgrade-blocked.md). |
| AvailabilityZoneNotSupported | Selected availability zone isn't supported. | the virtual machine (VM) size or region doesn't support the specified availability zone. For more information, see [Troubleshoot the AvailabilityZoneNotSupported error code](availabilityzonenotsupported-error.md). |
| BadRequest or InvalidClientSecret | Authentication or request validation failed. | This involves an invalid service principal credentials or a malformed request. For more information, see [Error AADSTS7000222 - BadRequest or InvalidClientSecret](bad-request-or-invalid-client-secret-error.md). |
| CannotDeleteLoadBalancerWithPrivateLinkService or PrivateLinkServiceWithPrivateEndpointConnectionsCannotBeDeleted | Unable to delete load balancer with active private link connections. | The load balancer has active private endpoint connections that must be removed first. For more information, see [Cluster autoscaler fails to scale with "cannot scale cluster autoscaler enabled node pool" error](lb-pvtlinksvcwithpvtendptconn-error.md). |
| Can't scale cluster autoscaler-enabled node pool |Manual scaling conflicts with autoscaler. | This happens when attempting a manual scaling on a node pool with autoscaler enabled. For more information, see [A load balancer with a private link service or a private link service with private endpoint connections cannot be deleted](../create-upgrade-delete/cannot-scale-cluster-autoscaler-enabled-node-pool.md). |
| Changing property "imageReference" is not allowed | Unable to modify the VM image reference. | This happens when attempting to change immutable VM properties on existing nodes. For more information, see ["Changing property 'imageReference' is not allowed" error message while upgrading or scaling an AKS cluster](../create-upgrade-delete/changing-property-imagereference-not-allowed.md). |
| CniDownloadTimeoutVMExtensionError (41) | Container Network Interface (CNI) download times out. | There are network connectivity issues preventing the CNI plugin download. For more information, see [Troubleshoot Container Network Interface download failures](../create-upgrade-delete/error-code-cnidownloadtimeoutvmextensionerror.md). |
| CreateOrUpdateVirtualNetworkLinkFailed | Failed to create or update DNS zone virtual network link. | Insufficient permissions or networking conflicts with private DNS zones. For more information, see [CreateOrUpdateVirtualNetworkLinkFailed error when updating or upgrading an AKS cluster](createorupdatevirtualnetworklinkfailed-error.md). |
| CustomPrivateDNSZoneMissingPermissionError | Permissions missing for custom private DNS zone. | The service principal lacks required permissions on the private DNS zone. For more information, see [Troubleshoot the CustomPrivateDNSZoneMissingPermissionError error code](customprivatednszonemissingpermissions-error.md). |
| DnsServiceIpOutOfServiceCidr | DNS service IP is outside the service CIDR range. | The configured DNS service IP doesn't fall within the Kubernetes service CIDR. For more information, see [Troubleshoot the DnsServiceIpOutOfServiceCidr error code](dnsserviceipoutofservicecidr-error.md). |
| ERR_VHD_FILE_NOT_FOUND (65) | Virtual hard disk file not found during provisioning. | The node image virtual hard disk is unavailable or inaccessible. For more information, see [Troubleshoot the ERR_VHD_FILE_NOT_FOUND error code (65)](../create-upgrade-delete/error-code-vhdfilenotfound.md). |
| Error from server - error dialing backend - dial tcp | API server connectivity issues. | There are network connectivity problems between components and the API server. For more information, see ["Error from server: error dialing backend: dial tcp" message](../connectivity/error-from-server-error-dialing-backend-dial-tcp.md). |
| Failed to fix node group sizes | Cluster autoscaler unable to reconcile node pool sizes. | There are autoscaler configuration issues or Azure API failures. For more information, see [Cluster autoscaler fails to scale with "failed to fix node group sizes" error](../create-upgrade-delete/cluster-autoscaler-fails-to-scale.md). |
| InsufficientSubnetSize | Subnet has insufficient IP addresses. | There aren't enough available IPs in the subnet for the requested nodes. For more information, see [InsufficientSubnetSize error code](../connectivity/insufficientsubnetsize-error-advanced-networking.md). |
| InUseRouteTableCannotBeDeleted | Route table is in use and can't be deleted. | The route table is associated with subnets and must be disassociated. For more information, see [Troubleshoot InUseRouteTableCannotBeDeleted error code](inuseroutetablecannotbedeleted-error.md). |
| InvalidLoadBalancerProfileAllocatedOutboundPorts | Invalid outbound port allocation in load balancer profile. | The outbound port configuration exceeds limits or is invalid. For more information, see [InvalidLoadBalancerProfileAllocatedOutboundPorts error when creating or updating an AKS cluster](invalidloadbalancerprofileallocatedoutboundports-error.md). |
| InvalidParameter | One or more parameters are invalid. | The request contains invalid or conflicting parameter values. For more information, see [Troubleshoot the InvalidParameter error](invalidparameter-error.md). |
| InvalidResourceReference | Referenced resource is invalid or inaccessible. | The resource ID is malformed or the resource doesn't exist. For more information, see [Troubleshoot the InvalidResourceReference error code](invalidresourcereference-error.md). |
| K8SAPIServerConnFailVMExtensionError (51) | Node can't connect to Kubernetes API server. | Network connectivity or a firewall is blocking API server access. For more information, see [Troubleshoot the K8SAPIServerConnFailVMExtensionError error code (51)](../create-upgrade-delete/error-code-k8sapiserverconnfailvmextensionerror.md). |
| K8SAPIServerDNSLookupFailVMExtensionError (52) | DNS lookup for API server failed. | DNS resolution issues prevent API server discovery. For more information, see [Troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (52)](../create-upgrade-delete/error-code-k8sapiserverdnslookupfailvmextensionerror.md). |
| Known issues - Custom kubelet configuration on Windows | Issues with custom kubelet settings on Windows nodes. | There are specific limitations and issues with Windows node kubelet customization. For more information, see [Known issues: Custom kubelet configuration on Windows nodes in AKS](/create-upgrade-delete/known-issues-custom-kubelet-configuration.md). |
|  |  |

## L-S error codes

| **Error code** | **Description** | **Details and mitigation** |
| --- | ---------- | ----------------- |
| LB/PvtLinkSvcWithPvtEndptConn deletion error | Can't delete resources with active private endpoint connections. | Private link services have active connections that prevent deletion. For more information, see [A load balancer with a private link service or a private link service with private endpoint connections can't be deleted](../create-upgrade-delete/cannot-delete-load-balancer-private-link-service.md). |
| LinkedAuthorizationFailed | Authorization fails for linked resources. | There are insufficient permissions for a resource in another subscription or a resource group. For more information, see [Troubleshoot the LinkedAuthorizationFailed error code](linkedauthorizationfailed-error.md). |
| LoadBalancerInUseByVirtualMachineScaleSet | Can't modify load balancer currently in use. | The load balancer is actively being used by VM scale sets. For more information, see [Troubleshoot the LoadBalancerInUseByVirtualMachineScaleSet or NetworkSecurityGroupInUseByVirtualMachineScaleSet error code](../create-upgrade-delete/load-balancer-or-nsg-in-use-by-vm-scale-set.md). |
| LoadBalancerInUseByVirtualMachineScaleSet or NetworkSecurityGroupInUseByVirtualMachineScaleSet | Network resources are in use by scale sets. | The load balancer or network security group (NSG) is attached to active VM scale sets. For more information, see [Troubleshoot LoadBalancerInUseByVirtualMachineScaleSet or NetworkSecurityGroupInUseByVirtualMachineScaleSet error code](networksecuritygroupinusebyvirtualmachinescaleset-error.md). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
|  |  |

## T-Z error codes

| **Error code** | **Description** | **Details and mitigation** |
| --- | ---------- | ----------------- |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
|  |  |

## References

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
