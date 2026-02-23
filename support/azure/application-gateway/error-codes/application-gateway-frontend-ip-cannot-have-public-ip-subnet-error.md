---
title: Troubleshoot ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet error 
description: This article discusses how to resolve the ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet error when you try to create or modify a private-only application gateway.
ms.date: 02/13/2026
ms.author: jarrettr
ms.editor: v-gsitser
ms.reviewer: giverm, v-ryanberg
ms.service: azure-application-gateway
ms.custom: sap:Issues with Create, Update and Delete (CRUD)
#Customer intent: As an Azure Application Gateway user, I want to troubleshoot an Application Gateway create operation that fails because of an ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet error so that I can perform the operation successfully.
---

# Troubleshoot ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet error

## Summary

Azure Application Gateway supports private-only front-end IP deployments (no public IP) for "v2" SKUs. 

If the required subscription feature isn't enabled, deployments fail and generate errors that suggest that unsupported SKUs or mandatory public IPs are present.

This article discusses how to resolve the `ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet` error that you encounter when you try to create or modify a private-only application gateway.

## Symptoms

When you try to create a private-only application gateway (by using the Azure portal, PowerShell, or Azure CLI), you receive error messages that resemble the following messages:

- `ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet`

- **Application Gateway without Public IP is not supported for the selected SKU tier Standard_v2**

- **Supported SKU tiers are Standard, WAF**

## Cause

Private-only application gateway deployments require an explicit subscription-level feature registration. For example, `EnableApplicationGatewayNetworkIsolation`.

If this feature isn't registered, Azure validation reports one of the following conditions:

- The SKU is unsupported.

- A public IP is mandatory.

Standard_v2 and WAF_v2 support private-only, front-end IPs after the feature is enabled.

## Resolution

### Step 1: Register the required feature

Before you deploy the application gateway, register the following feature for the target subscription:

- **Feature name:** `EnableApplicationGatewayNetworkIsolation`

This registration enables:

- Private-only front-end IP configuration

- No public IP requirement for management or data plane traffic

- Enhanced Azure network security group (NSG) and route table controls

Make sure that the feature registration reaches the **Registered** state before you proceed. For more information, see [Onboard to the feature](/azure/application-gateway/application-gateway-private-deployment#onboard-to-the-feature). 

### Step 2: Deploy the application gateway

After the feature is registered:

- Use **Standard_v2** or **WAF_v2** SKUs.

- Configure as **only a private frontend IP**.

- Don't attach a public IP resource.

If you follow these guidelines, deployment succeeds without a recurrence of the previously reported SKU or front-end IP errors.

## Notes 

- This feature is supported for production use.

- Feature registration becomes an opt-in process and applies to new deployments.

- Existing gateways aren't automatically converted.

For more information, see [Private Application Gateway deployment](/azure/application-gateway/application-gateway-private-deployment).

## Pre-deployment checklist

- ✅ The subscription feature, `EnableApplicationGatewayNetworkIsolation`, is registered.

- ✅ The SKU is set to **Standard_v2** or **WAF_v2**.

- ✅ No public IP is attached to front-end configurations.

- ✅ A dedicated subnet is available for Application Gate.
