---
title: Troubleshoot subnet deletion and modification failures in Azure Virtual Network
description: Troubleshoot subnet deletion and modification failures in Azure Virtual Network, identify blocking dependencies, and use this guide to resolve issues quickly.
services: virtual-network
author: asudbring
ms.author: allensu
manager: dcscontentpm
ms.service: azure-virtual-network
ms.topic: troubleshooting
ms.date: 03/17/2026
ms.custom:
  - sap:Connectivity
# Customer intent: As a cloud administrator, I want to troubleshoot subnet deletion and modification failures so I can identify and remove blocking resource dependencies and maintain my virtual network configuration.
---

# Troubleshoot subnet deletion and modification failures in Azure Virtual Network

## Summary

Subnet deletion and modification failures in Azure Virtual Network can prevent you from deleting, modifying, or resizing subnets. Various Azure services deploy resources into subnets and create dependencies that block these operations. This article helps you identify blocking resources and resolve each scenario.

> [!TIP]
> For questions about how to delete a virtual network, see [Can't delete a virtual network or subnet in Azure](virtual-network-troubleshoot-cannot-delete-vnet.md).

## Diagnose blocking resources

Before you start troubleshooting, use the following Azure CLI command to get a comprehensive view of all resources and configurations that are blocking subnet deletion or modification:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "{addressPrefix:addressPrefix, delegations:delegations[].serviceName, serviceEndpoints:serviceEndpoints[].service, ipConfigurations:ipConfigurations[].id, privateEndpoints:privateEndpoints[].id, serviceAssociationLinks:serviceAssociationLinks[].linkedResourceType, natGateway:natGateway.id, networkSecurityGroup:networkSecurityGroup.id, routeTable:routeTable.id}" \
    --output json
```

Review the output to determine which resources or configurations are blocking your operation:

- **delegations**: Services the subnet is delegated to
- **serviceEndpoints**: Configured service endpoints
- **ipConfigurations**: NICs, load balancers, and other resources that have IP addresses in the subnet
- **privateEndpoints**: Private endpoint resources that are associated with the subnet
- **serviceAssociationLinks**: Services that deploy resources into the subnet

Use the corresponding sections in this article to resolve each type of blocking resource.

## Troubleshoot subnet deletion

### Private endpoints

If a subnet has private endpoints, you can't delete that subnet. To delete the subnet, first remove all private endpoints.

**Identify private endpoints**

Use Azure CLI to list private endpoints in the subnet:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "privateEndpoints[].id" \
    --output tsv
```

### Solution

Delete each private endpoint.

For Azure CLI:

```azurecli
az network private-endpoint delete \
    --resource-group <resource-group> \
    --name <private-endpoint-name>
```

In the [Azure portal](https://portal.azure.com):

1. Go to the virtual network, and select **Subnets**.
2. Select the subnet, and examine the **Private endpoints** column.
3. Go to each private endpoint resource, and delete it.

### Service endpoints

Service endpoints are subnet-level configurations that don't block subnet deletion by themselves. As stated in the [Azure Virtual Network FAQ](/azure/virtual-network/virtual-networks-faq), you can delete a subnet even if service endpoints are turned on.

However, if you have to remove service endpoints before you modify a subnet, or as part of a broader cleanup, use the following steps.

**Identify service endpoints**

Use Azure CLI to list service endpoints that are configured on the subnet. 

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "serviceEndpoints[].service" \
    --output tsv
```

### Solution

Remove service endpoints by updating the subnet.

For Azure CLI:

```azurecli
az network vnet subnet update \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --service-endpoints '[]'
```

In the Azure portal:

1. Go to the virtual network, and select **Subnets**.
2. Select the subnet, and locate the **Service endpoints** section.
3. Remove any configured service endpoints, and select **Save**.

> [!WARNING]
> If you remove a service endpoint while resources depend on it, connectivity loss might occur. Verify that no active resources rely on the endpoint before you remove it.

### Subnet delegations

A subnet delegation assigns the subnet to a specific Azure service. You can't delete a delegated subnet until you remove all resources that use the delegation, and then you remove the delegation itself.

**Common delegations and the services that create them:**

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
| `Microsoft.Databricks/workspaces` | Azure Databricks |
| `Microsoft.MachineLearningServices/workspaces` | Azure Machine Learning |

**Identify delegations:**

Use Azure CLI to list delegations on the subnet and the associated services:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "delegations[].{name:name, service:serviceName}" \
    --output table
```

### Solution

1. Delete all resources from the delegated service that you deployed in the subnet.
2. Use Azure CLI to remove the delegation:

    ```azurecli
    az network vnet subnet update \
        --resource-group <resource-group> \
        --vnet-name <vnet-name> \
        --name <subnet-name> \
        --remove delegations
    ```

### Service association links

Azure services, such as Azure Container Instances, Azure App Service, and Azure SQL Managed Instance, create service association links when they deploy resources into a subnet. These links prevent deletion of the subnet even after you remove the deployed resources.

**Identify service association links**

Use Azure CLI to list service association links on the subnet and the associated services:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "serviceAssociationLinks[].{link:link, linkedResourceType:linkedResourceType}" \
    --output table
```

### Solution

If service association links remain after you delete the resources:

1. Verify that no resources from the linked service are still deployed in the subnet.
2. Wait 10-15 minutes for the platform to clean up the links.
3. Retry the subnet deletion.
4. If the links persist, open an Azure support request that references the specific `linkedResourceType`.

For Azure Container Instances specifically, see [Clean up resources](/azure/container-instances/container-instances-vnet#clean-up-resources) for CLI commands to remove container groups and network profiles.

### Network profiles (Azure Container Instances)

> [!NOTE]
> Microsoft retired network profiles starting in Azure Container Instances API version `2021-07-01`. If you use this or a later API version, you can't create network profiles. The following guidance applies to only legacy deployments that use an older API version.

You create network profiles when you deploy Azure Container Instances into a virtual network. These profiles can remain after you delete container groups and block subnet deletion.

**Identify network profiles**

Use the Azure portal to find network profiles in the resource group:

1. In the Azure portal, go to the resource group's **Overview** page.
2. In the header for the list of the resource group's resources, select **Show hidden types**.
3. Look for network profile resources that are related to container groups.

### Solution

Use Azure CLI to delete the network profile, and then retry the subnet deletion:

```azurecli
az network profile delete \
    --resource-group <resource-group> \
    --name <network-profile-name>
```

If you can't delete the network profile, use these [Azure CLI commands](/azure/container-instances/container-instances-vnet#clean-up-resources) to clean up container instance resources.

### NICs and IP configurations

If you delete a virtual machine (VM) or other resource but keep the network adapters (NICs), you can't delete the subnet. You have to remove each NIC that has an IP configuration in the subnet.

**Identify NICs in the subnet**

Use Azure CLI to list NICs with IP configurations in the subnet:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "ipConfigurations[].id" \
    --output tsv
```

The output shows the resource IDs of the IP configurations that connect to the subnet. Get the NIC name from the resource ID.

### Solution

Use Azure CLI to delete orphaned NICs:

```azurecli
az network nic delete \
    --resource-group <resource-group> \
    --name <nic-name>
```

If the NIC is still attached to a virtual machine, detach or delete the virtual machine first.

### Azure Bastion and Azure Firewall

The `AzureBastionSubnet` and `AzureFirewallSubnet` are reserved subnets for their respective services. You can't delete these subnets while the associated Azure Bastion or Azure Firewall resource exists.

**Azure Bastion**

Use the Azure portal to delete the Azure Bastion resource, then delete the `AzureBastionSubnet`:

1. In the Azure portal, search for **Bastions**, and then locate the Bastion resource in the same virtual network.
2. Delete the Azure Bastion resource.
3. After the deletion finishes, delete `AzureBastionSubnet`.

Use Azure CLI to delete the Bastion resource:

```azurecli
az network bastion delete \
    --resource-group <resource-group> \
    --name <bastion-name>
```

**Azure Firewall**

Use the Azure portal to delete the Azure Firewall resource, and then delete the `AzureFirewallSubnet`L

1. In the Azure portal, search for **Firewalls**, and then locate the Firewall resource.
2. Deallocate or delete the Azure Firewall resource.
3. After the deallocation or deletion process finishes, delete `AzureFirewallSubnet`.

Use Azure CLI to delete the Firewall resource:

```azurecli
az network firewall delete \
    --resource-group <resource-group> \
    --name <firewall-name>
```

### SQL Managed Instance

Azure SQL Managed Instance uses a dedicated subnet that has a delegation of `Microsoft.Sql/managedInstances`. The managed instance deployment creates service association links and network intent policies that block subnet deletion.

> [!IMPORTANT]
> The process to delete a SQL Managed Instance can take several hours. Wait for the deletion to finish fully before you try to delete the subnet.

**Identify SQL Managed Instance in the subnet**

Use Azure CLI to check for SQL Managed Instance delegations and service association links in the subnet:

```azurecli
az network vnet subnet show \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --query "{delegations:delegations[].serviceName, serviceAssociationLinks:serviceAssociationLinks[].linkedResourceType}" \
    --output json
```

Look for `Microsoft.Sql/managedInstances` in the delegations and service association links.

### Solution

1. Delete the SQL Managed Instance from the Azure portal or by using Azure CLI.
2. Wait for the deletion to fully finish (check the resource group for status). After the instance is deleted, the service association links and network intent policies clear automatically.
4. Remove the delegation, and then delete the subnet.

### Azure Virtual Network Gateway subnets

The `GatewaySubnet` is a reserved subnet that's used by Azure VPN Gateway and Azure ExpressRoute gateway. You can't delete this subnet while a virtual network gateway exists.

**Identify the gateway**

Use Azure CLI to check for virtual network gateways that use the `GatewaySubnet`:

```azurecli
az network vnet-gateway list \
    --resource-group <resource-group> \
    --query "[?contains(ipConfigurations[].subnet.id, '<vnet-name>')].{name:name, gatewayType:gatewayType}" \
    --output table
```

### Solution

1. Use Azure CLI to delete any **connections** that are associated with the gateway:

    ```azurecli
    az network vpn-connection delete \
        --resource-group <resource-group> \
        --name <connection-name>
    ```

2. Delete the virtual network gateway:

    ```azurecli
    az network vnet-gateway delete \
        --resource-group <resource-group> \
        --name <gateway-name>
    ```

3. After the gateway is deleted, delete `GatewaySubnet`.

## Troubleshoot subnet modification failures

### Resize a subnet that has active resources

You can resize a subnet that has active resources if the new address range still includes all existing IP addresses. If the new range excludes an IP address in use, the resize operation fails.

**Before you resize**

1. Use Azure CLI to check the number of used IP addresses in the subnet:

    ```azurecli
    az network vnet subnet show \
        --resource-group <resource-group> \
        --vnet-name <vnet-name> \
        --name <subnet-name> \
        --query "ipConfigurations | length(@)"
    ```

2. Verify that the new address prefix accommodates all assigned addresses.
3. Update the subnet.

    ```azurecli
    az network vnet subnet update \
        --resource-group <resource-group> \
        --vnet-name <vnet-name> \
        --name <subnet-name> \
        --address-prefixes <new-prefix>
    ```

> [!NOTE]
> Azure reserves five IP addresses within each subnet. This group includes the first four addresses and the last address. When you resize a subnet, account for these reserved addresses and your current allocations.

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

If you change service endpoints on an active subnet, this activity can cause a brief connectivity disruption to the target service. Plan endpoint changes to occur during a maintenance window.

**Add a service endpoint**

Use Azure CLI to add a service endpoint to the subnet:

```azurecli
az network vnet subnet update \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --service-endpoints Microsoft.Storage Microsoft.Sql
```

**Remove a specific service endpoint**

To remove a specific service endpoint, specify only the endpoints that you want to keep.

Use Azure CLI to remove a specific service endpoint from the subnet:

```azurecli
az network vnet subnet update \
    --resource-group <resource-group> \
    --vnet-name <vnet-name> \
    --name <subnet-name> \
    --service-endpoints Microsoft.Storage
```

> [!WARNING]
> If you remove a service endpoint while resources depend on it, this change can cause connectivity loss. Verify that no active resources rely on the endpoint before you remove that endpoint.

## Common error messages

| Error message | Cause | Resolution |
|---|---|---|
| `Subnet <name> is in use and cannot be deleted.` | Resources such as network adapters, private endpoints, and service deployments are still in the subnet. | Use the [diagnostic command](#diagnose-blocking-resources) to identify and remove blocking resources. |
| `InUseSubnetCannotBeDeleted` | The subnet contains IP configurations from VMs, load balancers, or other resources. | Remove or move the resources to another subnet, then retry the deletion. |
| `SubnetHasServiceEndpoints` | Service endpoints are configured on the subnet. | Service endpoints alone don't block subnet deletion. If this error is related to other blocking resources, resolve those resources first. To remove service endpoints, see [Service endpoints](#service-endpoints). |
| `SubnetHasDelegations` | The subnet is delegated to a service and resources from that service are deployed. | [Remove delegated resources and the delegation](#subnet-delegations). |
| `SubnetWithExternalResourcesCannotBeUsedByOtherResources` | Another Azure service deployed resources in the subnet. | Identify the service by using [service association links](#service-association-links), and remove the deployed resources. |
| `InUseNetworkInterfaceCannotBeAssociatedWithSubnet` | An orphaned NIC has an IP configuration that conflicts with subnet operations. | [Delete the orphaned network adapter](#nics-and-ip-configurations), and retry the operation. |
| `SubnetIsDelegatedAndCannotBeUsed` | The subnet is already delegated to another service. | [Change or remove the delegation](#change-or-remove-a-subnet-delegation) before deploying a new service. |
| `NetworkProfileCannotBeDeleted` | A network profile (that's used by Azure Container Instances) still references the subnet. | See [Network profiles](#network-profiles-azure-container-instances). |

## Recommended deletion order

When you clean up a subnet that has multiple blocking resources, delete the resources in the following order:

1. Virtual machines and their network adapters
2. Private endpoints
3. Service deployments (Container Instances, App Service, flexible servers)
4. Service association links (wait for cleanup)
5. Service endpoints
6. Subnet delegation
7. Subnet

## Next steps

- [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview)
- [Azure Virtual Network frequently asked questions (FAQ)](/azure/virtual-network/virtual-networks-faq)
- [Can't delete a virtual network or subnet in Azure](virtual-network-troubleshoot-cannot-delete-vnet.md)
