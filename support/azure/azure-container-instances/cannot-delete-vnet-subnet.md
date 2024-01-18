---
title: Can't delete a virtual network or subnet used by ACI
description: Discusses how to troubleshoot failures when you delete a virtual network or subnet used by Azure Container Instances (ACI).
ms.date: 01/18/2024
ms.service: container-instances
ms.reviewer: tysonfreeman, v-weizhu
---

# Failed to delete a virtual network or subnet used by Azure Container Instances

This article discusses errors that occur when you delete a virtual network (VNet) or subnet used by Azure Container Instances (ACI) and provides workarounds for them.

## Symptoms

When you delete a subnet used by ACI, you receive errors that resemble the following ones:

```output
Failed to delete subnet '<subnet-name>'.
Error: 'Subnet /subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name> requires any of the following delegations
[Microsoft.ContainerInstance/containerGroups] to reference service association link /
subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name>/serviceAssociationLinks/acisal.'
```

```output
Subnet <subnet-name> is in use by /subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.Network/networkProfiles/aci-network-profile-<network-profile-name>/containerNetworkInterfaceConfigurations/eth0/ipConfigurations/ipconfigprofile and cannot be deleted. 
In order to delete the subnet, delete all the resources within the subnet. See aka.ms/deletesubnet.
```

```output
Failed to delete subnet '<subnet-name>'. 
Error: Subnet <subnet-name> is in use by /subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.Network/networkProfiles/aci-network-profile-<network-profile-name>/containerNetworkInterfaceConfigurations/eth0/ipConfigurations/ipconfigprofile/aci-network-profile-<network-profile-name>/eth0/ipconfigprofile and cannot be deleted. 
In order to delete the subnet, delete all the resources within the subnet. See aka.ms/deletesubnet.
```

When you delete a VNet used by ACI, you receive the following error:

```output
Failed to delete virtual network '<vnet-name>'. 
Error: 'Subnet /subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name> requires any of the following delegations [Microsoft.ContainerInstance/containerGroups] to reference service association link 
/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name>/serviceAssociationLinks/acisal.'
```

## Cause 1: A Service Association Link blocks the deletion of the VNET/subnet

The subnet delegation required by ACI must reference a residual Service Association Link, which prevents the deletion of the VNet or subnet used by ACI.

## Workaround 1 for cause 1: Delete the Service Association Link

1. Navigate to the subnet in the Azure portal.
2. Change the subnet delegation to **None**.
3. Delete network profiles using the `az network profile delete` command to make sure that no network profiles are linked to the subnet.
4. If the command in step 3 fails, there might be a lingering network profile. To delete a lingering network profile, use the following command:

    ```azurecli
    az network profile delete --id resourceIdOfNetworkProfile
    ```
5. If network profiles still block the subnet update, try to set the subnet delegation to **None** again.
6. If the previous steps don't help, try to delete the Service Association Link via Azure CLI using a specified API version such as version 2018-10-01:

    ```azurecli
    az resource delete --ids /subscriptions/<subscription-id>/resourceGroups/<resourcegroup-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name>/providers/Microsoft.ContainerInstance/serviceAssociationLinks/default --api-version 2018-10-01
    ```

## Cause 2: Network profiles block the deletion of the VNet/subnet

When you remove the container group, the network profile created by ACI during the container group creation might not be properly deleted. This results in something remaining within the VNet/subnet, which blocks certain delete operations.

## Workaround 1 for cause 2: Delete the network profile of the container group from the Azure portal

After deleting all ACI container groups, follow these steps:

1. Go to the resource group.
2. Select **Show hidden types**. Network profiles are hidden in the Azure portal by default.
3. Select the network profile related to the container group.
4. Select **Delete**.
5. Delete the VNet or subnet.

## Workaround 2 for cause 2: Delete the network profile of the container group via Azure CLI

After deleting all ACI container groups, follow these steps:

1. Get the network profile ID:

    ```azurecli
    NetworkProfile=$(az network vnet subnet show -g $RES_GROUP --vnet-name $VNET_NAME --name $SUBNET_NAME -o tsv --query ipConfigurationProfiles[].id)
    ```
2. Delete the network profile:

    ```azurecli
    az network profile delete --ids $NetworkProfile --yes
    ```
3. Delete the subnet:

    ```azurecli
    az network vnet subnet delete --resource-group $RES_GROUP --vnet-name $VNET_NAME --name $SUBNET_NAME
    ```
4. Delete the VNet:

    ```azurecli
    az network vnet delete --resource-group $RES_GROUP --name $SUBNET_NAME
    ```

## Workaround 3 for cause 2: Update the containerNetworkInterfaceConfigurations property via Azure CLI

If deleting the network profile fails through the Azure portal and Azure CLI, update the network profile property `containerNetworkInterfaceConfigurations` to an empty list:

1. Get the network profile ID:

    ```azurecli
    NETWORK_PROFILE_ID=$(az network profile list --resource-group <resource-group-name> --query [0].id --output tsv)
    ```
2. Update the network profile:

    ```azurecli
    az resource update --ids $NETWORK_PROFILE_ID --set properties.containerNetworkInterfaceConfigurations=[]
    ```
3. Delete the network profile and the subnet.

## References

- [Managed identities in Azure Container Apps](/azure/container-apps/managed-identity)

- [Azure Container Apps image pull with managed identity](/azure/container-apps/managed-identity-image-pull)

- [Tutorial: Deploy a multi-container group using a Resource Manager template](/azure/container-instances/container-instances-multi-container-group)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
