---
title: Troubleshoot DNS resolution issues for Azure Application Gateway
description: Use this guide to troubleshoot DNS resolution issues for Azure Application Gateway, restore back-end and certificate functionality, and resolve failures fast.
ms.date: 04/05/2026
ms.author: lalbadarneh
ms.editor: v-jsitser
ms.reviewer: giverm
ms.service: azure-application-gateway
ms.custom: sap:Issues with Create, Update and Delete (CRUD)

#customer intent: As an Azure administrator, I want to troubleshoot DNS resolution issues in Azure Application Gateway so that I can restore certificate, back-end, and provisioning functionality.

---

# Troubleshoot DNS resolution scenarios for Azure Application Gateway

## Summary

This article provides guidance for troubleshooting DNS resolution issues that can affect Microsoft Azure Application Gateway functionality. It explains common scenarios in which DNS misconfiguration can cause failures in certificate retrieval, back-end health checks, or other gateway operations. This article also provides steps to identify and resolve these issues.

Azure Application Gateway depends on DNS resolution for several fully qualified domain names (FQDNs) such as back-end pool members, Microsoft Azure Key Vault endpoints for listener certificates, custom error page URLs, and Azure infrastructure endpoints. Incorrect DNS design (especially if it involves private endpoints and custom DNS) can cause certificate retrieval failures, back-end health showing an **Unknown** status, or intermittent data plane and control plane issues.

## Prerequisites

- An existing Application Gateway deployment
- Access to the Application Gateway virtual network configuration
- Access to DNS configuration (Azure-provided DNS or custom DNS servers)
- Required permissions to stop and start Application Gateway (if it's necessary)

## Troubleshooting checklist

### Scenario 1: Application Gateway (public front-end) with Key Vault private endpoint and custom DNS

#### Overview

This article applies to the following deployment scenario:

- An Application Gateway deployment that has a public IP address
- A listener certificate that's stored in Azure Key Vault and is referenced by the gateway

#### Symptoms

- You experience certificate operations failure.
- Listener certificate synchronization fails after you enable a Key Vault private endpoint.  

#### Cause

Application Gateway performs DNS resolution when you try to determine the IP address of the Key Vault endpoint that's used for the listener certificate.

For public IP Application Gateway deployments, DNS resolution and Azure infrastructure communication behavior differs from private Application Gateway deployments. Name resolution issues for Azure domains can cause a partial or complete loss of functionality.

In Application Gateway deployments that use a public front-end IP, the gateway uses an Azure-provided DNS IP address (`168.63.129.16`) for control-plane Azure domains (including the Key Vault endpoint that's used for the listener certificates). This behavior occurs even if you configure custom DNS servers on the virtual network.

#### Solution

To verify and correct DNS resolution for the Key Vault private endpoint, follow these steps:

1. Verify that the Key Vault private endpoint DNS is configured using the correct private DNS zone (`privatelink.vaultcore.azure.net`).
1. Make sure that the private DNS zone is linked to the Application Gateway virtual network.

#### Behavior change with network isolation enabled**

If you register the **EnableApplicationGatewayNetworkIsolation** feature, the DNS resolution behavior changes. The gateway sends Key Vault DNS queries to the DNS servers that you define on the Application Gateway virtual network instead of the Azure-provided DNS.

This behavior applies to all application gateways that are deployed after the feature is registered.

### Scenario 2: Private DNS zone created for a top-level domain instead of the subdomain zone

#### Symptoms

- The Application Gateway v2 provisioning state shows as **Failed** during create or update operations.

#### Cause

Private Endpoint DNS guidance requires that you use the suggested private link-specific DNS zone.

Application Gateway performs DNS resolution not only for customer-provided FQDNs (such as back-ends), but also for Key Vault endpoints that are used for listener certificates and other management and control-plane FQDNs that are required for Azure infrastructure operations.

You might link a private DNS zone for the top-level Key Vault domain (for example, `vaultcore.azure.net`) to the Application Gateway virtual network. Be aware that this action can override or interfere with the gateway's internal control-plane name resolution. It also breaks the gateway's ability to resolve and reach the Key Vault endpoint that's required for certificate retrieval. These results cause provisioning failures.

#### Solution

To verify and correct DNS resolution for the Key Vault private endpoint, follow these steps:

- Configure DNS for Key Vault private endpoint scenarios by using a private link-specific zone, such as `privatelink.vaultcore.azure.net`.

### Scenario 3: Custom DNS servers are in a different virtual network (peering, network security group (NSG), or user defined route (UDR) issues)

#### Symptoms

- Back-end health appears as **Unknown** for FQDN-based back-ends.
- DNS resolution works from some subnets, but not from the Application Gateway subnet.

#### Cause

When you use a custom DNS, Application Gateway must be able to reach the DNS servers that you configured on the virtual network.

Common causes include:

- Missing or incorrect virtual network peering when DNS servers are in another virtual network
- NSGs that block User Datagram Protocol (UDP) or TCP port 53
- UDRs that force DNS traffic through a firewall or a Network Virtual Appliance (NVA) that drops DNS traffic

#### Solution

To verify and correct DNS resolution when you use custom DNS servers in a different virtual network, follow these steps:

1. Make sure that the virtual network that hosts the DNS servers is reachable from the Application Gateway virtual network and subnet.  
1. Verify that NSGs allow DNS traffic (UDP port 53).  
1. Verify the DNS resolution from a virtual machine (VM) that uses the same virtual network and subnet path. This step makes sure that the DNS servers are reachable and resolving names correctly from the same network path that the Application Gateway uses.  
1. If the DNS was recently changed ([Scenario 4: Application Gateway continues to resolve DNS incorrectly after virtual network DNS server changes](#scenario-4-application-gateway-continues-to-resolve-dns-incorrectly-after-virtual-network-dns-server-changes)), restart Application Gateway.

### Scenario 4: Application Gateway continues to resolve DNS incorrectly after virtual network DNS server changes

#### Symptoms

You updated DNS servers on the virtual network. However:

- Back-end FQDN resolution still fails.
- Back-end health still appears as **Unknown** because of DNS problems.

#### Cause

For the Application Gateway v2 SKU, the updated virtual network DNS server settings aren't applied until you restart the application gateway.

#### Solution

Stop and start the application gateway to apply the updated DNS configuration. Run the following PowerShell cmdlets:

```powershell
# Stop an existing Azure Application Gateway instance
$appGateway = Get-AzApplicationGateway -Name $appGatewayName -ResourceGroupName $resourceGroupName
Stop-AzApplicationGateway -ApplicationGateway $appGateway

# Start an existing Azure Application Gateway instance
$appGateway = Get-AzApplicationGateway -Name $appGatewayName -ResourceGroupName $resourceGroupName
Start-AzApplicationGateway -ApplicationGateway $appGateway
```

## References

[Private endpoint DNS](/azure/private-link/private-endpoint-dns)
[Application Gateway DNS resolution](/azure/application-gateway/application-gateway-dns-resolution)
