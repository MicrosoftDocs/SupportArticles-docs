---
title: Customers cannot create a new CMG in specific locations
description: Troubleshoot the CMG Creation Error message cause by unavailability of selected VM size in selected Azure Region.
ms.service: configuration-manager
ms.topic: troubleshooting
ms.manager: dcscontentpm
audience: itpro
ms.date: 02/19/2026
ms.reviewer: kaushika, payur
ms.custom: sap:Cloud Services\Cloud Management Gateway (CMG)
---
# Customers cannot create a new CMG in specific locations

*Applies to*: Configuration Manager (current branch)

## Symptoms

After you attempt to create a new Cloud Management Gateway (CMG) in a specific Azure region, the wizard displays the error message resembling the following:

```output
---------------------------
Settings
---------------------------
The VM size Standard_A2_V2 is currently not available in the region West US 3 for this subscription.  Please deploy the service in other regions or choose a different VM size. 
---------------------------
OK   
---------------------------

```

:::image type="content" source="media/cmg-creation-sku-unavailable-error-message.png" alt-text="The VM Size is currently not available in the region":::

## Cause

Currently, Configuration Manager supports only the following Azure Virtual Machine (VM) SKUs to create CMG:

- Standard_B2S
- Standard_A2_V2
- Standard_A4_V2

Some regions in Azure don't have all of these SKUs available. If you attempt to create a CMG in a region that doesn't have the selected SKU, you receive the error message.

## Resolution

Microsoft is actively working on expanding the list of supported SKUs for CMG creation to mitigate this issue. In the meantime, to work around this issue, you can either:

- Select a different Azure region that has the selected SKU available for CMG creation. You can check the availability of SKUs in different regions by using the sample script. You need to have the [Azure PowerShell module](/powershell/azure/install-azps-windows) installed and authenticate to your Azure account to run the script.

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
				Location = $location
			}
		}
	} |
	Sort-Object Sku, Location

if (-not $results) {
	Write-Host 'No available regions found for the supported CMG SKUs.'
} else {
	$results | Out-GridView -Title 'Available regions for supported CMG SKUs'
}
```

- Raise a support ticket with Microsoft to check for the availability of the required SKU in the desired region and request for an exception if necessary.

## More information

For more information about CMG SKUs, please refer to [Size and scale for CMG](/intune/configmgr/core/clients/manage/cmg/perf-scale#size-and-scale-for-cmg) page.
