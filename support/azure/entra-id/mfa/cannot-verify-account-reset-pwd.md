---
title: Error (We could not verify your account) when a new user tries to reset password in Azure, Office 365, or Intune
description: Describes a scenario  in which a new user receives a (We could not verify your account) error when resetting password.
ms.date: 06/22/2020
ms.reviewer: willfid
ms.service: entra-id
ms.subservice: authentication
---
# Error when trying to reset password in Azure, Office 365, or Intune: We could not verify your account

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2951274

## Symptoms

When a new user tries to reset password in Microsoft Azure, Microsoft Office 365, or Microsoft Intune, the user receives the following error message:

> Reset your password
>
> We could not verify your account
>
> If you'd like, we can contact an administrator in your organization to reset your password for you..

## Resolution

Assign a Microsoft Entra ID P1 or P2 license to the user. Users must have a Microsoft Entra ID P1 or P2 license to be able to reset their own password.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
