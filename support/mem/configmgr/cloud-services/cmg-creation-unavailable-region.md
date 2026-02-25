---
title: Can't create a CMG in a particular region
description: Discusses how to work around an issue in which you can't create a Cloud Management Gateway in the selected region because that region doesn't support the VM SKUS that you can use to create a CMG.
ms.service: configuration-manager
ms.topic: troubleshooting
ms.manager: dcscontentpm
audience: itpro
ms.date: 02/26/2026
ms.reviewer: kaushika, payur
ms.custom: sap:Cloud Services\Cloud Management Gateway (CMG)
---
# Can't create a CMG in a particular region

*Applies to*: Configuration Manager (current branch)

## Summary

When you try to create a Cloud Management Gateway (CMG) in a particular region, you receive a message that the requested virtual machine (VM) size isn't available in that region. Therefore, the operation to create the CMG fails. This issue occurs because a CMG requires one of a specific subset of VM SKUs, and these SKUs aren't available in all regions.

This article helps you to work around this issue by creating the CMG in a different region, or by creating a Microsoft support request.

## Symptoms

After you try to create a CMG in a particular Azure region, you receive an error message that resembles the following message:

```output
---------------------------
Settings
---------------------------
The VM size Standard_A2_V2 is currently not available in the region West US 3 for this subscription.  Please deploy the service in other regions or choose a different VM size. 
---------------------------
OK   
---------------------------
```

:::image type="content" source="media/cloud-management-gateway-creation-sku-unavailable.png" alt-text="The VM Size is currently not available in the region":::

## Cause

Configuration Manager supports only the following Azure Virtual Machine (VM) SKUs for creating CMGs:

- Standard_B2S
- Standard_A2_V2
- Standard_A4_V2

These SKUs aren't available in all Azure regions. If you attempt to create a CMG in a region that doesn't have the selected SKU, you receive the error message.

## Workaround

To mitigate this issue, Microsoft is actively working on expanding the list of SKUs that you can use to create CMGs. In the meantime, you can use either of the following methods to work around this issue.

### Method 1: Use a different region

Create the CMG in a different Azure region that has the selected SKU available in your subscription.

You can use the following sample script to identify which SKUs are available in different regions in your subscription.

> [!IMPORTANT]  
> Before you run this script, verify that you meet the following requirements:
>
> - You used your Azure account to authenticate.
> - You installed the [Azure PowerShell module](/powershell/azure/install-azps-windows).

[!INCLUDE [Script disclaimer](../../../includes/script-disclaimer.md)]

```powershell
Connect-AzAccount

$supportedSkus = @('Standard_B2s','Standard_A2_v2','Standard_A4_V2')

$results = Get-AzComputeResourceSku |
   Where-Object {
      $_.ResourceType -eq 'virtualMachines' -and
      $supportedSkus -contains $_.Name -and
      ($_.Restrictions.ReasonCode -notcontains 'NotAvailableForSubscription')
   } |
   ForEach-Object {
      foreach ($location in $_.Locations) {
         [PSCustomObject]@{
            Sku      = $_.Name
            Region = $location
         }
      }
   } |
   Sort-Object Sku, Region

if (-not $results) {
   Write-Host 'No available regions found for the supported CMG SKUs.'
} else {
   $results | Out-GridView -Title 'Available regions for supported CMG SKUs'
}
```

### Create a support request

To check the availability of a given SKU and (if needed) request an exception, create a Microsoft support request.

## More information

For more information about SKUs that you can use to create CMGs, see [Size and scale for CMG](/intune/configmgr/core/clients/manage/cmg/perf-scale#size-and-scale-for-cmg).
