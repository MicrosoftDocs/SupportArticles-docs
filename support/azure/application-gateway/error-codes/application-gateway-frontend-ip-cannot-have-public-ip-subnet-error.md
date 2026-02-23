---
title: Troubleshoot ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet error 
description: This article discusses how to resolve the ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet error when you try to create or modify a private-only application gateway.
ms.date: 02/13/2026
ms.author: jarrettr
ms.editor: v-gsitser
ms.reviewer: giverm, v-ryanberg
ms.service: azure-application-gateway
ms.custom: sap:Issues with Create, Update and Delete (CRUD)
#Customer intent: As an Azure Application Gateway user, I want to troubleshoot an Application Gateway create operation that failed because of ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet error so that I can perform the operation successfully.
---

# Troubleshoot ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet error

## Summary

Azure Application Gateway supports private-only frontend IP deployments (no public IP) for v2 SKUs. 

If the required subscription feature isn't enabled, deployments fail with errors that suggest unsupported SKUs or mandatory public IPs.

This article discusses how to resolve the `ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet` error you encounter when you try to create or modify a private-only application gateway.

## Symptoms

When creating a private-only Application Gateway (using Azure portal, PowerShell, or Azure CLI), you might see errors like the following:

- `ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet`

- **Application Gateway without Public IP is not supported for the selected SKU tier Standard_v2**

- **Supported SKU tiers are Standard, WAF**

## Cause

Private-only Application Gateway deployments require an explicit subscription-level feature registration. For example, `EnableApplicationGatewayNetworkIsolation`

If this feature isn't registered, Azure validation reports one of the following:

- The SKU is unsupported.

- A public IP is mandatory

Standard_v2 and WAF_v2 support private-only frontend IPs once the feature is enabled.

## Resolution

### Step 1: Register the required feature

Before deploying the Application Gateway, register the following feature for the target subscription:

- **Feature name:** `EnableApplicationGatewayNetworkIsolation`

This enables:

- Private-only frontend IP configuration.

- No public IP requirement for management or data plane traffic.

- Enhanced Azure network security group (NSG) and route table controls.

Ensure the feature registration reaches **Registered** state before proceeding.

For more information, see [Onboard to the feature](/azure/application-gateway/application-gateway-private-deployment#onboard-to-the-feature). 

### Step 2: Deploy the Application Gateway

After the feature is registered:

- Use **Standard_v2** or **WAF_v2** SKUs.

- Configure as **only a private frontend IP**.

- Don't attach a public IP resource.

Deployment then succeeds without the previously reported SKU or frontend IP errors.

## Notes 

- This feature is supported for production use.

- Feature registration is opt-in and applies to new deployments.

- Existing gateways aren't automatically converted.

For more information, see [Private Application Gateway deployment](/azure/application-gateway/application-gateway-private-deployment).

## Pre-deployment checklist

- ✅ Subscription feature `EnableApplicationGatewayNetworkIsolation` is registered.

- ✅ SKU is set to **Standard_v2** or **WAF_v2**.

- ✅ No public IP is attached to frontend configuration.

- ✅ There's a dedicated subnet for Application Gateway.
