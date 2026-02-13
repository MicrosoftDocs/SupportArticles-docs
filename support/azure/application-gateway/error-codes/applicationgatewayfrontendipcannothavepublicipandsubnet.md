---
title: TroubleshootApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet error 
description: This article discusses how to resolve the ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet error when you try to create or modify a private only application gateway.
ms.date: 02/13/2026
ms.editor: aditsi, giverm
ms.reviewer: giverm
ms.service: azure-application-gateway
ms.custom: sap:Issues with Create, Update and Delete (CRUD)
#Customer intent: As an Azure Application Gateway user, I want to troubleshoot an Application Gateway create operation that failed because of ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet error so that I can perform the operation successfully.
---

# Troubleshoot Private Azure Application Gateway Frontend IP Creation Issues

## Overview

Azure Application Gateway supports **private-only frontend IP deployments** (no public IP) for **v2 SKUs**. 

If the required subscription feature is **not enabled**, deployments fail with errors that suggest unsupported SKUs or mandatory public IPs.

This document explains the **symptoms**, **root cause**, and **resolution** with links to Microsoft public documentation.

---

## Symptoms

When creating a private-only Application Gateway (via Azure Portal, PowerShell, or CLI), you may see errors such as:

- `ApplicationGatewayFrontendIpCannotHavePublicIpAndSubnet`

- *Application Gateway without Public IP is not supported for the selected SKU tier Standard_v2*

- *Supported SKU tiers are Standard, WAF*

---

## Root Cause

Private-only Application Gateway deployments require an explicit **subscription-level feature registration**:

**`EnableApplicationGatewayNetworkIsolation`**

If this feature is **not registered**, Azure validation reports:

- The SKU is unsupported, or

- A public IP is mandatory

**Standard_v2** and **WAF_v2** **do support** private-only frontend IPs **once the feature is enabled**.

---

## Resolution

### Step 1: Register the Required Feature

Before deploying the Application Gateway, register the following feature on the target subscription:

- **Feature name:** `EnableApplicationGatewayNetworkIsolation`

This enables:

- Private-only frontend IP configuration

- No public IP requirement for management or data plane traffic

- Enhanced NSG and route table controls

📘 Microsoft documentation: 

[How to onboard to the feature?](/azure/application-gateway/application-gateway-private-deployment#onboard-to-the-feature) 

> Ensure the feature registration reaches **Registered** state before proceeding.

---

### Step 2: Deploy the Application Gateway

After the feature is registered:

- Use **Standard_v2** or **WAF_v2**

- Configure **only a private frontend IP**

- Do **not** attach a public IP resource

Deployment will succeed without the previously reported SKU or frontend IP errors.

--- 

## Notes and Limitations

- Feature is supported for production use

- Feature registration is opt-in and applies to new deployments

- Existing gateways are not automatically converted

📘 Microsoft documentation: 

[What is Private Only Application Gateway?](/azure/application-gateway/application-gateway-private-deployment)

---

## Pre-Deployment Checklist

- ✅ Subscription feature `EnableApplicationGatewayNetworkIsolation` registered

- ✅ SKU set to **Standard_v2** or **WAF_v2**

- ✅ No public IP attached to frontend configuration

- ✅ Dedicated subnet for Application Gateway
