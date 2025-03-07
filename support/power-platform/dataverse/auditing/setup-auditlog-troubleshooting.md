---
title: Troubleshoot sync issues in audit logs
description: Learn about common causes for synchronization issues to help with troubleshooting.
author: pete-msft
ms.component: pa-admin
ms.date: 02/20/2025
ms.author: petrip
ms.reviewer: paulliew, sericks
ms.custom: sap:Microsoft Dataverse\Auditing
search.audienceType: 
  - admin
contributors:
- Grant-Archibald-MS
---
# Troubleshoot sync issues in audit logs

## API permissions

Go to your app registration, and validate that you have the correct API permissions. Your app registration requires application permissions, not delegated permissions. Validate that the status is _Granted_.

:::image type="content" source="media/auditlog-troubleshoot-1.png" alt-text="Screenshot that highlights the Application type and Granted status of a configured permission." lightbox="media/auditlog-troubleshoot-1.png":::

## Secret environment variable - Azure secret

If you're using Azure Key Vault to store the app registration secret, validate that the Azure Key Vault permissions are correct.

A user must be in the _Key Vault Secrets User_ role to read and the _Key Vault Contributor_ role to update.

:::image type="content" source="media/auditlog-troubleshoot-2.png" alt-text="Screenshot that shows the Key Vault Contributor and Key Vault Secrets User roles." lightbox="media/auditlog-troubleshoot-2.png":::

If you experience other issues with Azure Key Vault that are related to a firewall, static IP addresses for the Dataverse environment, or other such feature issues, contact product support to fix them.

## Secret environment variable - plain text

If you're using plain text to store the app registration secret, validate that you entered the secret value itself, not the secret ID. The secret value is a longer string that has a larger character set than a globally unique identifier (GUID). For example, the string for the secret value might include tilde (~) characters.
