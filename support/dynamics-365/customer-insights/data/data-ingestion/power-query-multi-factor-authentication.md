---
title: Data source credentials are missing or invalid error
description: Resolves an issue with Power Query connectors for missing or invalid credentials in Dynamics 365 Customer Insights - Data.
ms.date: 12/25/2023
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
---
# "Data source credentials are missing or invalid" error

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article resolves the "Data source credentials are missing or invalid" error that occurs when you use a [Power Query connector](/power-query/connectors/) in Microsoft Dynamics 365 Customer Insights - Data.

## Symptoms

When you use a Power Query connector in Dynamics 365 Customer Insights - Data, you receive the following error message:

> Data source credentials are missing or invalid. Please update the connection credentials in settings, and try again.

## Resolution

The connection owner needs to authenticate the connection through a multi-factor authentication challenge, depending on your system settings. For example, a phone authenticator or a token like the RSA token.

- If the user has access to a user profile management self service portal, verify if the [MFA](https://www.microsoft.com/security/business/identity-access/microsoft-entra-mfa-multi-factor-authentication) or [2FA](https://www.microsoft.com/security/business/security-101/what-is-two-factor-authentication-2fa) requirements can be added to the user account.
- If an administrator manages user accounts, ask the administrator to update the account settings and the credential requirements to include MFA or 2FA.
