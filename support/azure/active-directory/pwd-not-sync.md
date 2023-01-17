---
title: Password isn't synced from Azure AD to the local on-premises directory after the password is changed or reset
description: This article describes an issue in which password isn't synced from Azure AD to the local on-premises directory after the password is changed or reset. It provides a resolution.
ms.date: 05/22/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: enterprise-users
---
# Password isn't synced from Azure AD to on-premises after the password is changed or reset

This article describes an issue in which password isn't synced from Azure AD to on-premises directory after the password is changed or reset.

_Original product version:_ &nbsp; Azure Active Directory  
_Original KB number:_ &nbsp; 3187256

## Symptoms

When a password reset or a password change action is performed, the password isn't synchronized from Azure Active Directory (Azure AD) to the on-premises directory using Azure AD Connect.

Additionally, you may see the following message, or the password will not write back to your on-premises directory:

> Your request could not be processed  
 We're sorry but we cannot reset your password at this time. This is due to a temporary connectivity issue, so if you try again later, resetting your password may succeed. If the issue persists, please contact your admin to reset your password for you.

## Cause

This issue can occur for many reasons. The following is a list of known causes:

- Prerequisites are not met for password writeback.
- Permissions are not set up correctly for password writeback.
- The password reset agent in Azure AD Connect isn't running.
- There's a network connectivity issue between the password reset service in Azure AD and your local environment where Azure AD Connect is running.

## Resolution

Before troubleshooting this issue, it's important to know which scenarios allow password writeback. The following table lists scenarios in which password writeback occurs and doesn't occur.

|Scenario  |Password writeback  |
|---------|---------|
|Users who perform self-service password reset through `https://passwordreset.microsoftonline.com` | Yes |
|Admins who perform self-service password reset through `https://passwordreset.microsoftonline.com`| Yes |
|Password change in My Apps or in Office 365 portal|Yes|
|Admins who perform password resets by using the Azure Management Portal | Yes |
|Admins who perform password resets by using the Microsoft 365 admin center| No  |
|Passwords at new user creation through Azure Management Portal, Microsoft 365 admin center, or Azure AD PowerShell Module| No |
|Admins who perform password resets by using PowerShell Modules V1 (MSOnline) or V2 (AzureAD)|No|

To resolve this issue, see the **Troubleshoot Password Writeback** section of [How to troubleshoot Password Management](/azure/active-directory/authentication/active-directory-passwords-troubleshoot#troubleshoot-password-writeback).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
