---
title: Troubleshoot delays after user is forced to change password
description: 'Troubleshoot delays after a user is forced to change their password, and then signs in and gets this message: "Our servers take a little time to catch up."'
ms.date: 02/18/2022
ms.reviewer: jarrettr, nualex, v-leedennis
ms.service: active-directory
ms.subservice: enterprise-users
keywords:
#Customer intent: As a global administrator on Microsoft 365, I want to make sure that when I force a password reset on a user, they can change their temporary password in on-premises Active Directory so that they don't get frustrated and give up on the process.
---
# Troubleshoot delays after the first sign-in following a forced password change

This article describes how to troubleshoot a password writeback issue when a user is forced to change their password on first sign-in.

## Symptoms

After a user makes a required password change on first sign-in, they receive this warning message:

> Your password was successfully updated, but our servers take a little time to catch up. Please try signing in again in a few minutes.

## Cause

When a user is forced to change their password on first sign-in in Microsoft Entra ID, the password writeback process accepts the temporary password for sign-in, and the user is prompted to provide a new password. Password writeback tries to change the password on-premises, and then waits. If the on-premises update succeeds, password writeback tries to change the password in Microsoft Entra ID. During a password change operation, password writeback verifies the current password, and then provides the new password to be updated in the respective directory.

However, a timing issue might cause this warning if an attempt to sign in occurs immediately after the on-premises Active Directory password was reset. This issue occurs if the user has the **User must change password at next logon** option selected, and the domain authentication is configured for **Pass-through Authentication** (PTA).

In this scenario, the user tries to sign in before password hash synchronization finishes syncing the temporary password to Microsoft Entra ID. But because PTA is configured, the authentication is redirected to on-premises Active Directory. The user can now sign in to Microsoft Entra ID successfully and is then forced to change the password on the first sign-in. If the password change is successful, password writeback updates the new password in on-premises Active Directory and in Microsoft Entra ID. However, the sign-in message says "our servers take a little time to catch up." This is because the temporary password didn't match the current password in Microsoft Entra ID.

## Solution

After an Active Directory administrator resets the password on-premises, Microsoft Entra Connect takes at least two minutes to sync that temporary password to Microsoft Entra ID. To avoid receiving this warning message, the user has to wait at least two minutes to sign in and update the password. This provides time for password hash synchronization to sync the temporary password.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
