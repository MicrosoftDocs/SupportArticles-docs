---
title: Can't delete a virtual network or subnet used by ACI
description: Learn how to troubleshoot and resolve failures when you delete a virtual network or subnet used by Azure Container Instances (ACI).
ms.date: 08/20/2026
author: kaushika-msft
ms.author: kaushika
ms.topic: troubleshooting
ms.service: azure-container-instances
ms.custom: sap:Connectivity, devx-track-azurecli
ms.reviewer: zhixinsun, shiyao, pihe
ai-usage: ai-assisted
---

# Failed to delete a virtual network or subnet used by Azure Container Instances

## Summary

This article discusses errors that occur when you delete a virtual network (VNet) or subnet used by Azure Container Instances (ACI) and provides workarounds.

> [!NOTE]
> This article uses the following terms to distinguish the ACI networking models:
>
> - **Modern ACI networking**: The container group references the delegated subnet directly. The subnet's `ipConfigurationProfiles` property is empty or absent. This model is used by ACI API version `2021-07-01` and later.
> - **Legacy ACI networking**: The subnet's `ipConfigurationProfiles` property references a `Microsoft.Network/networkProfiles` resource. Network profiles are retired starting with ACI API version `2021-07-01`, but existing legacy profiles can still block subnet deletion.
>
> Use the subnet's `ipConfigurationProfiles` property to distinguish the models. A current `az container show` response might display `subnetIds` for a container group that you originally deployed by using a legacy network profile.

## Symptoms

- When you delete a subnet used by ACI, you receive errors that resemble the following ones:

    ```output
    (SubnetInUse) The subnet '<subnet-resource-id>' is still in use.
    Please delete all container groups in the subnet and try again.
    One sample container group in use is '<container-group-resource-id>'.
    ```

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

- When you delete a VNet used by ACI, you receive the following error:

    ```output
    Failed to delete virtual network '<vnet-name>'. 
    Error: 'Subnet /subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name> requires any of the following delegations [Microsoft.ContainerInstance/containerGroups] to reference service association link 
    /subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name>/serviceAssociationLinks/acisal.'
    ```

## Cause 1: A service association link blocks the deletion of the VNet or subnet

ACI creates a service association link (SAL) named `acisal` on the delegated subnet. The SAL prevents the ACI delegation from being removed while a container group still uses the subnet. In some cases, the SAL can remain after all container groups are deleted and block deletion of the subnet or VNet.

> [!NOTE]
> Don't remove the ACI subnet delegation while the SAL exists. First delete all container groups that reference the subnet and allow the platform to clean up the SAL. After the SAL is removed, you can remove the delegation or delete the subnet.

### Workaround: Delete the service association link

1. Attempt to explicitly delete the subnet first to discard cascading delete operation errors.
2. Check the subnet dependencies:

    ```azurecli
    az network vnet subnet show \
      --resource-group <vnet-resource-group> \
      --vnet-name <vnet-name> \
      --name <subnet-name> \
      --query "{
        serviceAssociationLinks:serviceAssociationLinks[].{
          name:name,
          linkedResourceType:linkedResourceType
        },
        ipConfigurationProfiles:ipConfigurationProfiles[].id,
        ipConfigurations:ipConfigurations[].id,
        privateEndpoints:privateEndpoints[].id
      }" \
      --output json
    ```
1. Delete every container group that references the subnet. A container group doesn't have to be in the `Running` state to retain the subnet dependency.

    ```azurecli
    az container list \
      --subscription <subscription-id> \
      --query "[].{
        name:name,
        resourceGroup:resourceGroup,
        provisioningState:provisioningState,
        subnetIds:subnetIds[].id
      }" \
      --output json
    ```

    Delete each matching container group:

    ```azurecli
    az container delete \
      --resource-group <container-group-resource-group> \
      --name <container-group-name> \
      --yes
    ```

1. Retry the subnet deletion. If the ACI SAL still blocks the operation, wait 10-15 minutes for platform cleanup and retry.

1. If no container group or legacy network profile references the subnet and the SAL continues to block deletion, remove the SAL by using one of the following methods.

    **Az PowerShell:**

    ```powershell
    Remove-AzContainerInstanceSubnetServiceAssociationLink `
      -ResourceGroupName <vnet-resource-group> `
      -VirtualNetworkName <vnet-name> `
      -SubnetName <subnet-name>
    ```

    **Azure CLI:**
   
    ```azurecli
    SUBNET_ID=$(az network vnet subnet show \
      --resource-group <vnet-resource-group> \
      --vnet-name <vnet-name> \
      --name <subnet-name> \
      --query id \
      --output tsv)
    
    az resource delete --ids /subscriptions/<subscription-id>/resourceGroups/<resourcegroup-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name>/providers/Microsoft.ContainerInstance/serviceAssociationLinks/default --api-version 2018-10-01
    ```
    The subnet displays the Network resource provider SAL as `serviceAssociationLinks/acisal`. The delete operation uses the ACI extension resource path `providers/Microsoft.ContainerInstance/serviceAssociationLinks/default`.

    > [!NOTE]
    > A read request such as `az resource show` can return `DisallowedResourceOperation` for this extension resource even when the delete operation is supported. Check the subnet's `serviceAssociationLinks` property to determine whether the SAL exists.

1. Query the subnet again and verify that `serviceAssociationLinks` no longer contains `acisal`. Then retry the intended subnet or VNet deletion.

## Cause 2: Network profiles block the deletion of the VNet or subnet

When you remove a container group that uses legacy ACI networking, its network profile might not be deleted correctly. The profile's IP configuration continues to reference the subnet and blocks deletion of the subnet or VNet.

> [!NOTE]
> Network profiles are retired starting with ACI API version `2021-07-01`. This cause applies only when the target subnet's `ipConfigurationProfiles` property contains one or more `Microsoft.Network/networkProfiles` resource IDs. Use API version `2021-07-01` or later for new deployments.

### Workaround 1: Delete the network profile of the container group from the Azure portal

After deleting all ACI container groups, follow these steps:

1. Query the target subnet and identify the exact network profile resource ID in `ipConfigurationProfiles`.

    ```azurecli
    az network vnet subnet show \
      --resource-group <vnet-resource-group> \
      --vnet-name <vnet-name> \
      --name <subnet-name> \
      --query "ipConfigurationProfiles[].id" \
      --output tsv
    ```

1. Go to the resource group shown in the network profile resource ID.
1. Select **Show hidden types**. By default, network profiles are hidden in the Azure portal.
1. Select the network profile related to the container group.
1. Select **Delete**.
1. Retry the intended operation:
   - To delete only the subnet, delete the subnet.
   - To delete the entire VNet, first verify that no other resources use any subnet in the VNet, and then delete the VNet.

### Workaround 2: Delete the network profile of the container group via Azure CLI

After deleting all ACI container groups, follow these steps:

1. Get the network profile IDs from the target subnet:

    ```azurecli
    NETWORK_PROFILE=$(az network vnet subnet show \
      --resource-group <vnet-resource-group> \
      --vnet-name <vnet-name> \
      --name <subnet-name> \
      --query "ipConfigurationProfiles[].id" \
      --output tsv)
    ```

1. Delete the network profile,  Azure CLI accepts these child resource IDs and resolves the corresponding parent profiles:

    ```azurecli
    az network profile delete --ids $NetworkProfile --yes
    ```

1. Retry the intended operation.

    To delete only the subnet:

    ```azurecli
    az network vnet subnet delete \
      --resource-group <vnet-resource-group> \
      --vnet-name <vnet-name> \
      --name <subnet-name>
    ```

    To delete the entire VNet:

    ```azurecli
    az network vnet delete \
      --resource-group <vnet-resource-group> \
      --name <vnet-name>
    ```

    > [!IMPORTANT]
    > Delete the subnet or the VNet according to your intended scope. Don't run both commands as consecutive cleanup steps. The VNet delete command must use the VNet name, not the subnet name.

1. Verify that the intended resource was deleted. Don't rely only on the delete command's exit code.
   
### Workaround 3: Update the containerNetworkInterfaceConfigurations property via Azure CLI

If deleting the network profile through the Azure portal and Azure CLI fails with `NetworkProfileAlreadyInUseWithContainerNics`, update the network profile property `containerNetworkInterfaceConfigurations` to an empty list.

1. Get the exact network profile ID from the target subnet.

    ```azurecli
    NETWORK_PROFILE_ID=$(az network vnet subnet show \
      --resource-group <vnet-resource-group> \
      --vnet-name <vnet-name> \
      --name <subnet-name> \
      --query "ipConfigurationProfiles[0].id" \
      --output tsv)
    ```
    
1. Convert the returned child resource ID to the parent network profile ID, and review it:

    ```bash
    NETWORK_PROFILE_ID=${NETWORK_PROFILE_ID%%/containerNetworkInterfaceConfigurations/*}
    echo "$NETWORK_PROFILE_ID"
    ```

    Here, `ipConfigurationProfiles[0].id` selects a profile reference from the target subnet. It isn't the same as `az network profile list --query "[0].id"`, which selects the first profile returned for an entire resource group. If the subnet returns more than one profile reference, repeat these steps for each returned ID.

1. Clear `containerNetworkInterfaceConfigurations`.

    ```azurecli
    az resource update \
      --ids $NETWORK_PROFILE_ID \
      --set properties.containerNetworkInterfaceConfigurations=[]
    ```

1. Delete the network profile.
       ```azurecli
    az network profile delete --ids "$NETWORK_PROFILE_ID" --yes
    ```
    
1. Query the subnet again and verify that `ipConfigurationProfiles` is empty.
1. Delete either the subnet or the VNet by using the appropriate command from Workaround 2.
