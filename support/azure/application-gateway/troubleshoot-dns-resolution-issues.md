---
title: Troubleshoot DNS resolution issues for Azure Application Gateway
description: Troubleshooting guidance for DNS resolution issues that affect Azure Application Gateway functionality.
ms.date: 04/05/2026
ms.author: lalbadarneh
ms.editor: lalbadarneh
ms.reviewer: lalbadarneh
ms.service: azure-application-gateway
ms.custom: sap:Issues with Create, Update and Delete (CRUD)

#customer intent: As an Azure administrator, I want to troubleshoot DNS resolution issues in Azure Application Gateway so that I can restore certificate, backend, and provisioning functionality.

---

# Troubleshoot DNS resolution scenarios for Azure Application Gateway

Azure Application Gateway depends on DNS resolution for several FQDNs such as backend pool members, Key Vault endpoints for listener certificates, custom error page URLs and Azure infrastructure endpoints. Incorrect DNS design (especially with Private Endpoints and custom DNS) can cause certificate retrieval failures, backend health showing **Unknown** or intermittent data plane and control plane issues.

## Prerequisites

- An existing Azure Application Gateway deployment
- Access to the Application Gateway virtual network configuration
- Access to DNS configuration (Azure-provided DNS or custom DNS servers)
- Required permissions to stop and start Application Gateway (if needed)

## Troubleshooting checklist

### Scenario 1: Application Gateway (Public Frontend) with Key Vault Private Endpoint and Custom DNS

**Applies to**

- Application Gateway deployments with a public IP address  
- Listener certificate stored in **Azure Key Vault** and referenced by the gateway  

**Symptoms**

- Certificate operations failure  
- Listener certificate synchronization fails after enabling a Key Vault Private Endpoint  

**Cause**

Application Gateway performs DNS resolution for the **Key Vault endpoint used for the listener certificate**.

For **public IP** Application Gateway deployments, DNS resolution and Azure infrastructure communication behavior differs from private Application Gateway deployments. Name resolution issues for Azure domains can cause partial or complete loss of functionality.

In Application Gateway deployments with a public frontend IP, the gateway uses Azure-provided DNS (`168.63.129.16`) for control-plane Azure domains (including the Key Vault endpoint used for listener certificates), even when custom DNS servers are configured on the VNet.

**Resolution**

1. Confirm that the Key Vault Private Endpoint DNS is configured using the correct Private DNS zone:  
   `privatelink.vaultcore.azure.net`
2. Ensure the **Private DNS zone is linked to the Application Gateway virtual network**

**Behavior change with network isolation enabled**

If the **EnableApplicationGatewayNetworkIsolation** feature is registered, the DNS resolution behavior changes.

Key Vault DNS queries are sent to the DNS servers defined on the Application Gateway VNet, instead of Azure-provided DNS.

This behavior applies to all Application Gateways deployed after the feature is registered.

---

### Scenario 2: Private DNS zone created for a top-level domain instead of the subdomain zone

**Symptoms**

- Application Gateway v2 provisioning state is **Failed** during create or update operations

**Cause**

Private Endpoint DNS guidance requires using the **suggested Private Link-specific DNS zone**.

Application Gateway performs DNS resolution not only for customer-provided FQDNs (such as backends), but also for **Key Vault endpoints used for listener certificates** and other **management/control-plane FQDNs** required for Azure infrastructure operations.

If a **Private DNS zone for the top-level Key Vault domain** (for example, `vaultcore.azure.net`) is linked to the Application Gateway VNet, it can override or interfere with the gateway’s internal control-plane name resolution. This breaks the gateway’s ability to resolve and reach the Key Vault endpoint required for certificate retrieval, resulting in provisioning failures.

**Resolution**

- Configure DNS for Key Vault Private Endpoint scenarios using the **Private Link-specific zone**, such as:  
  `privatelink.vaultcore.azure.net`

---
### Scenario 3: Custom DNS servers are in a different VNet (peering, NSG, or UDR issues)

**Symptoms**

- Backend health is **Unknown** for FQDN-based backends
- DNS resolution works from some subnets but not from the Application Gateway subnet

**Cause**

When using **custom DNS**, Application Gateway must be able to reach the DNS servers configured on the VNet.

Common causes include:
- Missing or incorrect VNet peering when DNS servers are in another VNet
- Network Security Groups blocking UDP/TCP port 53
- User Defined Routes forcing DNS traffic through a firewall or NVA that drops DNS traffic

**Resolution**

1. Ensure the VNet hosting the DNS servers is reachable from the Application Gateway VNet and subnet  
2. Confirm NSGs allow DNS traffic (UDP port 53)  
3. Validate DNS resolution from a VM in the **same VNet and subnet path**  
4. Restart Application Gateway if DNS was recently changed (Scenario 4)

---
### Scenario 4: Application Gateway continues to resolve DNS incorrectly after VNet DNS server changes

**Symptoms**

- DNS servers were updated on the VNet, but:
  - Backend FQDN resolution still fails
  - Backend health still shows **Unknown** due to DNS issues

**Cause**

For **Application Gateway v2 SKU**, updated VNet DNS server settings are not applied until the Application Gateway is restarted.

**Resolution**

Stop and start the Application Gateway to apply the updated DNS configuration:

```powershell
# Stop an existing Azure Application Gateway instance
$appGateway = Get-AzApplicationGateway -Name $appGatewayName -ResourceGroupName $resourceGroupName
Stop-AzApplicationGateway -ApplicationGateway $appGateway

# Start an existing Azure Application Gateway instance
$appGateway = Get-AzApplicationGateway -Name $appGatewayName -ResourceGroupName $resourceGroupName
Start-AzApplicationGateway -ApplicationGateway $appGateway

```
----
## Related content

- [Private endpoint DNS](/azure/private-link/private-endpoint-dns)
- [Application Gateway DNS resolution](/azure/application-gateway/application-gateway-dns-resolution)
