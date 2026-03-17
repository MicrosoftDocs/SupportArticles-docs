---
title: Can't delete a virtual network or subnet in Azure
description: Learn how to troubleshoot problems that prevent you from deleting or modifying a virtual network or subnet in Azure.
services: virtual-network
author: asudbring
ms.author: allensu
manager: dcscontentpm
ms.service: azure-virtual-network
ms.topic: troubleshooting
ms.date: 03/17/2026
ms.custom:
  - fasttrack-edit
  - sfi-image-nochange
  - sap:Connectivity
# Customer intent: As a cloud administrator, I want to troubleshoot problems that prevent the deletion or modification of a virtual network or subnet, so I can resolve blocking resource dependencies and maintain my cloud resources.
---

# Troubleshooting: Failed to delete or modify a virtual network or subnet in Azure

## Summary

You might receive errors when you try to delete or modify a virtual network or subnet in Microsoft Azure. Resources such as gateways, private endpoints, service endpoints, subnet delegations, and orphaned network interfaces can block deletion or modification. This article provides troubleshooting steps to help you resolve these problems.

If your Azure problem isn't addressed in this article, visit the Azure forums on [Microsoft Q & A](https://azure.microsoft.com/support/forums) and [Stack Overflow](https://stackoverflow.com/questions/tagged/azure). You can post in these forums, or post to [@AzureSupport](https://x.com/AzureSupport) on X. You also can submit an Azure support request. To submit a support request, on the [Azure support page](https://azure.microsoft.com/support), select **Get support**.

## Troubleshooting guidance

### Virtual network deletion

1. [Check whether a virtual network gateway is running in the virtual network](#check-whether-a-virtual-network-gateway-is-running-in-the-virtual-network).
2. [Check whether an application gateway is running in the virtual network](#check-whether-an-application-gateway-is-running-in-the-virtual-network).
3. [Check whether Azure container instances still exist in the virtual network](#check-whether-azure-container-instances-still-exist-in-the-virtual-network).
4. [Check whether Microsoft Entra Domain Services is enabled in the virtual network](#check-whether-azure-active-directory-domain-service-is-enabled-in-the-virtual-network).
5. [Check whether the virtual network is connected to other resources](#check-whether-the-virtual-network-is-connected-to-other-resources).
6. [Check whether a virtual machine is still running in the virtual network](#check-whether-a-virtual-machine-is-still-running-in-the-virtual-network).
7. [Check whether the virtual network is stuck in migration](#check-whether-the-virtual-network-is-stuck-in-migration).
8. [Check whether the virtual network was used by a web app for virtual network integration](#check-whether-the-virtual-network-was-used-by-a-web-app-for-virtual-network-integration).

### Subnet deletion

1. [Check whether private endpoints exist in the subnet](#check-whether-private-endpoints-exist-in-the-subnet).
2. [Check whether service endpoints are configured on the subnet](#check-whether-service-endpoints-are-configured-on-the-subnet).
3. [Check whether the subnet has a delegation](#check-whether-the-subnet-has-a-delegation).
4. [Check whether service association links exist on the subnet](#check-whether-service-association-links-exist-on-the-subnet).
5. [Check whether orphaned network interfaces remain in the subnet](#check-whether-orphaned-network-interfaces-remain-in-the-subnet).
6. [Check whether the subnet is used by Azure Bastion or Azure Firewall](#check-whether-the-subnet-is-used-by-azure-bastion-or-azure-firewall).

### Subnet modification

1. [Resize a subnet that contains active resources](#resize-a-subnet-that-contains-active-resources).
2. [Change or remove a subnet delegation](#change-or-remove-a-subnet-delegation).
3. [Add or remove service endpoints on an active subnet](#add-or-remove-service-endpoints-on-an-active-subnet).

## Troubleshooting steps

### Check whether a virtual network gateway is running in the virtual network

To remove the virtual network, you must first remove the virtual network gateway.

For classic virtual networks, go to the **Overview** page of the classic virtual network in the Azure portal. In the **VPN connections** section, if the gateway is running in the virtual network, the IP address of the gateway is shown. 

![Check whether gateway is running](media/virtual-network-troubleshoot-cannot-delete-vnet/classic-gateway.png)

For virtual networks, go to the **Overview** page of the virtual network. Check **Connected devices** for the virtual network gateway.

![Screenshot of the list of Connected devices for a virtual network in Azure portal. The Virtual network gateway is highlighted in the list.](media/virtual-network-troubleshoot-cannot-delete-vnet/vnet-gateway.png)

Before you can remove the gateway, first remove any **Connection** objects in the gateway. 

### Check whether an application gateway is running in the virtual network

Go to the **Overview** page of the virtual network. Check the **Connected devices** for the application gateway.

![Screenshot of the list of Connected devices for a virtual network in Azure portal. The Application gateway is highlighted in the list.](media/virtual-network-troubleshoot-cannot-delete-vnet/app-gateway.png)

If there's an application gateway, you must remove it before you can delete the virtual network.

### Check whether Azure container instances still exist in the virtual network

> [!NOTE]
> Network profiles have been retired as of the Azure Container Instances API version `2021-07-01`. If you're using this or a more recent API version, network profiles are no longer created. The following guidance applies only to legacy deployments that used an older API version.

1. In the Azure portal, go to the resource group's **Overview** page.
1. In the header for the list of the resource group's resources, select **Show hidden types**. The network profile type is hidden in the Azure portal by default.
1. Select the network profile related to the container groups.
1. Select **Delete**.

   ![Screenshot of the list of hidden network profiles.](media/virtual-network-troubleshoot-cannot-delete-vnet/container-instances.png)

1. Delete the subnet or virtual network again.

If these steps don't resolve the issue, use these [Azure CLI commands](/azure/container-instances/container-instances-vnet#clean-up-resources) to clean up resources. 

<a name='check-whether-azure-active-directory-domain-service-is-enabled-in-the-virtual-network'></a>

### Check whether Microsoft Entra Domain Services is enabled in the virtual network

If Microsoft Entra Domain Services is enabled and connected to the virtual network, you can't delete this virtual network.

To delete the managed domain, see [Delete a Microsoft Entra Domain Services managed domain](/entra/identity/domain-services/delete).

### Check whether the virtual network is connected to other resources

Check for Circuit Links, connections, and virtual network peerings. Any of these can cause a virtual network deletion to fail. 

The recommended deletion order is as follows:

1. Gateway connections
2. Gateways
3. IPs
4. Virtual network peerings
5. App Service Environment (ASE)

### Check whether a virtual machine is still running in the virtual network

Make sure that no virtual machine is in the virtual network.

### Check whether the virtual network is stuck in migration

If the virtual network is stuck in a migration state, it can't be deleted. Run the following command to abort the migration, and then delete the virtual network.

```azurepowershell
Move-AzureVirtualNetwork -VirtualNetworkName "Name" -Abort
```

### Check whether the virtual network was used by a web app for virtual network integration

If the virtual network was integrated with a web app in the past, then the web app was deleted without disconnecting the virtual network integration, see [Deleting the App Service plan or web app before disconnecting the virtual network integration](/azure/azure-functions/functions-networking-options?tabs=azure-portal#troubleshooting).

## Troubleshoot subnet deletion failures

### Check whether private endpoints exist in the subnet

Private endpoints associated with a subnet prevent deletion of the subnet. You must remove all private endpoints before you delete the subnet.

1. In the Azure portal, go to the virtual network and select **Subnets**.
2. Select the subnet you want to delete and check the **Private endpoints** column.
3. If private endpoints exist, navigate to each private endpoint resource and delete it.

Alternatively, use Azure CLI to identify private endpoints in a subnet:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "privateEndpoints[].id" \
    --output tsv
```

Remove each private endpoint:

```azurecli
az network private-endpoint delete \
    --resource-group <resource-group> \
    --name <private-endpoint-name>
```

### Check whether service endpoints are configured on the subnet

Service endpoints are subnet-level configurations and don't block subnet deletion by themselves. As stated in the [Azure Virtual Network FAQ](/azure/virtual-network/virtual-networks-faq), subnet deletion is supported even when service endpoints are turned on.

However, if you need to remove service endpoints as part of a broader cleanup or modification, use the following steps:

1. In the Azure portal, go to the virtual network and select **Subnets**.
2. Select the subnet and check the **Service endpoints** section.
3. Remove any configured service endpoints and select **Save**.

Use Azure CLI to check and remove service endpoints:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "serviceEndpoints[].service" \
    --output tsv
```

Remove service endpoints by updating the subnet:

```azurecli
az network vnet subnet update \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --service-endpoints '[]'
```

### Check whether the subnet has a delegation

A subnet delegation assigns the subnet to a specific Azure service (for example, `Microsoft.DBforPostgreSQL/flexibleServers`, `Microsoft.Web/serverFarms`, or `Microsoft.ContainerService/managedClusters`). A delegated subnet can't be deleted until you remove all resources that use the delegation and then remove the delegation itself.

Common subnet delegations include:

| Delegation | Service |
|---|---|
| `Microsoft.ContainerInstance/containerGroups` | Azure Container Instances |
| `Microsoft.DBforPostgreSQL/flexibleServers` | Azure Database for PostgreSQL - Flexible Server |
| `Microsoft.DBforMySQL/flexibleServers` | Azure Database for MySQL - Flexible Server |
| `Microsoft.Web/serverFarms` | Azure App Service / Azure Functions |
| `Microsoft.ContainerService/managedClusters` | Azure Kubernetes Service (AKS) |
| `Microsoft.Sql/managedInstances` | Azure SQL Managed Instance |
| `Microsoft.Network/dnsResolvers` | Azure DNS Private Resolver |
| `Microsoft.Netapp/volumes` | Azure NetApp Files |
| `Microsoft.ApiManagement/service` | Azure API Management |

Use Azure CLI to check delegation:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "delegations[].{name:name, service:serviceName}" \
    --output table
```

To remove a delegation, first delete all resources that use the delegated subnet. Then remove the delegation:

```azurecli
az network vnet subnet update \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --remove delegations
```

### Check whether service association links exist on the subnet

Service association links are created by Azure services (such as Azure Container Instances, Azure App Service, and Azure SQL Managed Instance) when they deploy resources into a subnet. These links prevent deletion even after the deployed resources are removed.

Use Azure CLI to check for service association links:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "serviceAssociationLinks[].{link:link, linkedResourceType:linkedResourceType}" \
    --output table
```

If service association links remain after you delete the resources, the links might take several minutes to clear. If they persist, try the following steps:

1. Verify no resources from the linked service are still deployed in the subnet.
2. Wait 10-15 minutes for the platform to clean up the links.
3. If the links still persist, open an Azure support request referencing the specific `linkedResourceType`.

For Azure Container Instances specifically, see [Clean up resources](/azure/container-instances/container-instances-vnet#clean-up-resources) for CLI commands to remove container groups and network profiles.

### Check whether orphaned network interfaces remain in the subnet

Network interfaces (NICs) left behind after a virtual machine or other resource is deleted can block subnet deletion. Each NIC with an IP configuration in the subnet must be removed first.

Use Azure CLI to list NICs in a subnet:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "ipConfigurations[].id" \
    --output tsv
```

The output shows the resource IDs of the IP configurations associated with the subnet. Extract the NIC name from the resource ID and delete the orphaned NIC:

```azurecli
az network nic delete \
    --resource-group <resource-group> \
    --name <nic-name>
```

If the NIC is still attached to a virtual machine, detach or delete the virtual machine first.

### Check whether the subnet is used by Azure Bastion or Azure Firewall

The `AzureBastionSubnet` and `AzureFirewallSubnet` subnets are reserved by their respective services. You can't delete these subnets while the associated Azure Bastion or Azure Firewall resource exists.

**Azure Bastion:**

1. In the Azure portal, search for **Bastions** and find the Bastion resource in the same virtual network.
2. Delete the Azure Bastion resource.
3. After the deletion completes, delete the `AzureBastionSubnet`.

**Azure Firewall:**

1. In the Azure portal, search for **Firewalls** and find the Firewall resource.
2. Deallocate or delete the Azure Firewall resource.
3. After the deallocation or deletion completes, delete the `AzureFirewallSubnet`.

Use Azure CLI to check connected resources:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name AzureBastionSubnet \
    --query "ipConfigurations[].id" \
    --output tsv
```

## Troubleshoot subnet modification failures

### Resize a subnet that contains active resources

You can resize a subnet that has active resources if the new address range still includes all existing IP addresses. If the new range excludes an IP address in use, the resize fails.

Before you resize:

1. Check the number of used IP addresses in the subnet:

    ```azurecli
    az network vnet subnet show \
        --resource-group <resource-group> \
        --vnet-name <vnet-name> \
        --name <subnet-name> \
        --query "ipConfigurations | length(@)"
    ```

2. Verify the new address prefix accommodates all assigned addresses.
3. Update the subnet:

    ```azurecli
    az network vnet subnet update \
        --resource-group <resource-group> \
        --vnet-name <vnet-name> \
        --name <subnet-name> \
        --address-prefixes <new-prefix>
    ```

> [!NOTE]
> Azure reserves 5 IP addresses within each subnet. The first four addresses and the last address are reserved. When resizing, account for these reserved addresses and your current allocations.

### Change or remove a subnet delegation

You can't change a subnet delegation while resources from the current delegation are deployed. To change the delegation:

1. Remove all resources that use the current delegation (for example, delete the flexible server or app service plan).
2. Remove the existing delegation:

    ```azurecli
    az network vnet subnet update \
        --resource-group <resource-group> \
        --vnet-name <vnet-name> \
        --name <subnet-name> \
        --remove delegations
    ```

3. Add the new delegation:

    ```azurecli
    az network vnet subnet update \
        --resource-group <resource-group> \
        --vnet-name <vnet-name> \
        --name <subnet-name> \
        --delegations <new-service-delegation>
    ```

### Add or remove service endpoints on an active subnet

Service endpoint changes on an active subnet can cause a brief connectivity disruption to the target service. Plan endpoint changes during a maintenance window.

To add a service endpoint:

```azurecli
az network vnet subnet update \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --service-endpoints Microsoft.Storage Microsoft.Sql
```

To remove a specific service endpoint, specify only the endpoints you want to keep:

```azurecli
az network vnet subnet update \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --service-endpoints Microsoft.Storage
```

> [!WARNING]
> Removing a service endpoint while resources depend on it can cause connectivity loss. Verify no active resources rely on the endpoint before you remove it.

## Common error messages

| Error message | Cause | Resolution |
|---|---|---|
| `Subnet <name> is in use and cannot be deleted.` | Resources (NICs, private endpoints, or service deployments) are still in the subnet. | Use the [diagnostic commands](#diagnostic-commands) to identify blocking resources and remove them. |
| `InUseSubnetCannotBeDeleted` | The subnet contains IP configurations from VMs, load balancers, or other resources. | Remove or move the resources to another subnet, then retry the deletion. |
| `SubnetHasServiceEndpoints` | Service endpoints are configured on the subnet. | Service endpoints alone don't block subnet deletion. If this error occurs with other blocking resources, resolve those resources first. To remove service endpoints, see [Check whether service endpoints are configured on the subnet](#check-whether-service-endpoints-are-configured-on-the-subnet). |
| `SubnetHasDelegations` | The subnet is delegated to a service and resources from that service are deployed. | Remove the service resources that use the delegation, then remove the delegation. |
| `SubnetWithExternalResourcesCannotBeUsedByOtherResources` | Another Azure service has deployed resources in the subnet. | Identify the service by using service association links and remove the deployed resources. |
| `InUseNetworkInterfaceCannotBeAssociatedWithSubnet` | An orphaned NIC has an IP configuration that conflicts with subnet operations. | Delete the orphaned NIC, then retry the operation. |
| `SubnetIsDelegatedAndCannotBeUsed` | The subnet is already delegated to another service. | [Change or remove the delegation](#change-or-remove-a-subnet-delegation) before running a new service. |
| `Cannot delete virtual network <name> because it is in use by resource <id>.` | A resource is still attached to the VNet. | Follow the [virtual network deletion](#virtual-network-deletion) guidance to identify and remove the resource. |
| `NetworkProfileCannotBeDeleted` | A network profile (used by Azure Container Instances) still references the subnet. | See [Check whether Azure container instances still exist in the virtual network](#check-whether-azure-container-instances-still-exist-in-the-virtual-network). |

## Diagnostic commands

Use the following Azure CLI command to get a comprehensive view of all resources and configurations that might block subnet deletion or modification:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "{addressPrefix:addressPrefix, delegations:delegations[].serviceName, serviceEndpoints:serviceEndpoints[].service, ipConfigurations:ipConfigurations[].id, privateEndpoints:privateEndpoints[].id, serviceAssociationLinks:serviceAssociationLinks[].linkedResourceType}" \
    --output json
```

This command returns:

- **addressPrefix**: The current address range of the subnet.
- **delegations**: Services the subnet is delegated to.
- **serviceEndpoints**: Configured service endpoints.
- **ipConfigurations**: NICs and other resources with IP addresses in the subnet.
- **privateEndpoints**: Private endpoints associated with the subnet.
- **serviceAssociationLinks**: Services that deployed resources into the subnet.

If any of these fields contain values, those resources must be addressed before the subnet can be deleted or modified.

## Next steps

- [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview)
- [Azure Virtual Network frequently asked questions (FAQ)](/azure/virtual-network/virtual-networks-faq)