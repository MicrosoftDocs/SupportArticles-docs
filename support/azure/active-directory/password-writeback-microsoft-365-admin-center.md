---
title: Troubleshoot admin password reset on Microsoft 365 admin center
description: Troubleshoot failed sign-in attempts that occur after an administrator resets a user password in the Microsoft 365 admin center.
ms.date: 02/25/2022
ms.reviewer: jarrettr, nualex, v-leedennis
ms.service: entra-id
ms.subservice: users
keywords:
#Customer intent: As a global administrator in Microsoft 365, I want make sure that my password reset in the Microsoft 365 admin center is successful so that my users can sign in successfully.
---
# Troubleshoot admin password resets in Microsoft 365 admin center

This article describes a password writeback issue that occurs after an administrator resets a user password in the Microsoft 365 admin center.

## Symptoms

A user who recently had an administrator reset their password can't sign in to on-premises Active Directory by using the new password. Additionally, the previous password might still work.

## Cause

An administrator has reset the password of a user in the [Microsoft 365 admin center](https://admin.microsoft.com). Although the user can sign in online by using the new password, the new password isn't synchronized back to on-premises Active Directory.

Currently, the Microsoft 365 admin center doesn't use the self-service password reset (SSPR) and password writeback libraries. When an administrator resets a user password in the Microsoft 365 admin center, the password is reset in Microsoft Entra ID, but the new password isn't updated in on-premises Active Directory. Therefore, the user password is now out-of-sync between on-premises Active Directory and Microsoft Entra ID.

## Solution

To make sure that password writeback updates the new password in on-premises Active Directory, the administrator who changes or resets the password must use [the Azure portal](https://portal.azure.com) instead of [the Microsoft 365 admin center](https://admin.microsoft.com).

For more information, see [How does self-service password reset writeback work in Microsoft Entra ID?](/azure/active-directory/authentication/concept-sspr-writeback).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
