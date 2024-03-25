---
title: Data source credentials are missing or invalid error
description: Resolves an issue with missing or invalid credentials for Power Query connectors in Dynamics 365 Customer Insights - Data.
ms.date: 01/03/2024
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.custom: sap:Data Ingestion\Connect to a Power Query data source
---
# "Data source credentials are missing or invalid" error

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article helps you resolve the "Data source credentials are missing or invalid" error that might occur when you use a [Power Query connector](/power-query/connectors/) in Microsoft Dynamics 365 Customer Insights - Data.

## Symptoms

When you use a Power Query connector in Dynamics 365 Customer Insights - Data, you receive the following error message:

> Data source credentials are missing or invalid. Please update the connection credentials in settings, and try again.

## Resolution

The connection owner needs to authenticate the connection through a multi-factor authentication prompt, depending on your system settings, for example, a phone authenticator or a token like the RSA token.

- If the user has access to the user profile management self-service portal, verify if the [multifactor authentication (MFA)](https://www.microsoft.com/security/business/identity-access/microsoft-entra-mfa-multi-factor-authentication) or [two-factor authentication (2FA)](https://www.microsoft.com/security/business/security-101/what-is-two-factor-authentication-2fa) requirements can be added to the user account.
- If an administrator manages user accounts, ask the administrator to update the account settings and the credential requirements to include MFA or 2FA.
