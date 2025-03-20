---
title: Can't modify user mail or phone number attributes
description: Provides a solution to an issue where you can't modify certain personal information for another user.
ms.date: 03/20/2025
ms.reviewer: bhvootla, adoyle, nualex, v-weizhu
ms.service: entra-id
ms.custom: sap:Getting access denied errors (Authorization)
---
# Can't modify user mail or phone number information

This article provides a solution to an issue where you can't modify certain personal information for another user, such as mail and phone number.

## Symptoms

You can't modify the following user attributes for another user:

- mobilePhone
- businessPhones/telephoneNumber
- otherMails

Most users experiencing this issue are Microsoft Graph service principals or Microsoft Entra users that use the client credentials grant type. Additionally, they get a 403 error.

## Cause

This issue occurs due to insufficient permissions. For Microsoft Entra users, the `User.ReadWrite.All` permission can change a user profile except the three user attributes. For Microsoft Graph service principals, having the `Directory.ReadWrite.All` permission isn't sufficient to modify the three user attributes.

## Solution

To resolve this issue, assign a Helpdesk Administrator, User Administrator, or Global Administrator role to the service principal or user that changes the three attributes, depending on the user that tries to modify the role. Only the three admins can make changes to the three attributes.

> [!CAUTION]
> When you assign one of the three admin role to the service principal or user, you give them the ability to perform tasks at that level.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]