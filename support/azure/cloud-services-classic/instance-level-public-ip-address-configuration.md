---
title: Instance-level public IP address configuration in Cloud Services
description: Learn more about instance-level public IP address configuration in Microsoft Azure Cloud Services.
ms.date: 03/15/2023
editor: v-jsitser
ms.topic: how-to
ms.reviewer: maheshallu, piw, v-frpan, v-leedennis
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
---
# Instance-level public IP address configuration in Cloud Services

This article discusses how to configure an instance-level public IP address (PIP) in Microsoft Azure Cloud Services (classic) and Azure Cloud Services (extended support). Unlike a virtual IP address (VIP), an instance-level public IP address isn't load-balanced. A VIP is assigned to the cloud service, and all virtual machines and role instances in the cloud service share that VIP. However, a public IP address (PIP) is associated with only the network adapter of a single instance. The public IP address is useful in multi-instance deployments in which each instance can be reachable independently from the internet. The following diagram illustrates the value of the PIP and differentiates it from the VIP.

:::image type="content" source="./media/instance-level-public-ip-address-configuration/public-ip-virtual-ip-relationship.svg" alt-text="Diagram that shows the relationship between public IP addresses, virtual IP addresses, and the internet in Microsoft Azure Cloud Services." lightbox="./media/instance-level-public-ip-address-configuration/public-ip-virtual-ip-relationship.svg" border="false":::

In the diagram, network traffic that's sent to the VIP is shown as load-balanced between datacenter IP address (DIP) 1 and DIP 2. However, traffic that's sent to PIP 1 always goes to DIP 1, and traffic that's sent to PIP 2 always goes to DIP 2. A datacenter IP address is the private IP address of the virtual machine (VM).

For more information, see the [Instance-level public IP address](https://azure.microsoft.com/blog/instance-level-public-ip-address/) Azure Blog article.

## Procedure for Azure Cloud Services (classic)

1. Configure an instance-level public IP address by role:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <ServiceConfiguration
           serviceName="TestVirtualnetwork"
           xmlns="http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceConfiguration"
           osFamily="6"
           osVersion="*"
           schemaVersion="2015-04.2.6">
       <Role name="WebRole1">
           <Instances count="1" />
           <ConfigurationSettings>
               <Setting name="APPINSIGHTS_INSTRUMENTATIONKEY" value="xxx" />
           </ConfigurationSettings>
       </Role>
       <Role name="WebRole2">
           <Instances count="1" />
           <ConfigurationSettings>
               <Setting name="APPINSIGHTS_INSTRUMENTATIONKEY" value="xxx" />
           </ConfigurationSettings>
       </Role>
       <Role name="WebRole3">
           <Instances count="1" />
           <ConfigurationSettings>
               <Setting name="APPINSIGHTS_INSTRUMENTATIONKEY" value="xxx" />
           </ConfigurationSettings>
       </Role>
       <Role name="WebRole4">
           <Instances count="1" />
           <ConfigurationSettings>
               <Setting name="APPINSIGHTS_INSTRUMENTATIONKEY" value="xxx" />
           </ConfigurationSettings>
       </Role>
       <NetworkConfiguration>
           <VirtualNetworkSite name="Group RESOURCE_GROUP VIRTUAL_NETWORK_NAME" />
           <AddressAssignments>
               <InstanceAddress roleName="WebRole1">
                   <Subnets><Subnet name="subnet001" /></Subnets>
                   <PublicIPs>
                       <PublicIP name="PubIP" domainNameLabel="pip" />  <!-- with domain -->
                   </PublicIPs>
               </InstanceAddress>
               <InstanceAddress roleName="WebRole2">
                   <Subnets><Subnet name="subnet003" /></Subnets>
                   <PublicIPs>
                       <PublicIP name="PubIP"/>                         <!-- without domain -->
                   </PublicIPs>
               </InstanceAddress>
           </AddressAssignments>
       </NetworkConfiguration>
   </ServiceConfiguration>
   ```

1. Get the current public IP address of a role by using one of the following methods.

   ## [PowerShell](#tab/powershell)

   For each role instance, run the [Get-AzureRole](/powershell/module/servicemanagement/azure/get-azurerole) PowerShell cmdlet. This cmdlet is based on the `Azure.Service` module. By using the IP address configuration in the previous step, we can see the difference between the instance details of each role instance.

   1. View the details of the `WebRole2` role, whose public IP name doesn't have a domain name label:

      ```azurepowershell
      $roleParams = @{
          ServiceName = "<cloud-service-name>"
          Slot = "Production"
          RoleName = "WebRole2"
          InstanceDetails = $true
      }
      Get-AzureRole @roleParams
      ```

      The cmdlet output resembles the following text:

      ```output
      InstanceEndpoints            : {Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput, Endpoint1}
      InstanceErrorCode            : 
      InstanceFaultDomain          : 0
      InstanceName                 : WebRole2_IN_0
      InstanceSize                 : Standard_D1_v2
      InstanceStateDetails         : 
      InstanceStatus               : ReadyRole
      InstanceUpgradeDomain        : 0
      RoleName                     : WebRole2
      DeploymentID                 : 0123456789abcdef0123456789abcdef
      IPAddress                    : 10.2.2.5
      PublicIPAddress              : 20.115.22.157
      PublicIPName                 : PubIP
      PublicIPIdleTimeoutInMinutes : 
      PublicIPDomainNameLabel      : 
      PublicIPFqdns                : {}
      ServiceName                  : contoso-vnet-pip
      OperationDescription         : Get-AzureRole
      OperationId                  : 12345678-9abc-def0-1234-56789abcdef0
      OperationStatus              : Succeeded
      ```

   1. Now view the details of the `WebRole1` role, which uses the same public IP name but also has a domain name label:

      ```azurepowershell
      $roleParams = @{
          ServiceName = "<cloud-service-name>"
          Slot = "Production"
          RoleName = "WebRole1"
          InstanceDetails = $true
      }
      Get-AzureRole @roleParams
      ```

      In the cmdlet output, the `InstanceEndpoints`, `InstanceName`, `InstanceStatus`, `RoleName`, `IPAddress`, `PublicIPAddress`, `PublicIPDomainNameLabel`, `PublicIPFqdns`, and `OperationId` values are different:

      ```output
      InstanceEndpoints            : {Endpoint1}
      InstanceErrorCode            : 
      InstanceFaultDomain          : 0
      InstanceName                 : WebRole1_IN_0
      InstanceSize                 : Standard_D1_v2
      InstanceStateDetails         : 
      InstanceStatus               : StoppedVM
      InstanceUpgradeDomain        : 0
      RoleName                     : WebRole1_IN_0
      DeploymentID                 : 0123456789abcdef0123456789abcdef
      IPAddress                    : 10.2.0.4
      PublicIPAddress              : 20.168.229.192
      PublicIPName                 : PubIP
      PublicIPIdleTimeoutInMinutes : 
      PublicIPDomainNameLabel      : pip
      PublicIPFqdns                : {pip.contoso-vnet-pip.cloudapp.net, pip.0.contoso-vnet-pip.cloudapp.net}
      ServiceName                  : contoso-vnet-pip
      OperationDescription         : Get-AzureRole
      OperationId                  : 23456789-abcd-ef01-2345-6789abcdef01
      OperationStatus              : Succeeded
      ```

   ## [IMDS](#tab/imds)

   The [Azure Instance Metadata Service](/azure/virtual-machines/windows/instance-metadata-service) (IMDS) provides information about VM instances that are currently running. You can use IMDS to review the network adapter level setting of your VM. On each VM instance, run the [Invoke-RestMethod](/powershell/module/microsoft.powershell.utility/invoke-restmethod) PowerShell cmdlet in the following code snippet:

   ```azurepowershell
   $restMethodParams = @{
       Method = "Get"
       Uri = "http://169.254.169.254/metadata/instance?api-version=2021-02-01"
       Headers = @{"Metadata" = "true"}
       NoProxy = $true
   }
   Invoke-RestMethod @restMethodParams | ConvertTo-Json -Depth 64
   ```

   The cmdlet output resembles the following JSON code:

   ```json
   {
     "network": {
       "interface": [
         {
           "ipv4": {
             "ipAddress": [
               {
                 "privateIpAddress": "10.2.2.5",
                 "publicIpAddress": "20.115.22.157"
               }
             ],
             "subnet": [
               {
                 "address": "10.2.2.0",
                 "prefix": "24"
               }
             ]
           },
           "ipv6": {
             "ipAddress": []
           },
           "macAddress": "0003FF95519C"
         }
       ]
     }
   }
   ```

   ---

## Procedure for Azure Cloud Services (extended support)

1. Configure an instance-level public IP address by role:

   ```xml
   <?xml version="1.0" encoding="utf-16"?>
   <ServiceConfiguration
           xmlns:xsd="http://www.w3.org/2001/XMLSchema"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           serviceName="Test_cloudservice"
           osFamily="6"
           osVersion="*"
           schemaVersion="2015-04.2.6"
           xmlns="http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceConfiguration">
       <Role name="TestWebRole">
           <ConfigurationSettings>
               <Setting
                       name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString"
                       value="UseDevelopmentStorage=true" />
           </ConfigurationSettings>
           <Instances count="2" />
       </Role>
       <Role name="TestWorkerRole">
           <ConfigurationSettings>
               <Setting
                       name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString"
                       value="UseDevelopmentStorage=true" />
           </ConfigurationSettings>
           <Instances count="1" />
       </Role>
       <NetworkConfiguration>
           <VirtualNetworkSite name="test001VNet" />
           <AddressAssignments>
               <InstanceAddress roleName="TestWebRole">
                   <Subnets>
                       <Subnet name="default" />
                   </Subnets>
                   <PublicIPs>
                       <PublicIP name="PubIP" domainNameLabel="pip" />
                   </PublicIPs>
               </InstanceAddress>
               <InstanceAddress roleName="TestWorkerRole">
                   <Subnets>
                       <Subnet name="default" />
                   </Subnets>
               </InstanceAddress>
               <ReservedIPs>
                   <ReservedIP name="Group TESTCSES cses-prod" />
               </ReservedIPs>
           </AddressAssignments>
       </NetworkConfiguration>
   </ServiceConfiguration>
   ```

1. Use the [PublicIPAddress In CloudService - List Cloud Service Public IP Addresses](/rest/api/virtualnetwork/public-ip-address-in-cloud-service/list-cloud-service-public-ip-addresses) REST API to get the public IP address of the network adapter. The following code snippet shows an example JSON response:

   ```json
   {
     "value": [
       {
         "name": "PubIP",
         "id": "/subscriptions/<your-subscription-guid>/resourceGroups/TESTCSES/providers/Microsoft.Compute/cloudServices/testcsesv2/roleInstances/TestWebRole_IN_0/networkInterfaces/nic1/ipConfigurations/ipconfig1/publicIPAddresses/PubIP",
         "etag": "W/\"3456789a-bcde-f012-3456-789abcdef012\"",
         "location": "eastus",
         "properties": {
           "provisioningState": "Succeeded",
           "resourceGuid": "<your-resource-guid>",
           "ipAddress": "20.169.153.231",
           "publicIPAddressVersion": "IPv4",
           "publicIPAllocationMethod": "Dynamic",
           "idleTimeoutInMinutes": 4,
           "dnsSettings": {
             "domainNameLabel": "pip.0.cses-prod",
             "fqdn": "pip.0.cses-prod.eastus.cloudapp.azure.com"
           },
           "ipTags": [],
           "ipConfiguration": {
             "id": "/subscriptions/<your-subscription-guid>/resourceGroups/TESTCSES/providers/Microsoft.Compute/cloudServices/testcsesv2/roleInstances/TestWebRole_IN_0/networkInterfaces/nic1/ipConfigurations/ipconfig1"
           }
         },
         "sku": {
           "name": "Basic",
           "tier": "Regional"
         }
       },
       {
         "name": "PubIP",
         "id": "/subscriptions/<your-subscription-guid>/resourceGroups/TESTCSES/providers/Microsoft.Compute/cloudServices/testcsesv2/roleInstances/TestWebRole_IN_1/networkInterfaces/nic1/ipConfigurations/ipconfig1/publicIPAddresses/PubIP",
         "etag": "W/\"456789ab-cdef-0123-4567-89abcdef0123\"",
         "location": "eastus",
         "properties": {
           "provisioningState": "Succeeded",
           "resourceGuid": "<your-resource-guid>",
           "ipAddress": "20.231.68.190",
           "publicIPAddressVersion": "IPv4",
           "publicIPAllocationMethod": "Dynamic",
           "idleTimeoutInMinutes": 4,
           "dnsSettings": {
             "domainNameLabel": "pip.1.cses-prod",
             "fqdn": "pip.1.cses-prod.eastus.cloudapp.azure.com"
           },
           "ipTags": [],
           "ipConfiguration": {
             "id": "/subscriptions/<your-subscription-guid>/resourceGroups/TESTCSES/providers/Microsoft.Compute/cloudServices/testcsesv2/roleInstances/TestWebRole_IN_1/networkInterfaces/nic1/ipConfigurations/ipconfig1"
           }
         },
         "sku": {
           "name": "Basic",
           "tier": "Regional"
         }
       }
     ]
   }
   ```

Although the two objects in the `value` array both have a `name` key value of `PubIP`, there are differences in the IP address and DNS settings within the respective `properties` keys. The `ipAddress` key has a value of `20.169.153.231` in the first array object and `20.231.68.190` in the second array object. The `dnsSettings` key has a value of `pip.0.cses-prod` in the first array object and `pip.1.cses-prod` in the second array object.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
