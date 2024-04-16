---
title: Can't sign up for a Microsoft Azure subscription
description: Discusses that you receive an error message when signing up for a Microsoft Azure subscription.
ms.date: 08/14/2020
ms.service: azure-common-issues-support
ms.author: genli
author: genlin
ms.reviewer: 
---
# Can't sign up for a Microsoft Azure subscription

This article provides a resolution to an issue in which you are not able to sign up for a Microsoft Azure subscription with error: Account belongs to a directory that cannot be associated with an Azure subscription. Please sign in with a different account.

_Original product version:_ &nbsp; Subscription management  
_Original KB number:_ &nbsp; 4052156

## Symptoms

When you try to sign up for a Microsoft Azure subscription, you receive the following error message:

> Account belongs to a directory that cannot be associated with an Azure subscription. Please sign in with a different account.

## Cause

The email address that is used to sign up for the Azure subscription already exists in an unmanaged Microsoft Entra directory. Unmanaged Microsoft Entra directories cannot be associated with an Azure subscription.

## Resolution

To fix this problem, perform an "IT Admin Takeover" process for Power BI and Office 365 on the unmanaged directory.

This process transforms the unmanaged directory into a managed directory by assigning the Global Administrator role to your account. After this is done, you will be able to sign up for an Azure subscription by using your email address.

## References

- [How to perform an IT Admin Takeover with O365](https://powerbi.microsoft.com/blog/how-to-perform-an-it-admin-takeover-with-o365/)
- [Take over an unmanaged directory in Microsoft Entra ID](/azure/active-directory/domains-admin-takeover)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
