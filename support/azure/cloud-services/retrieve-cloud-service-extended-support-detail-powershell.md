---
title: Retrieve Azure Cloud Service (extended support) detail via PowerShell
description: Describes how to get the Azure Cloud Service (extended support) configuration data via PowerShell and REST API.
ms.date: 12/15/2022
ms.topic: how-to
ms.reviewer: maheshallu, piw, v-weizhu
ms.author: zhangjerry
ms.service: cloud-services
ms.custom:
author: JerryZhangMS
---
# Retrieve Azure Cloud Service (extended support) detail via PowerShell

This article introduces how to retrieve the Azure Cloud Service (extended support) configuration through PowerShell and REST API.

## Prerequisites

Whether you use PowerShell commands or a REST API request to get the information, the Azure Az PowerShell module is required. For the installation details, see [Install the Azure Az PowerShell module](/powershell/azure/install-az-ps).

## PowerShell commands to get Cloud Service (extended support) configuration

To use [Get-AzCloudService](/powershell/module/az.cloudservice/get-azcloudservice) to get the Cloud Service (extended support) configuration data, follow these steps:

1. Use [Connect-AzAccount](/powershell/module/az.accounts/connect-azaccount) to log in.

2. Use [Get-AzCloudService](/powershell/module/az.cloudservice/get-azcloudservice) to get the full picture of your CSES resource and save it into a PowerShell variable, such as `$cses` in the following example.

3. Convert the configuration of the Cloud Service (extended support) into XML format.

PowerShell commands example:

```powershell
Connect-AzAccount
$cses = Get-AzCloudService -ResourceGroupName "resource-group-name" -CloudServiceName "cloud-service-name"
[xml]$xml = $cses.Configuration
```

## PowerShell commands to send REST API request to get Cloud Service (extended support) configuration

To use the [Cloud Services - Get](/rest/api/compute/cloud-services/get) REST API to get the Cloud Service (extended support) configuration data by sending a REST API request from PowerShell, follow these steps:

1. Use [Connect-AzAccount](/powershell/module/az.accounts/connect-azaccount) to log in.
2. Use [Invoke-AzRestMethod](/powershell/module/az.accounts/invoke-azrestmethod) to send the REST API request.

    The path in the command is the same for each user, except for values such as your own subscription ID, resource group name, and CSES resource name. Once you get the response, you can use some other PowerShell cmdlets like `convertfrom-json` to proceed the data and then save it into a PowerShell variable, such as `$csesapi` in the following example.
3. Convert the configuration of the Cloud Service (extended support) into XML format.

PowerShell commands example:

```powershell
Connect-AzAccount 
$csesapi = (Invoke-AzRestMethod -Path "/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.Compute/cloudServices/{CSES-resource-name}?api-version=2021-03-01").Content | convertfrom-json 
[xml]$xml = $csesapi.properties.configuration 
```

## Sample about how to get OS Family, OS Version, and any other data

Whether PowerShell commands or a REST API is used with the above instructions, the `$xml` file from both ways is the same.

Here's a Cloud Service (extended support) configuration data sample:

```xml
<?xml version="1.0" encoding="utf-16"?>
<ServiceConfiguration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" serviceName="CSESOneWebRoleAI" osFamily="6" osVersion="*" schemaVers
ion="2015-04.2.6" xmlns="http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceConfiguration">
  <Role name="WebRole1">
    <ConfigurationSettings>
      <Setting name="APPINSIGHTS_INSTRUMENTATIONKEY" value="af542f03-xxxx-xxxx-xxxx-ac17701a8152" />
    </ConfigurationSettings>
    <Instances count="1" />
    <Certificates>
      <Certificate name="cert1" thumbprint="500Dxxxxxxxxxxxx9D5754" thumbprintAlgorithm="sha1" />
    </Certificates>
  </Role>
  <NetworkConfiguration>
    <VirtualNetworkSite name="jerrycses-vnet" />
    <AddressAssignments>
      <InstanceAddress roleName="WebRole1">
        <Subnets>
          <Subnet name="webrole1" />
        </Subnets>
      </InstanceAddress>
    </AddressAssignments>
  </NetworkConfiguration>
</ServiceConfiguration>
```

The `$xml` file is the whole configuration file in XML format. To get the data, such as `osFamily`, `osVersion`, or `VirtualNetworkSite`, follow the construction of this XML file and add the related names to identify which level of the data is needed.

For example, for `osVersion`/`osFamily`, the path to it will be `ServiceConfiguration` > `osVersion`/`osFamily`. So the expression to get the data in PowerShell will be `$xml.ServiceConfiguration.osVersion` / `$xml.ServiceConfiguration.osFamily`.

And for `VirtualNetworkSite`, the path to it will be `ServiceConfiguration` > `NetworkConfiguration` > `VirtualNetworkSite` > `name`. So the expression to get the data in PowerShell will be `$xml.ServiceConfiguration.NetworkConfiguration.VirtualNetworkSite.name`.

> [!NOTE]
> It's possible that you have more than one role in your configuration. The expression to locate a role that isn't the first role will be `$xml.ServiceConfiguration.Role[1]`. The number "1" here means the second role in the configuration data because this counter starts from 0. If there are two roles in the same configuration data, the expression `$xml.ServiceConfiguration.Role[1].Instances.count` will be able to return the number of instances of the second role.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
