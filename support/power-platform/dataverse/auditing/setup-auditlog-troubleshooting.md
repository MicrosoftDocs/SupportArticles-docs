---
title: Troubleshoot synchronization issues in audit logs
description: Provides solutions for resolving synchronization issues in audit logs by validating API permissions and secret environment variables.
author: pete-msft
ms.component: pa-admin
ms.date: 03/17/2025
ms.author: petrip
ms.reviewer: paulliew, sericks, v-christread
ms.custom: sap:Microsoft Dataverse\Auditing
search.audienceType: 
  - admin
contributors:
- Grant-Archibald-MS
---
# Troubleshoot synchronization issues in audit logs

This article provides guidance for resolving synchronization issues in audit logs. It focuses on validating API permissions and secret environment variables to ensure proper configuration for your app registration.

## API permissions

To ensure that you have the correct API permissions, follow these steps:

1. Go to your [app registration](/entra/identity-platform/quickstart-configure-app-access-web-apis#application-permission-to-microsoft-graph).
1. Ensure that the API permissions are set to the **Application** type instead of the **Delegated** type.
1. Verify that the permission status is **Granted**.

:::image type="content" source="media/api-permissions-type-status.png" alt-text="Screenshot that highlights the Application type and Granted status of a configured permission." lightbox="media/api-permissions-type-status.png":::

## Secret environment variable - Azure secret

If you're using [Azure Key Vault](/azure/key-vault/general/basic-concepts) to store the app registration secret, validate that the Azure Key Vault permissions are correct.

A user must have the _Key Vault Secrets User_ role to read and the _Key Vault Contributor_ role to update. You can find detailed role definitions in [Azure built-in roles for Key Vault data plane operations](/azure/key-vault/general/rbac-guide?tabs=azure-cli#azure-built-in-roles-for-key-vault-data-plane-operations).

:::image type="content" source="media/azure-key-vault-roles.png" alt-text="Screenshot that shows the Key Vault Contributor and Key Vault Secrets User roles." lightbox="media/azure-key-vault-roles.png":::

If you have other issues with Azure Key Vault related to a firewall, static IP addresses for the Dataverse environment, or other feature issues, contact Microsoft Support through the **Help + Support** experience in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/support).

## Secret environment variable - plain text

If you're using plain text to store the app registration secret, validate that you entered the secret value itself, not the secret ID. The secret value is a longer string that has a larger character set compared to a globally unique identifier (GUID). For example, the string for the secret value might include tilde (~) characters.
