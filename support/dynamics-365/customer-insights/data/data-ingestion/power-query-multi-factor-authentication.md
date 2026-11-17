---
title: Data Source Credentials are Missing or Invalid Error
description: Resolves an issue with missing or invalid credentials for Power Query connectors in Dynamics 365 Customer Insights - Data.
ms.date: 11/16/2026
ms.reviewer: sstabbert, v-wendysmith
ms.custom: sap:Data Ingestion\Connect to a Power Query data source
---
# "Data source credentials are missing or invalid" error

## Summary

This article helps you resolve the "Data source credentials are missing or invalid" error that might occur when you use a [Power Query connector](/power-query/connectors/) in Microsoft Dynamics 365 Customer Insights - Data.

## Symptoms

When you use a Power Query connector in Dynamics 365 Customer Insights - Data, you receive the following error message:

> Data source credentials are missing or invalid. Please update the connection credentials in settings, and try again.

## Solution

The connection owner needs to authenticate the connection through a multifactor authentication prompt, depending on your system settings, such as a phone authenticator or a token like the RSA token.

- If the user has access to the user profile management self-service portal, verify if you can add the [multifactor authentication (MFA)](https://www.microsoft.com/security/business/identity-access/microsoft-entra-mfa-multi-factor-authentication) or [two-factor authentication (2FA)](https://www.microsoft.com/security/business/security-101/what-is-two-factor-authentication-2fa) requirements to the user account.
- If an administrator manages user accounts, ask the administrator to update the account settings and the credential requirements to include MFA or 2FA.
