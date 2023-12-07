---
title: Cannot Delete Virtual Network or Subnet
description: Describes how to troubleshoot image pull failures when you deploy to Azure Container Instances (ACI) from Azure Container Registry (ACR) by using a managed identity.
ms.date: 12/06/2023
ms.service: container-instances
ms.reviewer: tysonfreeman, v-weizhu
---

# Cannot Delete Virtual Network or Subnet

This article discusses how to troubleshoot not being able to delete a virtual network or subnet.

## Symptoms

When deleting the subnet used by ACI, errors similar to the following are observed: 
```
Failed to delete subnet 'xxxxxx'.
Error: 'Subnet /subscriptions/xxxxx/resourceGroups/xxxx/providers/Microsoft.Network/virtualNetworks/xxxxxx/subnets/xxxxxx requires any of the following delegations
[Microsoft.ContainerInstance/containerGroups] to reference service association link /
subscriptions/xxxxx/resourceGroups/xxxx/providers/Microsoft.Network/virtualNetworks/xxxxxx/subnets/xxxxxx/serviceAssociationLinks/acisal.'
```
```
Subnet xxx is in use by /subscriptions/xxxxx/resourceGroups/xxxx/providers/Microsoft.Network/networkProfiles/aci-network-profile-xxxx/containerNetworkInterfaceConfigurations/eth0/ipConfigurations/ipconfigprofile and cannot be deleted. 
In order to delete the subnet, delete all the resources within the subnet. See aka.ms/deletesubnet.
```
```
Failed to delete subnet 'xxx'. 
Error: Subnet test is in use by xxx/providers/Microsoft.Network/networkProfiles/aci-network-profile-xxx/containerNetworkInterfaceConfigurations/eth0/ipConfigurations/ipconfigprofile'>aci-network-profile-xxx/eth0/ipconfigprofile and cannot be deleted. 
In order to delete the subnet, delete all the resources within the subnet. See aka.ms/deletesubnet.
```
When deleting the virtual network used by ACI, errors similar to the following are observed: 
```
Failed to delete virtual network 'xxx'. 
Error: 'Subnet /subscriptions/xxxxx/resourceGroups/xxxx/providers/Microsoft.Network/virtualNetworks/xxxxxx/subnets/xxxxxx requires any of the following delegations [Microsoft.ContainerInstance/containerGroups] to reference service association link 
/subscriptions/xxxxx/resourceGroups/xxxx/providers/Microsoft.Network/virtualNetworks/xxxxxx/subnets/xxxxxx/serviceAssociationLinks/acisal.'
```

## Cause
### Cause 1
The subnet delegation required by ACI must reference a residual Service Association Link, which prevents the deletion of the subnet or vnet used by ACI.
### Cause 2
The network profile created by ACI during container group creation may not be properly deleted when removing the container group. This results in something that stays in the subnet/vnet and will block any delete operations.

## Troubleshooting from the ACI side

### For Cause 1
Manually delete "Service Association Link"
1. Navigate to the subnet in Azure Portal and change "Delegation" to "None". Make sure no network profiles are linked to subnet. If so, delete them using command: az network profile delete
2. If the update command in step one errs/fails, there may be a lingering network profile that needs to be removed using the following command: 
```
az network profile delete --id resourceIdOfNetworkProfile
```
3. If network profiles were blocking the subnet update, attempt to set Delegation to "None" again.
4. If above fails try deleting SAL resource via CLI using especified API version:
```
az resource delete --ids /subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/<RG>/providers/Microsoft.Network/virtualNetworks/<VNET>/subnets/<Subnet>/providers/Microsoft.ContainerInstance/serviceAssociationLinks/default --api-version 2018-10-01
```
### For Cause 2
#### Workaround 1
The first potential mitigation is attempting to manually delete "network profile" of the ACI container group.

After deleting all container groups then perform the following:

1. Go to the Resource group.
2. Click on “Show hidden types”; Network profile is hidden on Azure Portal by default.
3. Select the Network profile that related to the container groups
4. Click Delete
5. Delete the Subnet or VNet.


If the first mitigation doesn't work, try workaround 2.

#### Workaround 2
If the deletion workflow that uses Azure Portal doesn't work and the vnet and/or subnet still fails to delete, you can attempt the delete through Azure CLI.

After deleting all container groups, run the following commands:

1. Replace <my-resource-group>, <my-vnet-name>, and <my-subnet-name> with the name of your resource group, VNet, and subnet
```
RES_GROUP=<my-resource-group>
VNET_NAME=<my-vnet-name>
SUBNET_NAME=<my-subnet-name>
```
2. Get network profile ID:
```
NetworkProfile=$(az network vnet subnet show -g $RES_GROUP --vnet-name $VNET_NAME --name $SUBNET_NAME -o tsv --query ipConfigurationProfiles[].id)
```
3. Delete the network profile:
```
az network profile delete --ids $NetworkProfile --yes
```
4. Delete the subnet:
```
az network vnet subnet delete --resource-group $RES_GROUP --vnet-name $ VNET_NAME --name $SUBNET_NAME
```
6. Delete virtual network:
```
az network vnet delete --resource-group $RES_GROUP --name $SUBNET_NAME
```
#### Workaround 3
If deleting the network profile fails through Azure Portal and Azure CLI, you may need to update the containerNetworkInterfaceConfigurations property in the network profile properties to an empty list.

1. Get network profile ID: 
```
NETWORK_PROFILE_ID=$(az network profile list --resource-group <resource-group-name> --query [0].id --output tsv)
```
2. Update the network profile:
```
az resource update --ids $NETWORK_PROFILE_ID --set properties.containerNetworkInterfaceConfigurations=[]
```
3. Delete the network profile and the subnet.

4. ## Next Steps 
If the previous checks did not resolve the incident, please submit a [support request](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest) 
Azure Container Registry ResourceURI 
Container Group ARM template (or other reference used to deetermine the ACI configuration deployed). 
