---
title: Use PowerShell to manage VIP swaps in Azure Cloud Services (extended support)
description: Learn how to manage VIP swaps in Azure Cloud Services (extended support) by using PowerShell.
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
ms.custom: devx-track-azurepowershell
ms.date: 02/08/2023
editor: v-jsitser
ms.reviewer: maheshallu, piw, v-frpan, v-leedennis
ms.topic: how-to
---
# Use PowerShell to manage VIP swaps in Azure Cloud Services (extended support)

This article discusses how to swap between two independent cloud service deployments in Microsoft Azure Cloud Services (extended support). Unlike in Azure Cloud Services (classic), the Azure Resource Manager model in the extended support version doesn't use deployment slots. When you deploy a new release of a cloud service in Azure Cloud Services (extended support), you can make the cloud service "swappable" with an existing cloud service in the extended support version. The article shows how to update the cloud service version by using PowerShell and the REST API to swap the virtual IP address (VIP).

:::image type="content" source="./media/manage-vip-swap-powershell/production-staging-environments-before-after-vip-swap.svg" alt-text="Diagrams of the relationship between the production and staging environments. The first diagram shows the environment before the VIP swap. The second shows after the swap." border="false" lightbox="./media/manage-vip-swap-powershell/production-staging-environments-before-after-vip-swap.svg":::

## Prerequisites

- [Azure PowerShell](/powershell/azure/install-az-ps).
- Two [static public IP addresses](/azure/virtual-network/ip-services/create-public-ip-powershell): One for the production environment, the other for the staging environment. The IP addresses in this example are named `cses-prod` and `cses-stag`, respectively.
- A [virtual network](/azure/virtual-network/quick-create-powershell) for the test environment. In this example, the virtual network is named `test001VNet`.
- An [Azure Blob Storage account](/azure/storage/blobs/storage-blobs-introduction).
- The URLs for the service configuration file and the package file, in [service shared access signature (SAS) URI format](/rest/api/storageservices/create-service-sas). If you haven't already created these URLs, you can create each SAS URI (or the SAS token that's part of the SAS URI) by using the Azure portal or by calling the [New-AzStorageBlobSASToken](/powershell/module/az.storage/new-azstorageblobsastoken) cmdlet. Assign the service configuration file and package file URLs to the `$cscfg` and `$cspkg` variables, respectively. The following PowerShell code snippet shows the format of these URLs. The URLs are used in subsequent calls to the [New-AzCloudService](/powershell/module/az.cloudservice/new-azcloudservice) cmdlet.

  ```powershell
  $containerUrl = "https://<storage-account-name>.blob.core.windows.net/<container-name>"
  $sasTokenCfg = "?sp=r&st={0}&se={1}&spr=https&sv={2}&sr=b&sig={3}" -f (
      "<start-time1>", "<expiration-time1>", "<storage-version1>", "<signature1>"
  )
  $sasTokenPkg = "?sp=r&st={0}&se={1}&spr=https&sv={2}&sr=b&sig={3}" -f (
      "<start-time2>", "<expiration-time2>", "<storage-version2>", "<signature2>"
  )
  $cscfg = "$containerUrl/<configuration-file>$sasTokenCfg"
  $cspkg = "$containerUrl/<package-file>$sasTokenPkg"
  ```

- A configuration file for the production environment's public IP address. The file should resemble the following code:

  ```xml
  <ServiceConfiguration
      xmlns=http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceConfiguration
      serviceName="Test_cloudservice"
      osFamily="6"
      osVersion="*"
      schemaVersion="2015-04.2.6">
    <Role name="TestWebRole">
      <Instances count="1" />
    </Role>
    <Role name="TestWorkerRole">
      <Instances count="1" />
    </Role>
    <NetworkConfiguration>
      <VirtualNetworkSite name="test001VNet" />
      <AddressAssignments>
        <InstanceAddress roleName="TestWebRole">
          <Subnets>
            <Subnet name="default" />
          </Subnets>
        </InstanceAddress>
        <InstanceAddress roleName="TestWorkerRole">
          <Subnets>
            <Subnet name="default" />
          </Subnets>
        </InstanceAddress>
        <ReservedIPs>
          <ReservedIP name="cses-stag" />
        </ReservedIPs>
      </AddressAssignments>
    </NetworkConfiguration>
  </ServiceConfiguration>
  ```

- A configuration file for the public IP address of the staging environment. The file should resemble the following code. (Notice that the name of the reserved IP address has changed from `cses-stag` to `cses-prod`.)

  ```xml
  <ServiceConfiguration
      xmlns=http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceConfiguration
      serviceName="Test_cloudservice"
      osFamily="6"
      osVersion="*"
      schemaVersion="2015-04.2.6">
    <Role name="TestWebRole">
      <Instances count="1" />
    </Role>
    <Role name="TestWorkerRole">
      <Instances count="1" />
    </Role>
    <NetworkConfiguration>
      <VirtualNetworkSite name="test001VNet" />
      <AddressAssignments>
        <InstanceAddress roleName="TestWebRole">
          <Subnets>
            <Subnet name="default" />
          </Subnets>
        </InstanceAddress>
        <InstanceAddress roleName="TestWorkerRole">
          <Subnets>
            <Subnet name="default" />
          </Subnets>
        </InstanceAddress>
        <ReservedIPs>
          <ReservedIP name="cses-prod" />
        </ReservedIPs>
      </AddressAssignments>
    </NetworkConfiguration>
  </ServiceConfiguration>
  ```

## Workflow

The following diagram shows the actions that you have to take to make the VIP swap.

:::image type="content" source="./media/manage-vip-swap-powershell/vip-swap-workflow.svg" alt-text="Diagram that outlines the workflow steps for swapping virtual IP addresses (VIPs) for different versions of an Azure Cloud Service." border="false" lightbox="./media/manage-vip-swap-powershell/vip-swap-workflow.svg":::

The actions are described in the following steps:

1. Create a production cloud service (`testcsesv1`), and map the production static public IP address (`cses-prod`) to the production cloud service.

2. When you have a new code version 2, create the staging cloud service (`testcsesv2`), and map the staging public IP address (`cses-stag`) to the staging cloud service.

3. Trigger a VIP swap operation to promote the staging cloud service to the production public IP address (`cses-prod`).

4. After you promote the new version of the cloud service from staging to production, the old cloud service version is removed.

5. When you have a new code version 3, create the cloud service (`testcsesv3`), and map the staging public IP address (`cses-stag`) to the new cloud service.

6. Trigger another VIP swap operation to promote the new cloud service version to the production public IP address (`cses-prod`).

These actions are described in more detail in the following sections.

### Step 1: Create a production cloud service to map the production IP address

The following PowerShell script initializes the production cloud service for step 1. In the [New-AzCloudService](/powershell/module/az.cloudservice/new-azcloudservice) cmdlet call, the `AllowModelOverride` parameter helps to override the role profile setting within the definition file. For more information, see [Override SKU settings in .cscfg and .csdef files for Cloud Services (extended support)](/azure/cloud-services-extended-support/override-sku).

```azurepowershell
# Define basic variables.
$csName = "testcsesv1" 
$csRG = "testcses"
$publicIPName = "cses-prod"
$publicIPRG = "testcses"
$location = "East US"
 
# Create the network profile.
$publicIP = Get-AzPublicIpAddress -Name $publicIPName -ResourceGroupName $publicIPRG
$feIpConfigParams = @{
    Name = $csName + '_FEIP'
    PublicIPAddressId = $publicIp.Id
}
$feIpConfig = New-AzCloudServiceLoadBalancerFrontendIPConfigurationObject @feIpConfigParams
$loadBalancerConfigParams = @{
    FrontendIPConfiguration = $feIpConfig
    Name = $csName + '_LB'
}
$loadBalancerConfig = New-AzCloudServiceLoadBalancerConfigurationObject @loadBalancerConfigParams
$networkProfile = @{loadBalancerConfiguration = $loadBalancerConfig}

# Create the role profile.
$skuInfo = @{
    SkuCapacity = 1
    SkuName = 'Standard_A1_v2'
    SkuTier = 'Standard'
}
$role1 = New-AzCloudServiceRoleProfilePropertiesObject -Name "TestWebRole" @skuInfo
$role2 = New-AzCloudServiceRoleProfilePropertiesObject -Name "TestWorkerRole" @skuInfo
$roleProfile = @{role = @($role1,$role2)}
 
# Create the cloud service.
$azCloudServiceParams = @{
    Name = $csName
    ResourceGroupName = $csRG
    Location = $location
    AllowModelOverride = $true
    ConfigurationUrl = $cscfg
    NetworkProfile = $networkProfile
    PackageUrl = $cspkg
    RoleProfile = $roleProfile
}
New-AzCloudService @azCloudServiceParams
```

After you run this PowerShell script, Azure creates the cloud service, as shown in the following output:

```output
ResourceGroupName Name       Location ProvisioningState
----------------- ---------- -------- -----------------
TESTCSES          testcsesv1 eastus   Succeeded
```

In the [Azure portal][ap], you can view details about the new production cloud service. Search for and select **Cloud services (extended support)**, and then select the **testcsesv1** cloud service from the list of cloud services. In that cloud service's **Overview** page, the **Essentials** section displays the production IP address name in the **Public IP DNS name** field (`cses-prod.eastus.cloudapp.azure.com` in the workflow diagram).

### Step 2: Create a staging cloud service to map the staging IP address

When you have a new version of the cloud service, you can create it as the staging cloud service for step 2. In this step, we search for the production cloud service by using the production public IP address's front-end setting. To implement this step, when you define the network profile for the staging cloud service, make sure that you set the ID of its swappable cloud service property to the ID of the production cloud service.

```azurepowershell
# Define basic variables.
$csName = "testcsesv2"
$csRG = "testcses"
$publicIPName = "cses-stag"
$publicIPRG = "testcses"
$location = "East US"
$FEName = $csName+'_FEIP'   # Frontend IP address name
$LBName = $csName+'_LB'     # Load balancer name
 
# Pair to the production public IP address.
$prodPIPName= "cses-prod"
$prodPIPRG = "testcses"

# Get the properties of the production cloud service.
$prodPIPres = (Get-AzPublicIpAddress -Name $prodPIPName -ResourceGroupName $prodPIPRG).Id
$prodCS = (Get-AzCloudService) |
    Where-Object {
        $_.networkProfile.LoadBalancerConfiguration.FrontendIPConfiguration.PublicIPAddressId
            -eq $prodPIPres
    }
$csName_pair = $prodCS.Name
$csRG_pair = $prodCS.ResourceGroupName

# Create the network profile.
$publicIP = Get-AzPublicIpAddress -Name $publicIPName -ResourceGroupName $publicIPRG
$feIpConfigParams = @{
    Name = $csName + '_FEIP'
    PublicIPAddressId = $publicIp.Id
}
$feIpConfig = New-AzCloudServiceLoadBalancerFrontendIPConfigurationObject @feIpConfigParams
$loadBalancerConfigParams = @{
    FrontendIPConfiguration = $feIpConfig
    Name = $csName + '_LB'
}
$loadBalancerConfig = New-AzCloudServiceLoadBalancerConfigurationObject @loadBalancerConfigParams
$networkProfile = New-Object Microsoft.Azure.PowerShell.Cmdlets.CloudService.Models.Api20210301.CloudServiceNetworkProfile

# Set the network profile's load balancer configuration and swappable cloud service ID.
$networkProfile.LoadBalancerConfiguration = $loadBalancerConfig 
$networkProfile.SwappableCloudService.Id = (
    Get-AzCloudService -Name $csName_pair -ResourceGroup $csRG_pair
).Id

# Create the role profile.
$skuInfo = @{
    SkuCapacity = 1
    SkuName = 'Standard_A1_v2'
    SkuTier = 'Standard'
}
$role1 = New-AzCloudServiceRoleProfilePropertiesObject -Name "TestWebRole" @skuInfo
$role2 = New-AzCloudServiceRoleProfilePropertiesObject -Name "TestWorkerRole" @skuInfo
$roleProfile = @{role = @($role1,$role2)}
 
# Create the cloud service.
$azCloudServiceParams = @{
    Name = $csName
    ResourceGroupName = $csRG
    Location = $location
    AllowModelOverride = $true
    ConfigurationUrl = $cscfg
    NetworkProfile = $networkProfile
    PackageUrl = $cspkg
    RoleProfile = $roleProfile
}
New-AzCloudService @azCloudServiceParams
```

After you run this PowerShell script, Azure creates the cloud service and pairs it to the staging public IP address, as shown in the following output:

```output
ResourceGroupName Name       Location ProvisioningState
----------------- ---------- -------- -----------------
TESTCSES          testcsesv2 eastus   Succeeded
```

In the [Azure portal][ap], you can verify that this new staging cloud service is set up to be swappable with the production cloud service. Search for and select **Cloud services (extended support)**, and then select the **testcsesv2** cloud service from the list of cloud services. On the **Overview** page for that cloud service, the **Essentials** section displays the staging IP address name in the **Public IP DNS name** field (`cses-stag.eastus.cloudapp.azure.com` in the workflow diagram). Also, that section displays a **Swappable cloud service** value of **testcsesv1**. Conversely, if you selected **testcsesv1** from the list of cloud services, the **Swappable cloud service** value is shown as **testcsesv2**.

### Step 3: Trigger the VIP swap to map the production IP address to the staging cloud service

You can use the [Load Balancers - Swap Public Ip Addresses](/rest/api/load-balancer/load-balancers/swap-public-ip-addresses) REST API on the front-end configuration to help swap the IP address of the cloud services. You can use the URL in the response header to verify that the asynchronous operation has finished.

The VIP swap operation uses the `Azure-AsyncOperation` request for Azure Resource Manager. For more information about swap operations, see [Track asynchronous Azure operations](/azure/azure-resource-manager/management/async-operations).

```azurepowershell
# Get the staging public IP address.
$stagPIP = "cses-stag"
$stagPIPRG = "testcses"
$stagPIPres = Get-AzPublicIpAddress -Name $stagPIP -ResourceGroupName $stagPIPRG
$stagPIPID = $stagPIPres.id
$stagPIPFEID = $stagPIPres.IpConfiguration.id
 
# Get the production public IP address.
$prodPIP = "cses-prod"
$prodPIPRG = "testcses"
$prodPIPres = Get-AzPublicIpAddress -Name $prodPIP -ResourceGroupName $prodPIPRG
$prodPIPID = $prodPIPres.id
$prodPIPFEID = $prodPIPres.IpConfiguration.id
 
$Payload = (
    '{"frontendIPConfigurations":[{"properties":{"publicIPAddress":{"id":"', $prodPIPID,
    '"}},"id":"', $stagPIPFEID,
    '"},{"properties":{"publicIPAddress":{"id":"', $stagPIPID,
    '"}},"id":"', $prodPIPFEID,
    '"}]}'
) -Join ""
 
$subID = (Get-AzContext).Subscription.id
$location = $prodPIPres.Location
$url = (
    "/subscriptions/", $subID,
    "/providers/Microsoft.Network/locations/", $location,
    "/setLoadBalancerFrontendPublicIpAddresses?api-version=2021-02-01"
) -Join ""

# Start a swap operation.
$result = Invoke-AzRestMethod -Path $url -Method POST -Payload $Payload
If ($result.StatusCode -eq 202)
{
    $async_url = (
        $result.Headers | Where-Object {$_.Key -eq "Azure-AsyncOperation"}
    ).Value[0]
    $code = 0
    Do {
        $code = (Invoke-AzRestMethod -Uri $async_url -Method Get).StatusCode
        If ($code -eq 200) {
              Write-Host "Swap Completed!"
        }
        Else {
              Write-Host "In Swapping... Retry after 5 seconds"
              Start-Sleep -Seconds 5 
        }
    } While (!($code -eq 200))
}
```

### Step 4: Remove the staging cloud service that was swapped out from production

Remove the cloud service that now has the staging public IP address. This cloud service was previously the production cloud service. However, in the previous step, it was swapped with the new version of the cloud service. The staging IP address is now mapped to this old version. Therefore, the old cloud service can now be safely removed.

```azurepowershell
# Define basic variables.
$prodPIPName = "cses-prod"
$prodPIPRG = "testcses"
$stagPIPName= "cses-stag"
$stagPIPRG = "testcses"

# Get the cloud service that has the production public IP address.
$prodPIPres = (Get-AzPublicIpAddress -Name $prodPIPName -ResourceGroupName $prodPIPRG).Id
$prodCS = (Get-AzCloudService) |
    Where-Object {
        $_.networkProfile.LoadBalancerConfiguration.FrontendIPConfiguration.PublicIPAddressId
            -eq $prodPIPres
    }

# Get the cloud service that has the staging public IP address.
$stagPIPres = (Get-AzPublicIpAddress -Name $stagPIPName -ResourceGroupName $stagPIPRG).Id
$stagCS = (Get-AzCloudService) |
    Where-Object {
        $_.networkProfile.LoadBalancerConfiguration.FrontendIPConfiguration.PublicIPAddressId
            -eq $stagPIPres
    }
                
# Remove the cloud service that has the staging name.
Remove-AzCloudService -Name $stagCS.Name -ResourceGroupName $stagCS.ResourceGroupName
```

Now, you should be able to see the new cloud service version being mapped to the production public IP address name. Additionally, the swappable cloud service will no longer be visible.

In the [Azure portal][ap], search for and select **Cloud services (extended support)**, and then select the **testcsesv2** cloud service from the list of cloud services. (There won't be a **testcsesv1** cloud service listed anymore.) On the **Overview** page for that cloud service, the **Essentials** section no longer displays a **Swappable cloud service** field (that formerly contained a value of **testcsesv1**). The **Public IP DNS name** field now displays the production IP address (`cses-prod.eastus.cloudapp.azure.com` in the workflow diagram).

### Steps 5 and 6: Swap the new version of the cloud service with a third version

You can repeat steps 2 through 4 to configure the third version of the cloud service to put it into production and also remove the second cloud service version. You must modify the cloud service names, as described in the following summary of actions:

1. Create a third version of the cloud service as staging cloud service `testcsesv3` that's mapped with the staging public IP address.

1. Swap this third version of the cloud service with the second version (`testcsesv2`, now mapped with the production IP address after it was set up with the staging IP address).

1. Remove the second version of the cloud service (`testcsesv2`, now mapped to the staging IP address again).

## Limitations of VIP swap operations

For more information about the limitations of the VIP swap operation, see [Swap or switch deployments in Azure Cloud Services (extended support)](/azure/cloud-services-extended-support/swap-cloud-service).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[ap]: https://portal.azure.com
