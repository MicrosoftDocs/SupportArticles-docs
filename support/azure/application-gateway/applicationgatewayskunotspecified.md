---
title: Troubleshoot ApplicationGatewaySkuNotSpecified Error Code 
description: Learn how to resolve ApplicationGatewaySkuNotSpecified error when you try to create or modify Azure Application Gateway.
ms.date: 01/22/2026
editor: giverm
ms.reviewer: rimayber
ms.service: azure-application-gateway
ms.custom: sap:Failed operations
#Customer intent: As an Azure Application Gateway user, I want to troubleshoot an Application Gateway create or modify operation that failed because of ApplicationGatewaySkuNotSpecified error so that I can perform the operation successfully.
---

# Troubleshoot ApplicationGatewaySkuNotSpecified Error

## Symptom:
Application Gateway cannot be created or updated because the SKU (size) for the gateway has not been specified resulting in error `ApplicationGatewaySkuNotSpecified`

## Cause:
The **SKU** (Standard or WAF) for the Application Gateway was not provided during the creation or configuration process.

## Resolution:
1. **Verify SKU Settings:**
   - Ensure that the correct SKU is specified when creating or configuring the Application Gateway.
     - For example, use `Standard_v2` or `WAF_v2` for newer SKU types.
     - Example configuration:
       ```json
       "sku": {
         "name": "Standard_v2",
         "tier": "Standard"
       }
       ```

2. **Update Application Gateway Configuration:**
   - If modifying an existing Application Gateway, update the SKU settings using the Azure Portal, CLI, or ARM template.

3. **Check ARM Template/CLI Command:**
   - If using an ARM template or Azure CLI, ensure that the `sku` section is included correctly.
     - For CLI:
       ```bash
       az network application-gateway create --name <gateway_name> --resource-group <resource_group> --sku Standard_v2 --public-ip-address <public_ip>
       ```

4. **Re-deploy or Retry Creation:**
   - After specifying the SKU, retry creating or updating the Application Gateway.

---

### More Information:
[Application Gateway SKU Types](https://learn.microsoft.com/en-us/azure/application-gateway/overview-v2#sku-types)

