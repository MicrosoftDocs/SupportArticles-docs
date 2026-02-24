---
title: Troubleshoot virtual network issues
description: Learn how to troubleshoot common scenarios for virtual networks in Microsoft Power Platform.
author: faix
ms.component: pa-admin
ms.topic: troubleshooting-general
ms.date: 02/24/2026
ms.author: osfaixat
ms.reviewer: sericks
search.audienceType: 
  - admin
contributors:
ms.custom: sap:Environment - Administration

#customer intent: As a developer or IT administrator, I want to troubleshoot my virtual network configuration in Power Platform so that my applications work as intended.
---

# Troubleshoot virtual network issues

This article provides guidance to troubleshoot common scenarios for [virtual networks](/power-platform/admin/vnet-support-overview) in Microsoft Power Platform. This article focuses on using the [Microsoft.PowerPlatform.EnterprisePolicies](https://www.powershellgallery.com/packages/Microsoft.PowerPlatform.EnterprisePolicies) PowerShell module to help you identify and resolve issues that are related to virtual network configurations.

## Use the diagnostics PowerShell module

The `Microsoft.PowerPlatform.EnterprisePolicies` PowerShell module is designed to help you diagnose and troubleshoot issues that are related to virtual network configurations in Power Platform. You can use the tool to check the connectivity between your Power Platform environment and your virtual network. You can also use it to identify any misconfigurations that might be causing issues. This diagnostics PowerShell module is available from the PowerShell Gallery and its GitHub repository, [PowerPlatform-EnterprisePolicies](https://github.com/microsoft/PowerPlatform-EnterprisePolicies).

### Install the module

To install the diagnostics PowerShell module, run the following PowerShell command:

```powershell
Install-Module -Name Microsoft.PowerPlatform.EnterprisePolicies
```

### Run the diagnostic functions

After the module is installed, import it into your PowerShell session by running the following command:

```powershell
Import-Module Microsoft.PowerPlatform.EnterprisePolicies
```

The module includes several functions to diagnose and troubleshoot issues that are related to virtual network configurations. Some of the key functions are:

- [Get-EnvironmentRegion](/powershell/module/microsoft.powerplatform.enterprisepolicies/Get-EnvironmentRegion): Retrieves the region of the specified Power Platform environment
- [Get-EnvironmentUsage](/powershell/module/microsoft.powerplatform.enterprisepolicies/Get-EnvironmentUsage): Provides information about the usage of the specified Power Platform environment
- [Test-DnsResolution](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-DnsResolution): Tests the DNS resolution for the specified domain name
- [Test-NetworkConnectivity](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-NetworkConnectivity): Tests the network connectivity between the Power Platform environment and the destination resource.
- [Test-TLSHandshake](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-TLSHandshake): Tests that a TLS handshake is able to be established between the Power Platform environment and the destination resource.

For a full list of available functions within the EnterprisePolicies module, see [Microsoft.PowerPlatform.EnterprisePolicies Module
](/powershell/module/microsoft.powerplatform.enterprisepolicies).

### Report issues in the diagnostics module

If you experience issues when you run the diagnostics module, report them through the GitHub repository where the module is hosted. The repository is available at: [PowerPlatform-EnterprisePolicies](https://github.com/microsoft/PowerPlatform-EnterprisePolicies).

To report an issue, go to the **Issues** section of the repository, and [open a new issue](https://github.com/microsoft/PowerPlatform-EnterprisePolicies/issues/new). Provide detailed information about the issue that you experience, including any error messages or log entries that might help when you investigate the issue. Don't include any sensitive information in your report.

## Troubleshoot common issues

### I have one policy where one environment is working, but another environment is not

If everything is correctly configured, but you still experience issues, use the [Get-EnvironmentRegion](/powershell/module/microsoft.powerplatform.enterprisepolicies/Get-EnvironmentRegion) function from the diagnostics PowerShell module to check whether the regions of your Power Platform environments are the same. Run the following command:

```powershell
Get-EnvironmentRegion -EnvironmentId "<EnvironmentId>"
```

If the regions of the two environments are different, then one of your virtual networks has not been correctly setup. When running the diagnostic commands it's highly encouraged to run the commands against both regions to ensure your full setup is configured correctly. You can invoke a test against a specific region (as long as it's a region supported by your enterprise policy) by specifying it when invoking the command, for example:

```powershell
Test-DnsResolution -EnvironmentId "<EnvironmentId>" -HostName "<HostName>" -Region "<AzureRegion>"
```

Your environment belongs to a specific Power Platform geography. However, a Power Platform region can span two Azure regions. Your environment can be located in either region, and it can also automatically fail over between them. Therefore, to ensure high availability and connectivity, configure your virtual networks in both Azure regions that're associated with your Power Platform region. To learn how Power Platform regions map to Azure regions that support the virtual network functionality, see [Power Platform regions](/power-platform/admin/vnet-support-overview#supported-regions).

### Hostname not found

If you experience issues that affect hostname resolution, use the [Test-DnsResolution](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-DnsResolution) function from the diagnostics PowerShell module to check whether the hostname is resolved correctly. Run the following command:

```powershell
Test-DnsResolution -EnvironmentId "<EnvironmentId>" -HostName "<HostName>"
```

This command tests the DNS resolution for the specified hostname in the context of your Power Platform environment. The request initiates from your delegated subnet and tries to resolve the hostname by using the DNS server that's configured for your virtual network. If the hostname isn't resolved correctly, you might have to check your DNS settings to make sure that the hostname is configured correctly.

> [!IMPORTANT]
> If you notice that your DNS setup is incorrect, and you have to update the DNS server settings for your virtual network, see [Can I update the DNS address of my virtual network after it's delegated to "Microsoft.PowerPlatform/enterprisePolicies"?](/power-platform/admin/vnet-support-overview#can-i-update-the-dns-address-of-my-virtual-network-after-its-delegated-to-microsoftpowerplatformenterprisepolicies)

### Request uses a public IP address instead of the private IP address

If you experience issues where requests to a resource use a public IP address instead of the private IP address, the DNS resolution for the resource's hostname might be returning a public IP address. This issue can occur with both Azure and non-Azure resources.

#### Non-Azure resource without a private endpoint

If a non-Azure resource doesn't have a private endpoint, but it's accessible from your virtual network, your DNS server should be configured to resolve the resource's hostname to its private IP address. Add a DNS *A* record to your DNS server that maps the resource's hostname to its private IP address:

- If you're using a custom DNS server, add the A record directly to your server.
- If you're using an Azure-provided DNS, create an [Azure Private DNS Zone](/azure/dns/private-dns-overview), and link it to your virtual network. Then, add the A record to the private DNS zone.

This mapping makes sure that the resource is accessed through its private IP address.

#### Azure resource with a private endpoint

If an Azure resource has a private endpoint, the DNS resolution for the resource's hostname should return the private IP address that's associated with the private endpoint. If the DNS resolution returns a public IP address instead, records might be missing from your DNS configuration. Follow these steps:

1. Verify that a private DNS zone exists for your resource type. For example, `privatelink.database.windows.net` for Azure SQL Database. If the private DNS zone doesn't exist, [create one](/azure/dns/private-dns-getstarted-portal#create-a-private-dns-zone).
1. Verify that the private DNS zone is linked to your virtual network. If the private DNS zone isn't linked to your virtual network, [link it](/azure/dns/private-dns-virtual-network-links).

After the private DNS zone is linked to your virtual network, the resource's hostname should resolve to the private IP address that's associated with the private endpoint.

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
> 
> Some firewalls might allow TCP connections to be established, but they then block actual traffic to the resource (for example, HTTPS). Therefore, even if the command indicates network connectivity, that status doesn't guarantee that the resource is fully accessible. See []


### Can't establish a TLS handshake

Some firewalls might allow TCP connections to be established, but they then block actual traffic to the resource (for example, HTTPS). Use the [Test-TLSHandshake](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-TLSHandshake) to diagnose why a handshake can't be established. Run the following command:

```powershell
Test-TLSHandshake -EnvironmentId "<EnvironmentId>" -Destination "<ResourceAddress>" -Port 1433
```

The command returns information that can help you debug why the handshake failed. The output contains information about the certificate that was presented by the server, as well as information regarding the cipher suite, protocol, and any SSL error, if any.

> [!IMPORTANT]
> Only publicly trusted certificates are supported. [My on-premises endpoint TLS certificates aren't signed by well-known root certification authorities (CA). Do you support unknown certificates?
](/power-platform/admin/vnet-support-overview#my-on-premises-endpoint-tls-certificates-arent-signed-by-well-known-root-certification-authorities-ca-do-you-support-unknown-certificates)

### Connectivity is successful, but the application is still not working

If the connectivity tests are successful, but you're still experiencing issues in your application, you might have to check the application-level settings and configurations, as follows:

1. Verify that your firewall allows access from the delegated subnet to the resource.
1. Verify that the certificate presented by the resource is publicly trusted.
1. Make sure that no authentication or authorization issues exist that prevent access to the resource.

You might not be able to diagnose or resolve the issue by using the diagnostics PowerShell module. In that case, create a subnet without delegation in your virtual network, and deploy a virtual machine (VM) in that subnet. You can then use the VM to perform further diagnostics and troubleshooting steps, such as checking network traffic, analyzing logs, and testing application-level connectivity.
