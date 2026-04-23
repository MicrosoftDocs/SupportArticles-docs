---
title: Troubleshoot virtual network issues
description: Learn how to troubleshoot common scenarios for virtual networks in Microsoft Power Platform.
ms.component: pa-admin
ms.date: 02/26/2026
ms.reviewer: osfaixat, sericks, v-shaywood
search.audienceType: 
  - admin
ms.custom: sap:Environment - Administration

#customer intent: As a developer or IT administrator, I want to troubleshoot my virtual network configuration in Power Platform so that my applications work as intended.
---

# Troubleshoot virtual network issues

This article provides guidance to troubleshoot common scenarios for [virtual networks](/power-platform/admin/vnet-support-overview) in Microsoft Power Platform. The article focuses on how to use the [Microsoft.PowerPlatform.EnterprisePolicies](https://www.powershellgallery.com/packages/Microsoft.PowerPlatform.EnterprisePolicies) PowerShell module to help you identify and resolve issues that are related to virtual network configurations.

## Use the diagnostics PowerShell module

The `Microsoft.PowerPlatform.EnterprisePolicies` PowerShell module helps you diagnose and troubleshoot issues that are related to virtual network configurations in Power Platform. You can use the tool to check the connectivity between your Power Platform environment and your virtual network. You can also use it to identify any misconfigurations that might cause issues. The diagnostics PowerShell module is available from the PowerShell Gallery and its GitHub repository, [PowerPlatform-EnterprisePolicies](https://github.com/microsoft/PowerPlatform-EnterprisePolicies).

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

To report an issue, go to the **Issues** section of the repository, and [open a new issue](https://github.com/microsoft/PowerPlatform-EnterprisePolicies/issues/new). Provide detailed information about the issue that you encounter. Include any error messages or log entries that might help when you investigate the issue. Don't include any sensitive information in your report.

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

This command returns information that can help you debug why the handshake failed. The output includes the certificate that the server presented, the cipher suite, the protocol, and any SSL error descriptions.

> [!IMPORTANT]
> Only publicly trusted certificates are supported. For more information, see [Do you support unknown certificates?](/power-platform/admin/vnet-support-overview#my-on-premises-endpoint-tls-certificates-arent-signed-by-well-known-root-certification-authorities-ca-do-you-support-unknown-certificates)

### Connectivity is successful, but the application still isn't working

If the connectivity tests are successful, but you're still experiencing issues in your application, check the application-level settings and configurations:

1. Verify that your firewall allows access from the delegated subnet to the resource.
1. Verify that the certificate that the resource presents is publicly trusted.
1. Make sure that no authentication or authorization issues prevent access to the resource.

You might not be able to diagnose or resolve the issue by using the diagnostics PowerShell module. In this case, create a subnet without delegation in your virtual network, and deploy a virtual machine (VM) in that subnet. Then, you could use the VM to perform further diagnostics and troubleshooting steps, such as checking network traffic, analyzing logs, and testing application-level connectivity.

## Example troubleshooting scenarios

Meet Contoso LLC, a multi-national company that has multiple Power Platform environments throughout Europe, and virtual networks in West Europe and North Europe. Each virtual network has a subnet that's delegated to Power Platform. Each subnet is associated with an enterprise policy that's then linked to the Power Platform environment.

The following scenarios show how Contoso uses the diagnostic cmdlets that are provided in the previous sections to troubleshoot connectivity issues that affect this setup.

### Connect to an Azure Key Vault through a private endpoint

Contoso wants its Power Platform environments to connect to its key vault through the virtual network, and configures the key vault to reject requests from the public internet. When Contoso tries to connect to the key vault from its environment, the connection is rejected because requests aren't routed correctly. To diagnose the issue, Contoso uses the following troubleshooting steps.

First, it runs [Get-EnvironmentRegion](/powershell/module/microsoft.powerplatform.enterprisepolicies/Get-EnvironmentRegion) to check which subnet requests are sent to:

```powershell
Get-EnvironmentRegion -EnvironmentId "00000000-0000-0000-0000-000000000001"
Get-EnvironmentRegion -EnvironmentId "00000000-0000-0000-0000-000000000002"
```

The returned region identifies which virtual network to investigate. For example, if the command returns West Europe, Contoso has to focus troubleshooting on the West Europe virtual network.

Next, Contoso verifies that the IP address that's returned from DNS resolution of the key vault fully qualified domain name (FQDN) is a private IP address. Because the company has environments in both regions, it has to test DNS resolution for each region by using [Test-DnsResolution](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-DnsResolution):

```powershell
Test-DnsResolution -EnvironmentId "00000000-0000-0000-0000-000000000001" -HostName "contoso-keyvault.vault.azure.net" -Region "westeurope"
Test-DnsResolution -EnvironmentId "00000000-0000-0000-0000-000000000001" -HostName "contoso-keyvault.vault.azure.net" -Region "northeurope"
```

If the DNS resolution returns a public IP address instead of a private IP address, the [private endpoint](/azure/private-link/private-endpoint-overview) for the key vault might not be configured correctly. Contoso has to verify that:

1. A private endpoint exists for the key vault, and it's associated with the correct virtual network.
1. A [private DNS zone](/azure/dns/private-dns-overview) exists for the key vault (for example, `privatelink.vaultcore.azure.net`), and it's linked to the virtual network.
1. The private DNS zone contains an *A* record that maps the key vault hostname to the private IP address of the private endpoint.

When Contoso runs the DNS resolution test for West Europe, the company discovers that the command returns a public IP address. After investigating, it finds that the private DNS zone for the key vault wasn't linked to the West Europe virtual network. After Contoso links the private DNS zone to the virtual network, and reruns the test, the DNS resolution returns the correct private IP address.

After DNS resolution returns the correct private IP address in both regions, the next step is to test network connectivity to the key vault by using [Test-NetworkConnectivity](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-NetworkConnectivity):

```powershell
Test-NetworkConnectivity -EnvironmentId "00000000-0000-0000-0000-000000000001" -Destination "contoso-keyvault.vault.azure.net" -Port 443 -Region "westeurope"
Test-NetworkConnectivity -EnvironmentId "00000000-0000-0000-0000-000000000001" -Destination "contoso-keyvault.vault.azure.net" -Port 443 -Region "northeurope"
```

If the connection fails, the [network security group (NSG)](/azure/virtual-network/network-security-groups-overview) rules or firewall settings might be blocking traffic from the delegated subnet to the key vault. Contoso has to check whether:

1. The NSG rules that are associated with the delegated subnet allow outbound traffic on port 443.
1. The key vault firewall allows incoming connections from the delegated subnet's IP range.
1. Any [Azure Firewall](/azure/firewall/overview) or network virtual appliance in the traffic path allows the connection.

In this case, Contoso finds that the key vault firewall wasn't configured to allow incoming connections from any private source. After the firewall settings are updated to allow connections from the delegated subnet, the network connectivity test succeeds, and the Power Platform environment can successfully connect to the key vault through the virtual network.

### Connect to a web server hosted in an on-premises network

Contoso also wants its Power Platform environment to connect to a web server that's hosted in its on-premises network. The web server is accessible through the company's virtual network through an [ExpressRoute](/azure/expressroute/expressroute-introduction) connection. When Contoso tries to connect to the web server from its Power Platform environment, the connection fails.

Even though DNS resolution returns the correct IP address and the network connectivity test succeeds, Contoso still can't access the web server. To diagnose this issue, the company tests the TLS handshake by using [Test-TLSHandshake](/powershell/module/microsoft.powerplatform.enterprisepolicies/Test-TLSHandshake):

```powershell
Test-TLSHandshake -EnvironmentId "00000000-0000-0000-0000-000000000001" -Destination "webserver.contoso.local" -Port 443 -Region "westeurope"
```

If the TLS handshake fails, the output provides details about the certificate, cipher suite, and protocol that were used. Contoso can use this information to identify any certificate or TLS configuration issues. The command does an initial analysis of the returned output and alerts about some basic issues. However, Contoso can analyze the full output to investigate the issue in more detail.

In this case, Contoso discovers that the TLS handshake can't be established because the certificate isn't trusted. After investigating the certificate details in the command output, the company determines that the web server is using a self-signed certificate. Power Platform requires publicly trusted certificates for TLS connections. After Contoso updates the web server to use a certificate that's signed by a [publicly trusted certificate authority](/power-platform/admin/vnet-support-overview#my-on-premises-endpoint-tls-certificates-arent-signed-by-well-known-root-certification-authorities-ca-do-you-support-unknown-certificates), the TLS handshake succeeds and the Power Platform environment can connect to the web server.

For more information on certificate authorities trusted by Azure services, see [Azure Certificate Authority details](/azure/security/fundamentals/azure-certificate-authority-details).
