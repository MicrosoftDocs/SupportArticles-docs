---
title: Can't delete a virtual network or subnet in Azure
description: Learn how to troubleshoot problems that prevent you from deleting or modifying a virtual network or subnet in Azure and resolve blocking resources now.
services: virtual-network
author: asudbring
ms.author: allensu
manager: dcscontentpm
ms.service: azure-virtual-network
ms.topic: troubleshooting
ms.date: 03/17/2026
ms.custom:
  - sap:Cannot delete Azure Virtual Network (VNet),fasttrack-edit,sfi-image-nochange

# Customer intent: As a cloud administrator, I want to troubleshoot problems that prevent the deletion or modification of a virtual network or subnet, so I can resolve blocking resource dependencies and maintain my cloud resources.
---

# Troubleshoot failure to delete or modify a virtual network or subnet in Azure

## Summary

You might receive errors when you try to delete or modify a virtual network or subnet in Microsoft Azure. Resources like gateways, private endpoints, service endpoints, subnet delegations, and orphaned network interfaces can block deletion or modification. This article provides troubleshooting steps to help you resolve these problems.

## Troubleshoot virtual network and subnet issues

### Virtual network deletion

1. [Check whether a virtual network gateway is running in the virtual network](#check-whether-a-virtual-network-gateway-is-running-in-the-virtual-network).
2. [Check whether an application gateway is running in the virtual network](#check-whether-an-application-gateway-is-running-in-the-virtual-network).
3. [Check whether Azure container instances still exist in the virtual network](#check-whether-azure-container-instances-still-exist-in-the-virtual-network).
4. [Check whether Microsoft Entra Domain Services is enabled in the virtual network](#check-whether-microsoft-entra-domain-services-is-enabled-in-the-virtual-network).
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

To remove the virtual network, first remove the virtual network gateway.

For classic virtual networks, go to the **Overview** page of the classic virtual network in the [Azure portal](https://portal.azure.com). In the **VPN connections** section, if the gateway runs in the virtual network, the IP address of the gateway appears. 

:::image type="content" source="media/virtual-network-troubleshoot-cannot-delete-vnet/classic-gateway.png" alt-text="Screenshot of a classic gateway to determine whether gateway is running." lightbox="media/virtual-network-troubleshoot-cannot-delete-vnet/classic-gateway.png":::

For virtual networks, go to the **Overview** page of the virtual network. Check **Connected devices** for the virtual network gateway.

:::image type="content" source="media/virtual-network-troubleshoot-cannot-delete-vnet/vnet-gateway.png" alt-text="Screenshot of the list of Connected devices for a virtual network in Azure portal. The Virtual network gateway is highlighted in the list." lightbox="media/virtual-network-troubleshoot-cannot-delete-vnet/vnet-gateway.png":::

Before you can remove the gateway, remove any **Connection** objects in the gateway. 

### Check whether an application gateway is running in the virtual network

Go to the **Overview** page of the virtual network. Check the **Connected devices** for the application gateway.

:::image type="content" source="media/virtual-network-troubleshoot-cannot-delete-vnet/app-gateway.png" alt-text="Screenshot of the list of Connected devices for a virtual network in Azure portal. The Application gateway is highlighted in the list." lightbox="media/virtual-network-troubleshoot-cannot-delete-vnet/app-gateway.png":::

If there's an application gateway, you must remove it before you can delete the virtual network.

### Check whether Azure Container Instances still exist in the virtual network

> [!NOTE]
> As of the Azure Container Instances API version `2021-07-01`, Azure Container Instances no longer use network profiles. If you use this or a more recent API version, the portal doesn't create network profiles. The following guidance applies only to legacy deployments that use an older API version.

1. In the Azure portal, go to the resource group's **Overview** page.
1. In the header for the list of the resource group's resources, select **Show hidden types**. The portal hides the network profile type by default.
1. Select the network profile related to the container groups.
1. Select **Delete**.

   :::image type="content" source="media/virtual-network-troubleshoot-cannot-delete-vnet/container-instances.png" alt-text="Screenshot of the list of hidden network profiles." lightbox="media/virtual-network-troubleshoot-cannot-delete-vnet/container-instances.png":::

1. Delete the subnet or virtual network again.

If these steps don't resolve the issue, use these [Azure CLI commands](/azure/container-instances/container-instances-vnet#clean-up-resources) to clean up resources. 

<a name='check-whether-azure-active-directory-domain-service-is-enabled-in-the-virtual-network'></a>

### Check whether Microsoft Entra Domain Services is enabled in the virtual network

If Microsoft Entra Domain Services is enabled and connected to the virtual network, you can't delete this virtual network.

To delete the managed domain, see [Delete a Microsoft Entra Domain Services managed domain](/entra/identity/domain-services/delete).

### Check whether the virtual network is connected to other resources

Check for circuit links, connections, and virtual network peerings. Any of these resources can cause a virtual network deletion to fail. 

Use the following recommended deletion order:

1. Gateway connections
2. Gateways
3. IPs
4. Virtual network peerings
5. App Service Environment (ASE)

### Check whether a virtual machine is still running in the virtual network

Make sure that no virtual machine is in the virtual network.

### Check whether the virtual network is stuck in migration

If the virtual network is stuck in a migration state, you can't delete it. Run the following command in Azure PowerShell to abort the migration and then delete the virtual network.

```azurepowershell
Move-AzureVirtualNetwork -VirtualNetworkName "Name" -Abort
```

### Check whether the virtual network was used by a web app for virtual network integration

If you integrated the virtual network with a web app in the past, but you deleted the web app without disconnecting the virtual network integration, see [Deleting the App Service plan or web app before disconnecting the virtual network integration](/azure/azure-functions/functions-networking-options?tabs=azure-portal#troubleshooting).

## Troubleshoot subnet deletion failures

### Check whether private endpoints exist in the subnet

If a subnet has private endpoints, you can't delete the subnet. You need to remove all private endpoints before you delete the subnet.

1. In the Azure portal, go to the virtual network and select **Subnets**.
2. Select the subnet you want to delete and check the **Private endpoints** column.
3. If private endpoints exist, go to each private endpoint resource and delete it.

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

Service endpoints are subnet-level configurations and don't block subnet deletion. As stated in the [Azure Virtual Network FAQ](/azure/virtual-network/virtual-networks-faq), you can delete a subnet even when service endpoints are turned on.

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

A subnet delegation assigns the subnet to a specific Azure service, like `Microsoft.DBforPostgreSQL/flexibleServers`, `Microsoft.Web/serverFarms`, or `Microsoft.ContainerService/managedClusters`. You can't delete a delegated subnet until you remove all resources that use the delegation and then remove the delegation itself.

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

To remove a delegation, first delete all resources that use the delegated subnet. Then remove the delegation by using the following command:

```azurecli
az network vnet subnet update \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --remove delegations
```

### Check whether service association links exist on the subnet

Azure services like Azure Container Instances, Azure App Service, and Azure SQL Managed Instance create service association links when they deploy resources into a subnet. These links prevent deletion of the subnet even after you remove the deployed resources.

Use Azure CLI to check for service association links:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "serviceAssociationLinks[].{link:link, linkedResourceType:linkedResourceType}" \
    --output table
```

If service association links remain after you delete the resources, they might take several minutes to clear. If they persist, try the following steps:

1. Verify no resources from the linked service are still deployed in the subnet.
2. Wait 10-15 minutes for the platform to clean up the links.
3. If the links still persist, open an Azure support request referencing the specific `linkedResourceType`.

For Azure Container Instances specifically, see [Clean up resources](/azure/container-instances/container-instances-vnet#clean-up-resources) for CLI commands to remove container groups and network profiles.

### Check whether orphaned network interfaces remain in the subnet

Network interfaces (NICs) left behind after you delete a virtual machine or other resource can block subnet deletion. You must remove each NIC with an IP configuration in the subnet.

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

**For Azure Bastion:**

1. In the Azure portal, search for **Bastions** and find the Bastion resource in the same virtual network.
2. Delete the Azure Bastion resource.
3. After the deletion finishes, delete the `AzureBastionSubnet`.

**For Azure Firewall:**

1. In the Azure portal, search for **Firewalls** and find the Firewall resource.
2. Deallocate or delete the Azure Firewall resource.
3. After the deallocation or deletion finishes, delete the `AzureFirewallSubnet`.
4. Use Azure CLI to check connected resources:

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

You can resize a subnet that has active resources if the new address range still includes all existing IP addresses. If the new range excludes an IP address in use, the resize operation fails.

Before you resize:

1. Use Azure CLI to check the number of used IP addresses in the subnet.

    ```azurecli
    az network vnet subnet show \
        --resource-group <resource-group> \
        --vnet-name <vnet-name> \
        --name <subnet-name> \
        --query "ipConfigurations | length(@)"
    ```

2. Verify the new address prefix accommodates all assigned addresses.
3. Update the subnet.

    ```azurecli
    az network vnet subnet update \
        --resource-group <resource-group> \
        --vnet-name <vnet-name> \
        --name <subnet-name> \
        --address-prefixes <new-prefix>
    ```

> [!NOTE]
> Azure reserves five IP addresses within each subnet: the first four addresses and the last address. When resizing, account for these reserved addresses and your current allocations.

### Change or remove a subnet delegation

You can't change a subnet delegation while resources from the current delegation are deployed. To change the delegation:

1. Remove all resources that use the current delegation (for example, delete the flexible server or app service plan).
2. Use Azure CLI to remove the existing delegation.

    ```azurecli
    az network vnet subnet update \
        --resource-group <resource-group> \
        --vnet-name <vnet-name> \
        --name <subnet-name> \
        --remove delegations
    ```

3. Add the new delegation.

    ```azurecli
    az network vnet subnet update \
        --resource-group <resource-group> \
        --vnet-name <vnet-name> \
        --name <subnet-name> \
        --delegations <new-service-delegation>
    ```

### Add or remove service endpoints on an active subnet

Changing service endpoints on an active subnet can cause a brief connectivity disruption to the target service. Plan endpoint changes during a maintenance window.

Use Azure CLI to add a service endpoint.

```azurecli
az network vnet subnet update \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --service-endpoints Microsoft.Storage Microsoft.Sql
```

To remove a specific service endpoint, specify only the endpoints you want to keep.

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
| `Subnet <name> is in use and cannot be deleted.` | Resources such as NICs, private endpoints, or service deployments are still in the subnet. | Use the [diagnostic commands](#diagnostic-commands) to identify blocking resources and remove them. |
| `InUseSubnetCannotBeDeleted` | The subnet contains IP configurations from VMs, load balancers, or other resources. | Remove or move the resources to another subnet and then retry the deletion. |
| `SubnetHasServiceEndpoints` | Service endpoints are configured on the subnet. | Service endpoints alone don't block subnet deletion. If this error occurs with other blocking resources, resolve those resources first. To remove service endpoints, see [Check whether service endpoints are configured on the subnet](#check-whether-service-endpoints-are-configured-on-the-subnet). |
| `SubnetHasDelegations` | The subnet is delegated to a service and resources from that service are deployed. | Remove the service resources that use the delegation and then remove the delegation. |
| `SubnetWithExternalResourcesCannotBeUsedByOtherResources` | Another Azure service has deployed resources in the subnet. | Identify the service by using service association links and remove the deployed resources. |
| `InUseNetworkInterfaceCannotBeAssociatedWithSubnet` | An orphaned NIC has an IP configuration that conflicts with subnet operations. | Delete the orphaned NIC and then retry the operation. |
| `SubnetIsDelegatedAndCannotBeUsed` | The subnet is already delegated to another service. | [Change or remove the delegation](#change-or-remove-a-subnet-delegation) before running a new service. |
| `Cannot delete virtual network <name> because it is in use by resource <id>.` | A resource is still attached to the VNet. | Follow the [virtual network deletion](#virtual-network-deletion) guidance to identify and remove the resource. |
| `NetworkProfileCannotBeDeleted` | A network profile used by Azure Container Instances still references the subnet. | See [Check whether Azure container instances still exist in the virtual network](#check-whether-azure-container-instances-still-exist-in-the-virtual-network) to resolve the problem. |

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

If any of these fields contain values, you must remove those resources before you can delete or modify the subnet.

## Next steps

- [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview)
- [Azure Virtual Network frequently asked questions (FAQ)](/azure/virtual-network/virtual-networks-faq)
