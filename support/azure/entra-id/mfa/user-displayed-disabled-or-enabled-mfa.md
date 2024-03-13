---
title: A user is displayed as disabled or enabled for Microsoft Azure Multi-Factor Authentication but behaves as the opposite
description: Describes an issue in which a user is displayed as disabled or enabled for Microsoft Azure Multi-Factor Authentication but behaves as the opposite. This is expected behavior.
ms.date: 10/10/2020
ms.service: active-directory
ms.author: genli
author: genlin
ms.reviewer: willfid
ms.subservice: authentication
---
# A user is displayed as disabled or enabled for Microsoft Azure Multi-Factor Authentication but behaves as the opposite

_Original product version:_ &nbsp; Active Directory  
_Original KB number:_ &nbsp; 2934588

This article provides a solution to an issue in which a user is displayed as disabled or enabled for Microsoft Azure Multi-Factor Authentication but behaves as the opposite. This is an expected behavior.

## Symptoms

### Issue 1

When Microsoft Azure Multi-Factor Authentication is enabled, a user may be displayed as disabled even though the user behaves as enabled.

### Issue 2

When Microsoft Azure Multi-Factor Authentication is disabled, a user may be displayed as enabled even though the user behaves as disabled

## Cause

This problem occurs if the user is added in another directory as a guest user. Consider the following example:

User John (`John@contoso.com`) is created in `contoso.onmicrosoft.com`. This is his home directory. John is then added to a guest directory at `fabrikam.onmicrosoft.com` as a guest user. When the administrator of `fabrikam.onmicrosoft.com` examines the guest user, the user is displayed as disabled for Multi-Factor Authentication.

## Resolution

This behavior is by design. Multi-Factor Authentication behavior is always based on the user's home directory status. If you want to change the desired Multi-Factor Authentication behavior, you or an administrator should make this change from the user's home directory.

## More information

Guest users are users from one directory who are added to another directory. For example, a user from `contoso.onmicrosoft.com` may be added to `fabrikam.onmicrosoft.com`. In this case, the user is still authenticated by using the settings that are defined in the user's home directory (`contoso.onmicrosoft.com`).

> [!NOTE]
> To quickly check whether a user is a guest user, notice whether the check box next to the user on the Manage Multi-Factor Auth screen is dimmed. A dimmed check box indicates that the user is a guest user.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
