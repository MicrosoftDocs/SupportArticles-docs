---
title:
description: 
ms.date: 12/15/2022
ms.reviewer: 
author: AmandaAZ
ms.author: v-weizhu
ms.service: cloud-services
---
# Retrieve Cloud Service Extended Support detail via PowerShell

This article introduces how to retrieve the Cloud Service Extended Support (CSES) configuration via PowerShell and REST API.

## Prerequisites

No matter PowerShell command or Rest API request will be used to get the information, the Azure Az PowerShell module is necessary. For the installation details, refer to [Install the Azure Az PowerShell module](/powershell/azure/install-az-ps).

## PowerShell command to get the CSES configuration

To use [Get-AzCloudService](/powershell/module/az.cloudservice/get-azcloudservice) to get the CSES configuration data, follow these steps:

1. Use command [Connect-AzAccount](/powershell/module/az.accounts/connect-azaccount) to login.

2. Use command [Get-AzCloudService](/powershell/module/az.cloudservice/get-azcloudservice) to get the full picture of your CSES resource and save it into a PowerShell variable such as `$cses` in the following example.

3. Convert the configuration of the CSES into XML format.

PowerShell commands example:

```powershell
Connect-AzAccount
$cses = Get-AzCloudService -ResourceGroupName "xxx" -CloudServiceName "xxx"
[xml]$xml = $cses.Configuration
```

:::image type="content" source="media/retrieve-cloud-service-extended-support-detail-powershell/command-get-cses-configuration.png" alt-text="Screenshot of PowerShell commands to get the CSES configuration.":::

## PowerShell command to send out REST API request to get the CSES configuration

To use the [Cloud Services - Get](/rest/api/compute/cloud-services/get) REST API to get the CSES configuration data by sending out REST API request in PowerShell, follow these steps:

1. Use command [Connect-AzAccount](/powershell/module/az.accounts/connect-azaccount) to login.
2. Use command [Invoke-AzRestMethod](/powershell/module/az.accounts/invoke-azrestmethod) to send out the REST API request.

    The path in the command will be the same for every user except the value such as your own subscription ID, resource group name and CSES resource name. Once we get the response, we can use some other PowerShell functions like `convertfrom-json` to proceed the data and then save it into a PowerShell variable such as `$csesapi` in the following example.
3. Convert the configuration of the CSES into XML format.

```powershell
Connect-AzAccount 
$csesapi = (Invoke-AzRestMethod -Path "/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.Compute/cloudServices/{CSES-resource-name}?api-version=2021-03-01").Content | convertfrom-json 
[xml]$xml = $csesapi.properties.configuration 
```

Example of a REST API request:

:::image type="content" source="media/retrieve-cloud-service-extended-support-detail-powershell/send-rest-api-to-get-cses-configuration.png" alt-text="Screenshot of REST API request to get the CSES configuration.":::

## Sample about how to get OS Family, OS Version and any other data

No matter a PowerShell command or REST API is used with the instructions above, the `$xml` from both ways will be the same.

Here's a CSES configuration data sample:

:::image type="content" source="media/retrieve-cloud-service-extended-support-detail-powershell/cses-configuration-data-example.png" alt-text="Screenshot of CSES configuration data example.":::

The `$xml` is the whole configuration file in XML format. To get the data, such as `osFamily`, `osVersion` or `VirtualNetworkSite`, follow the construction of this XML file to add related names to identify the data of which level is needed.

For example, for `osVersion`/`osFamily`, the path to it will be `ServiceConfiguration` > `osVersion`/`osFamily`. So the expression to get the data in PowerShell will be `$xml.ServiceConfiguration.osVersion` / `$xml.ServiceConfiguration.osFamily`.

:::image type="content" source="media/retrieve-cloud-service-extended-support-detail-powershell/osfamily-osversion-expression-example.png" alt-text="Screenshot of an osFamily/osVersion expression example.":::

And for the `VirtualNetworkSite`, the path to it will be `ServiceConfiguration` > `NetworkConfiguration` > `VirtualNetworkSite` > `name`. So the expression to use in PowerShell to get the data will be `$xml.ServiceConfiguration.NetworkConfiguration.VirtualNetworkSite.name`.

:::image type="content" source="media/retrieve-cloud-service-extended-support-detail-powershell/virtual-network-name-expression.png" alt-text="Screenshot of a VirtualNetworkSite name expression example.":::

> [!NOTE]
> It's possible that you have more than one role in your configuration, the expression to locate a role which isn't the first role will be `$xml.ServiceConfiguration.Role[1]`. The number "1" here means the second role in the configuration data because this counter starts from 0. If there are two roles in same configuration data, the expression `$xml.ServiceConfiguration.Role[1].Instances.count` will be able to return how many instances there are for the second role.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]