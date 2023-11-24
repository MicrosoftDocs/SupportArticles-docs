---
title: "Error message: "Data source credentials are missing or invalid. Please update the connection credentials in settings, and try again.""
description: Troubleshoot an issue with Power Query connectors for missing or invalid credentials.
ms.date: 11/22/2023
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
---

# Error message: "Data source credentials are missing or invalid. Please update the connection credentials in settings, and try again."

## Symptoms

Power Query returns error "Data source credentials are missing or invalid. Please update the connection credentials in settings, and try again."

## Resolution

The connection owner needs to authenticate the connection through a multi-factor authentication challenge, depending on your system settings. For example, a phone authenticator or a token like the RSA token.

- If the user has access to a user profile management self service portal, verify if the MFA/2FA requirements can be added to the user account.
- If an admin manages user accounts, ask the admin to update the account settings and the credential requirements to include MFA/2FA.
