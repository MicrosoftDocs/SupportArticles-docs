---
title: Changes to your password are not saved in Azure, Office 365, or Intune
description: Describes a problem in which changes to your password are not saved in Microsoft Azure, Office 365, or Microsoft Intune. To resolve this problem, do not use special characters as part of your password.
ms.date: 05/22/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: domain-services
---
# Changes to your password are not saved in Azure, Office 365, or Intune

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Intune  
_Original KB number:_ &nbsp; 2951280

## Symptoms

When you change your password in Microsoft Azure, Microsoft Office 365, or Microsoft Intune and then select **Finish** to save your changes, the changed password is not saved.

## Cause

This problem occurs when you use special characters such as the less-than sign `<` or the greater-than sign `>` as part of your password.

## Resolution

To resolve this problem, do not use special characters as part of your password.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
