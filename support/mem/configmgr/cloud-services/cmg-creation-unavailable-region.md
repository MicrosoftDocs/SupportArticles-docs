---
title: Can't create a CMG in a particular region
description: Discusses how to work around an issue in which you can't create a Cloud Management Gateway in a selected region.
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

When you try to create a Cloud Management Gateway (CMG) in a particular region, you receive a message that states that the requested virtual machine (VM) size isn't available in that region. Therefore, the operation to create the CMG fails. This issue occurs because a CMG requires one of a specific subset of VM SKUs, and these SKUs aren't available in all regions.

This article helps you to work around this issue by creating the CMG in a different region, or by creating a Microsoft support request.

## Symptoms

After you try to create a CMG in a particular Azure region, you receive an error message that resembles the following message:

```output
---------------------------
Settings
---------------------------
The VM size Standard_A2_V2 is currently not available in the region West US 3 for this subscription. Please deploy the service in other regions or choose a different VM size. 
---------------------------
OK   
---------------------------
```

:::image type="content" source="media/cloud-management-gateway-creation-sku-unavailable.png" alt-text="The VM Size is currently not available in the region":::

## Cause

As per February 2026, Configuration Manager supports only the following Microsoft Azure Virtual Machine (VM) SKUs for creating CMGs:

- Standard_B2S
- Standard_A2_V2
- Standard_A4_V2

These SKUs aren't available in all Azure regions that support Virtual Machine Scale Sets (VMSS). If you try to create a CMG in a region that doesn't have the selected SKU, you receive the error message.

## Workaround

To mitigate this issue, Microsoft is actively working on expanding the list of SKUs that you can use to create CMGs. In the meantime, you can use either of the following methods to work around this issue.

### Method 1: Use a different region

Create the CMG in a different Azure region that has the selected SKU available in your subscription.

You can use the following sample script to identify which SKUs are available in different regions in your subscription.

> [!IMPORTANT]  
> Before you run this script, verify that you meet the following requirements:
>
> - You installed the [Azure PowerShell module](/powershell/azure/install-azps-windows).
> - You used your Azure account to authenticate.

[!INCLUDE [Script disclaimer](../../../includes/script-disclaimer.md)]

```powershell
Connect-AzAccount

# Define the supported SKUs and fetch region display names.
$supportedSkus = @('Standard_B2s', 'Standard_A2_v2', 'Standard_A4_v2')
$locationMap = @{}; $displayMap = @{}
Get-AzLocation | ForEach-Object { $locationMap[$_.DisplayName] = $_.Location; $displayMap[$_.Location] = $_.DisplayName }

# Get only the regions that have VMSS available.
$vmssRegions = (Get-AzResourceProvider -ProviderNamespace Microsoft.Compute).ResourceTypes |
    Where-Object { $_.ResourceTypeName -eq 'virtualMachineScaleSets' } |
    Select-Object -ExpandProperty Locations |
    ForEach-Object { if ($locationMap.ContainsKey($_)) { $locationMap[$_] } else { $_ } } |
    Select-Object -Unique

# Check SKU availability in the VMSS-enabled regions.
$results = Get-AzComputeResourceSku |
    Where-Object { $_.ResourceType -eq 'virtualMachines' -and $supportedSkus -contains $_.Name -and $_.Restrictions.Count -eq 0 } |
    ForEach-Object { foreach ($loc in $_.Locations) { if ($vmssRegions -contains $loc) { if ($displayMap.ContainsKey($loc)) { $regionName = $displayMap[$loc] } else { $regionName = $loc }; [PSCustomObject]@{ Sku = $_.Name; Region = $regionName } } } } |
    Sort-Object Sku, Region | Select-Object -Unique Sku, Region

if (-not $results -or $results.Count -eq 0) { Write-Host 'No available regions found for the supported CMG SKUs.' } else { $results | Out-GridView -Title 'Available regions for supported CMG SKUs' }
```

### Method 2: Create a support request

To check the availability of a given SKU and request an exception (if it's necessary), contact [Microsoft Support](https://support.microsoft.com/contactus).

## More information

For more information about SKUs that you can use to create CMGs, see [Size and scale for CMG](/intune/configmgr/core/clients/manage/cmg/perf-scale#size-and-scale-for-cmg).
