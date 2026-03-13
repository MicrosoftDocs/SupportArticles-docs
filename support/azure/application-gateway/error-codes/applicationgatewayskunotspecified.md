---
title: Troubleshoot ApplicationGatewaySkuNotSpecified error 
description: This article discusses how to resolve the ApplicationGatewaySkuNotSpecified error when you try to create or modify an application gateway.
ms.date: 01/22/2026
ms.editor: v-gsitser
ms.reviewer: rimayber, giverm, v-ryanberg
ms.service: azure-application-gateway
ms.custom: sap:Issues with Create, Update and Delete (CRUD)
#Customer intent: As an Azure Application Gateway user, I want to troubleshoot an Application Gateway create or modify operation that failed because of ApplicationGatewaySkuNotSpecified error so that I can perform the operation successfully.
---

# Troubleshoot the ApplicationGatewaySkuNotSpecified error

## Summary

This article discusses how to resolve the `ApplicationGatewaySkuNotSpecified` error that occurs when you try to create or modify an application gateway in Microsoft Azure Application Gateway. An application gateway can't be created or updated because the SKU size isn't specified.

## Symptoms

When you try to create or modify an application gateway, you encounter an `ApplicationGatewaySkuNotSpecified` error that prevents you from proceeding.

## Cause

This error occurs if the SKU (Standard or Web Application Firewall (WAF)) for the application gateway isn't specified during the creation or configuration process.

## Resolution

To resolve this problem, follow these steps:

1. **Verify the SKU settings**

Make sure that the correct SKU is specified when you create or configure the application gateway. For example, use `Standard_v2` or `WAF_v2` for newer SKU types. The following code shows an example configuration:
       
```json

"sku": {
"name": "Standard_v2",
"tier": "Standard"
}

```

2. **Update the application gateway configuration**

If you're modifying an existing application gateway, update the SKU settings by using [the Azure portal](https://portal.azure.com), Azure CLI, or an Azure Resource Manager template (ARM template).

3. **Check ARM template or Azure CLI command**

If you're using an ARM template or Azure CLI, make sure that the `sku` segment is included correctly. For Azure CLI:
       
```azurecli

az network application-gateway create --name <gateway_name> --resource-group <resource_group> --sku Standard_v2 --public-ip-address <public_ip>

```

4. **Redeploy or re-create**

After you specify the SKU, try again to deploy or create the application gateway.

### Resources

[What is Azure Application Gateway v2?](/azure/application-gateway/overview-v2)
