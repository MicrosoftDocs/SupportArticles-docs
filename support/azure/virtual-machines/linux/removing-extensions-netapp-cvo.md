---
title: Removing Extensions NetApp CVO Image
description: This article guides you through removing extensions from Azure VMs created from NetApp CVO images.
services: virtual-machines
ms.collection: linux
ms.service: azure-virtual-machines
author: GabstaMSFT
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-linux
ms.custom: linux-related-content
ms.workload: infrastructure
ms.date: 08/25/2025
ms.author: Gabsta
---

# Removing extensions from VMs created from NetApp CVO images
**Applies to:** :heavy_check_mark: NetApp CVO Linux VMs

This article discusses how to remove extensions that are installed on Microsoft Azure virtual machines (VMs) that are created from NetApp Cloud Volumes ONTAP (CVO) images. This article also discusses how to prevent extensions from being installed.

## Prerequisites
- The NetApp CVO resource group has a "delete" lock feature that might prevent the script from uninstalling VM extensions. You might have to remove the lock and restore it after you run the scripts in the "Resolution" section. The lock properties are as follows:

   - Name: (matches the CVO resource group name)
   - Type: **Delete**
   - Scope: **CVO resource group**

   :::image type="content" source="media/netapp-cvo-issue/netapp-cloud-volumes-ontap-lock.png" alt-text="The NetApp Cloud Volumes ONTAP Locks screen might list a delete lock that must be removed before you run a script to uninstall extensions.png.":::

- Download and install the latest version of the Windows Installer (MSI) agent from the [GitHub page for Azure Windows VM Agent releases](https://github.com/Azure/WindowsVMAgent/releases). You must have administrator rights to complete the installation.

## Symptoms
You receive the following error message:

_Cloud Volumes ONTAP is not compatible with Azure VM extensions. VM extensions are currently installed on your Azure VM. Contact Microsoft Azure support to remove those extensions._

:::image type="content" source="media/netapp-cvo-issue/cloud-volumes-ontap-error.png" alt-text="You receive an error message that states that Cloud Volumes ONTAP isn't compatible with Azure VM Extensions.":::

## Cause
Cloud Volumes ONTAP doesn't support Azure VM extensions because extensions affect BlueXP management operations. Although CVO VM appears as Linux (ONTAP version) in the Azure portal, it's actually a highly customized derivative of the FreeBSD operating system that ONTAP uses.

> [!NOTE]
> Starting in BlueXP 3.9.54, NetApp enforces this pre-existing limitation as a notification in BlueXP. 

## Resolution
To resolve this issue, run the following script against any affected NetApp CVO VMs.

### [PowerShell](#tab/powershell)

```powershell
$subscriptionId = (Get-AzContext).Subscription.Id 
$resourceGroup = "RGname" 
$vmName = "VMName" 
$apiVersion = "2025-04-01" 
$uri = "https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroup}/providers/Microsoft.Compute/virtualMachines/${vmName}?api-version=${apiVersion}"
$response = Invoke-AzRestMethod -Method GET -Uri $uri 
$vmModel = $response.Content | ConvertFrom-Json 
$vmModel.resources = @() 
$body = $vmModel | ConvertTo-Json -Depth 10 -Compress 
Invoke-AzRestMethod -Method PUT -Uri $uri -Payload $body
```

### [CLI](#tab/cli)

```cmd
subscriptionId=$(az account show --query id -o tsv)
resourceGroup="RGName"
vmName="VMName"
apiVersion="2025-04-01"
uri="https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroup}/providers/Microsoft.Compute/virtualMachines/${vmName}?api-version=${apiVersion}"
response=$(az rest --method get --uri "$uri")
vmModel=$(echo "$response" | jq '.resources = []')
az rest --method put --uri "$uri" --body "$vmModel"
```

> [!NOTE]
> This operation might take 20-30 minutes to finish if the guest agent doesn't exist. This condition occurs because Azure CRP polls for the agent status first. The script removes all extensions from a VM model.

## More information

To prevent extensions from installing in VMs without a guest agent or extensions, disable extensions. You can disable extensions either through a policy definition or by setting `AllowExtensionOperations` to `false`.

### Option 1: Set a policy definition

```json
{ 
 "if": { 
  "allOf": [ 
   { 
    "field": "type", 
    "equals": "Microsoft.Compute/virtualMachines/extensions" 
   } 
  ] 
 }, 
 "then": { 
  "effect": "deny" 
 } 
}
```

### Option 2: Set AllowExtensionOperations to false

```powershell
$vm = Get-AzVM -Name <VMName> -ResourceGroupName <ResourceGroupName> 
$vm.OSProfile.AllowExtensionOperations = $false 
$vm | Update-AzVM 
```

## References

[Installing Azure VM management extensions into Cloud Volume ONTAP](https://kb.netapp.com/Cloud/Cloud_Volumes_ONTAP/Can_Azure_VM_Management_Extensions_be_installed_into_Cloud_Volume_ONTAP)

 

[!INCLUDE [third-party-disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
