---
title: Troubleshoot virtual network issues
description: Learn how to troubleshoot common scenarios for virtual networks in Microsoft Power Platform.
ms.component: pa-admin
ms.date: 02/26/2026
ms.author: faix, sericks, v-shaywood
search.audienceType: 
  - admin
ms.custom: sap:Environment - Administration

#customer intent: As a developer or IT administrator, I want to troubleshoot my virtual network configuration in Power Platform so that my applications work as intended.
---

# Troubleshoot virtual network issues

This article provides guidance to troubleshoot common scenarios for [virtual networks](/power-platform/admin/vnet-support-overview) in Microsoft Power Platform. It focuses on using the [Microsoft.PowerPlatform.EnterprisePolicies](https://www.powershellgallery.com/packages/Microsoft.PowerPlatform.EnterprisePolicies) PowerShell module to help you identify and resolve issues that are related to virtual network configurations.

## Use the diagnostics PowerShell module

The `Microsoft.PowerPlatform.EnterprisePolicies` PowerShell module helps you diagnose and troubleshoot issues that are related to virtual network configurations in Power Platform. You can use the tool to check the connectivity between your Power Platform environment and your virtual network. You can also use it to identify any misconfigurations that might be causing issues. This diagnostics PowerShell module is available from the PowerShell Gallery and its GitHub repository, [PowerPlatform-EnterprisePolicies](https://github.com/microsoft/PowerPlatform-EnterprisePolicies).

### Install the module

To install the diagnostics PowerShell module, run the following PowerShell command:

```powershell
Install-Module -Name Microsoft.PowerPlatform.EnterprisePolicies
```

### Run the diagnostic functions

After you install the module, import it into your PowerShell session by running the following command:

```powershell
Import-Module Microsoft.PowerPlatform.EnterprisePolicies
```

The module includes several functions to diagnose and troubleshoot issues that are related to virtual network configurations. Some of the key functions are:

- [Get-EnvironmentRegion](/powershell/module/microsoft.powerplatform.enterprisepolicies/Get-EnvironmentRegion): Retrieves the region of the specified Power Platform environment.
- [Get-EnvironmentUsage](/powershell/module/microsoft.powerplatform.enterprisepolicies/Get-EnvironmentUsage): Provides information about the usage of the specified Power Platform environment.
- [Test-DnsResolution](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-DnsResolution): Tests the DNS resolution for the specified domain name.
- [Test-NetworkConnectivity](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-NetworkConnectivity): Tests the network connectivity between the Power Platform environment and the destination resource.
- [Test-TLSHandshake](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-TLSHandshake): Tests whether a TLS handshake can be established between the Power Platform environment and the destination resource.

For a full list of available functions within the diagnostics module, see [Microsoft.PowerPlatform.EnterprisePolicies Module](/powershell/module/microsoft.powerplatform.enterprisepolicies).

### Report issues in the diagnostics module

If you encounter issues when you run the diagnostics module, report them through the GitHub repository where the module is hosted. The repository is available at: [PowerPlatform-EnterprisePolicies](https://github.com/microsoft/PowerPlatform-EnterprisePolicies).

To report an issue, go to the **Issues** section of the repository, and [open a new issue](https://github.com/microsoft/PowerPlatform-EnterprisePolicies/issues/new). Provide detailed information about the issue that you encounter, including any error messages or log entries that might help when you investigate the issue. Don't include any sensitive information in your report.

## Troubleshoot common issues

### One environment works but another doesn't

If everything is correctly configured, but you still encounter issues, use the [Get-EnvironmentRegion](/powershell/module/microsoft.powerplatform.enterprisepolicies/Get-EnvironmentRegion) function from the diagnostics PowerShell module to check whether the regions of your Power Platform environments are the same. Run the following command:

```powershell
Get-EnvironmentRegion -EnvironmentId "<EnvironmentId>"
```

If the environments are in different regions, and one works but the other doesn't, the issue is in the virtual network setup for the failing region. To make sure that your full setup is configured correctly, run any further diagnostic commands against both regions. To specify a region, include the `-Region` parameter. For example:

```powershell
Test-DnsResolution -EnvironmentId "<EnvironmentId>" -HostName "<HostName>" -Region "<AzureRegion>"
```

Your environment belongs to a specific Power Platform geography. However, a Power Platform region can span two Azure regions. Your environment can be located in either region, and it can also automatically fail over between them. Therefore, to ensure high availability and connectivity, you have to configure your virtual networks in both Azure regions that are associated with your Power Platform region. To learn how Power Platform regions map to Azure regions that support the virtual network functionality, see [Power Platform regions](/power-platform/admin/vnet-support-overview#supported-regions).

### Hostname not found

If you encounter issues that affect hostname resolution, use the [Test-DnsResolution](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-DnsResolution) function from the diagnostics PowerShell module to check whether the hostname is resolved correctly. Run the following command:

```powershell
Test-DnsResolution -EnvironmentId "<EnvironmentId>" -HostName "<HostName>"
```

This command tests the DNS resolution for the specified hostname in the context of your Power Platform environment. The request initiates from your delegated subnet, and tries to resolve the hostname by using the DNS server that's configured for your virtual network. If the hostname isn't resolved correctly, you might have to check your DNS settings to make sure that the hostname is configured correctly.

> [!IMPORTANT]
> If you notice that your DNS setup is incorrect, and you have to update the DNS server settings for your virtual network, see [Can I update the DNS address of my virtual network after it's delegated to "Microsoft.PowerPlatform/enterprisePolicies"?](/power-platform/admin/vnet-support-overview#can-i-update-the-dns-address-of-my-virtual-network-after-its-delegated-to-microsoftpowerplatformenterprisepolicies)

### Request uses a public IP address instead of the private IP address

If you encounter issues in which requests to a resource use a public IP address instead of the private IP address, the DNS resolution for the resource hostname might be returning a public IP address. This issue can affect both Azure and non-Azure resources.

#### Non-Azure resource without a private endpoint

If a non-Azure resource doesn't have a private endpoint, but you can access it from your virtual network, you have to configure your DNS server to resolve the resource's hostname to its private IP address. Add a DNS *A* record to your DNS server that maps the resource's hostname to its private IP address:

- If you're using a custom DNS server, add the A record directly to your server.
- If you're using an Azure-provided DNS, create an [Azure Private DNS Zone](/azure/dns/private-dns-overview), and link it to your virtual network. Then, add the A record to the private DNS zone.

This mapping makes sure that you access the resource through its private IP address.

#### Azure resource that has a private endpoint

If an Azure resource has a private endpoint, the DNS resolution for the resource's hostname should return the private IP address that's associated with the private endpoint. If the DNS resolution returns a public IP address instead, your DNS configuration might be missing records. Follow these steps:

1. Verify that a private DNS zone exists for your resource type. For example, `privatelink.database.windows.net` for Azure SQL Database. If the private DNS zone doesn't exist, [create one](/azure/dns/private-dns-getstarted-portal#create-a-private-dns-zone).
1. Verify that the private DNS zone is linked to your virtual network. If the private DNS zone isn't linked to your virtual network, [link it](/azure/dns/private-dns-virtual-network-links).

After you link the private DNS zone to your virtual network, the resource hostname should resolve to the private IP address that's associated with the private endpoint.

#### Test DNS configuration changes

After you update the DNS configuration, use the [Test-DnsResolution](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-DnsResolution) function from the diagnostics PowerShell module to verify that the hostname resolves to the correct private IP address. Run the following command:

```powershell
Test-DnsResolution -EnvironmentId "<EnvironmentId>" -HostName "<HostName>"
```

### Can't connect to the resource

If you experience issues that affect connectivity to a resource, use the [Test-NetworkConnectivity](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-NetworkConnectivity) function from the diagnostics PowerShell module to check for connectivity. Run the following command:

```powershell
Test-NetworkConnectivity -EnvironmentId "<EnvironmentId>" -Destination "<ResourceAddress>" -Port 1433
```

This command tries to establish a TCP connection to the specified destination and port in the context of your Power Platform environment. The request initiates from your delegated subnet, and it tries to connect to the specified destination by using the network configuration from your virtual network. If the connection fails, you might have to check your network settings to make sure that the destination is reachable from your virtual network. A successful connection indicates that network connectivity exists between the Power Platform environment and the specified resource.

> [!NOTE]
> This command tests only whether a TCP connection can be established to the specified destination and port. It doesn't test whether the resource is available or whether any application-level issues might be preventing access to the resource.

### Can't establish a TLS handshake

Some firewalls might allow TCP connections to be established, but then block actual traffic to the resource (for example, HTTPS). Therefore, even if the [Test-NetworkConnectivity](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-NetworkConnectivity) function indicates network connectivity, that status doesn't guarantee that the resource is fully accessible.

Use the [Test-TLSHandshake](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-TLSHandshake) function to diagnose why a handshake can't be established. Run the following command:

```powershell
Test-TLSHandshake -EnvironmentId "<EnvironmentId>" -Destination "<ResourceAddress>" -Port 1433
```

The command returns information that can help you debug why the handshake failed. The output includes the certificate that the server presented, the cipher suite, the protocol, and any SSL error descriptions.

> [!IMPORTANT]
> Only publicly trusted certificates are supported. For more information, see [Do you support unknown certificates?](/power-platform/admin/vnet-support-overview#my-on-premises-endpoint-tls-certificates-arent-signed-by-well-known-root-certification-authorities-ca-do-you-support-unknown-certificates)

### Connectivity is successful, but the application still isn't working

If the connectivity tests are successful, but you're still experiencing issues in your application, check the application-level settings and configurations:

1. Verify that your firewall allows access from the delegated subnet to the resource.
1. Verify that the certificate that the resource presents is publicly trusted.
1. Make sure that no authentication or authorization issues prevent access to the resource.

You might not be able to diagnose or resolve the issue by using the diagnostics PowerShell module. In this case, create a subnet without delegation in your virtual network, and deploy a virtual machine (VM) in that subnet. Then, you could use the VM to perform further diagnostics and troubleshooting steps, such as checking network traffic, analyzing logs, and testing application-level connectivity.
