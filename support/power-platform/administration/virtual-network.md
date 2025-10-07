---
title: Troubleshoot virtual network issues
description: Learn how to troubleshoot common scenarios for virtual networks in Microsoft Power Platform.
author: faix
ms.component: pa-admin
ms.topic: troubleshooting-general
ms.date: 09/15/2025
ms.author: osfaixat
ms.reviewer: sericks
search.audienceType: 
  - admin
contributors:
ms.custom: sap:Environment - Administration

#customer intent: As a developer or IT administrator, I want to troubleshoot my virtual network configuration in Power Platform so that my applications work as intended.
---

# Troubleshoot virtual network issues

This article provides guidance to troubleshoot common scenarios for [virtual networks](/power-platform/admin/vnet-support-overview) in Microsoft Power Platform. This article focuses on the use of the [Microsoft.PowerPlatform.EnterprisePolicies](https://www.powershellgallery.com/packages/Microsoft.PowerPlatform.EnterprisePolicies) PowerShell module to help you identify and resolve issues that are related to virtual network configurations.

## Use the diagnostics PowerShell module

The `Microsoft.PowerPlatform.EnterprisePolicies` PowerShell module is designed to help you diagnose and troubleshoot issues that are related to virtual network configurations in Power Platform. You can use the tool to check the connectivity between your Power Platform environment and your virtual network. You can also use it to identify any misconfigurations that might be causing issues. This diagnostics PowerShell module is available from the PowerShell Gallery and its GitHub repository: [PowerPlatform-EnterprisePolicies](https://github.com/microsoft/PowerPlatform-EnterprisePolicies).

### Install the module

To install the diagnostics PowerShell module, run the following PowerShell command:

```powershell
Install-Module -Name Microsoft.PowerPlatform.EnterprisePolicies
```

### Run the diagnostic functions included in the module

After the module is installed, import it into your PowerShell session by running the following command:

```powershell
Import-Module Microsoft.PowerPlatform.EnterprisePolicies
```

The module includes several functions to diagnose and troubleshoot issues that are related to virtual network configurations. Some of the key functions are as follows:

- [Get-EnvironmentRegion](https://github.com/microsoft/PowerPlatform-EnterprisePolicies/blob/main/docs/en-US/Microsoft.PowerPlatform.EnterprisePolicies/Get-EnvironmentRegion.md): Retrieves the region of the specified Power Platform environment
- [Get-EnvironmentUsage](https://github.com/microsoft/PowerPlatform-EnterprisePolicies/blob/main/docs/en-US/Microsoft.PowerPlatform.EnterprisePolicies/Get-EnvironmentUsage.md): Provides information about the usage of the specified Power Platform environment
- [Test-DnsResolution](https://github.com/microsoft/PowerPlatform-EnterprisePolicies/blob/main/docs/en-US/Microsoft.PowerPlatform.EnterprisePolicies/Test-DnsResolution.md): Tests the DNS resolution for the specified domain name
- [Test-NetworkConnectivity](https://github.com/microsoft/PowerPlatform-EnterprisePolicies/blob/main/docs/en-US/Microsoft.PowerPlatform.EnterprisePolicies/Test-NetworkConnectivity.md): Tests the network connectivity between the Power Platform environment and the specified virtual network

### Report issues in the diagnostics module

If you encounter issues when you run the diagnostics module, report them through the GitHub repository where the module is hosted. The repository is available at: [PowerPlatform-EnterprisePolicies](https://github.com/microsoft/PowerPlatform-EnterprisePolicies).

To report an issue, go to the **Issues** section of the repository, and [open a new issue](https://github.com/microsoft/PowerPlatform-EnterprisePolicies/issues/new). Provide detailed information about the issue that you experience, including any error messages or log entries that might help when investigating the issue. Don't include any sensitive information in your report.

## Troubleshoot common issues

### Misconfiguration of regions

If everything is correctly configured but you still experience issues, use the `Get-EnvironmentRegion` function from the diagnostics PowerShell module to check whether the regions of your Power Platform environment are the same as the regions of your virtual network. Run the following command:

```powershell
Get-EnvironmentRegion -EnvironmentId "<EnvironmentId>"
```

Your environment belongs to a specific PowerPlatform region. However, a PowerPlatform region can span two Azure regions. You have to make sure that your virtual network is configured in both the Azure regions that correspond to your PowerPlatform region. Your environment can be located in either of the two Azure regions, and it can also automatically fail over between them. Therefore, to ensure high availability and connectivity, you should configure your virtual network in both Azure regions that are associated with your PowerPlatform region. To learn how PowerPlatform regions map to Azure regions that support the virtual network functionality, see [Power Platform regions](/power-platform/admin/vnet-support-overview#supported-regions).

### Hostname not found

If you experience issues that affect hostname resolution, use the `Test-DnsResolution` function from the diagnostics PowerShell module to check whether the hostname is resolved correctly. Run the following command:

```powershell
Test-DnsResolution -EnvironmentId "<EnvironmentId>" -HostName "<HostName>"
```

This command tests the DNS resolution for the specified hostname in the context of your Power Platform environment. The request initiates from your delegated subnet and tries to resolve the hostname by using the DNS server configured for your virtual network. If the hostname isn't resolved correctly, you might have to check your DNS settings to make sure that the hostname is configured correctly.

> [!IMPORTANT]
> If you notice that your DNS setup is incorrect, and you have to update the DNS server settings for your virtual network, see [Can I update the DNS address of my virtual network after it's delegated to "Microsoft.PowerPlatform/enterprisePolicies"?](/power-platform/admin/vnet-support-overview#can-i-update-the-dns-address-of-my-virtual-network-after-its-delegated-to-microsoftpowerplatformenterprisepolicies)

### Request uses a public IP address instead of the private IP address

If you experience issues where requests to a resource use a public IP address instead of the private IP address, the DNS resolution for the resource's hostname might be returning a public IP address. This issue can occur with both Azure and non-Azure resources.

#### Non-Azure resource without a private endpoint

If a non-Azure resource doesn't have a private endpoint but is accessible from your virtual network, your DNS server should be configured to resolve the resource's hostname to its private IP address. Add a DNS *A* record to your DNS server that maps the resource's hostname to its private IP address. This mapping ensures the resource is accessed via its private IP address.

- If you're using a custom DNS server, add the A record directly to your server.
- If you're using an Azure provided DNS, create an [Azure Private DNS Zone](/azure/dns/private-dns-overview) and link it to your virtual network. Then, add the A record to the private DNS zone.

#### Azure resource with a private endpoint

If an Azure resource has a private endpoint, the DNS resolution for the resource's hostname should return the private IP address associated with the private endpoint. If the DNS resolution returns a public IP address instead, there might be missing records in your DNS configuration.

1. Confirm there's a private DNS zone for your resource type. For example, `privatelink.database.windows.net` for Azure SQL Database.
   1. If the private DNS zone doesn't exist, [create a new one](/azure/dns/private-dns-getstarted-portal#create-a-private-dns-zone).
1. Verify that the private DNS zone is linked to your virtual network.
   1. If the private DNS zone isn't linked, [link it to your virtual network](/azure/dns/private-dns-virtual-network-links).

Once the private DNS zone is linked to your virtual network, the resource's hostname should resolve to the private IP address associated with the private endpoint.

#### Test DNS configuration changes

After updating your DNS configuration, use the `Test-DnsResolution` function from the diagnostics PowerShell module to verify that the hostname resolves to the correct private IP address. Run the following command:

```powershell
Test-DnsResolution -EnvironmentId "<EnvironmentId>" -HostName "<HostName>"
```

### Can't connect to the resource

If you experience issues that affect connectivity to a resource, use the `Test-NetworkConnectivity` function from the diagnostics PowerShell module to check for connectivity. Run the following command:

```powershell
Test-NetworkConnectivity -EnvironmentId "<EnvironmentId>" -Destination "<ResourceAddress>" -Port 1433
```

This command tries to establish a TCP connection to the specified destination and port in the context of your Power Platform environment. The request initiates from your delegated subnet and tries to connect to the specified destination by using the network configuration from your virtual network. If the connection fails, you might have to check your network settings to make sure that the destination is reachable from your virtual network. If the connection is successful, it indicates that network connectivity exists between the Power Platform environment and the specified resource.

> [!NOTE]
> This command tests only whether a TCP connection can be established to the specified destination and port. It doesn't test whether the resource is available or whether any application-level issues might be preventing access to the resource.
> Some firewalls might allow TCP connections to be established, but they then block actual traffic to the resource (for example, HTTPS). Therefore, even if the command indicates network connectivity, that status doesn't guarantee that the resource is fully accessible.

### Connectivity is successful, but the application is still not working

If the connectivity tests are successful, but you're still experiencing issues in your application, you might have to check the application-level settings and configurations, as follows:

- Verify that your firewall allows access from the delegated subnet to the resource.
- Verify that the certificate presented by the resource is publicly trusted.
- Make sure that no authentication or authorization issues exist that are preventing access to the resource.

You might not be able to diagnose or resolve the issue by using the diagnostics PowerShell module. In that case, create a subnet without delegation in your virtual network, and deploy a virtual machine (VM) in that subnet. You can then use the VM to perform further diagnostics and troubleshooting steps, such as checking network traffic, analyzing logs, and testing application-level connectivity.
