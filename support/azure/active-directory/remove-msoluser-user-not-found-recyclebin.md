---
title: Error (Remove-MsolUser User Not Found) when you try to remove a user from the recycle bin
description: Describes an issue that occurs when you try to remove a user from the recycle bin. Provides a resolution.
ms.date: 06/08/2020
ms.reviewer: willfid
ms.service: entra-id
ms.subservice: domain-services
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---
# Error when you try to remove a user from the recycle bin: Remove-MsolUser User Not Found

_Original product version:_ &nbsp; Office 365 Identity Management, Microsoft Entra ID, Cloud Services (Web roles/Worker roles), Microsoft Intune, Azure Backup  
_Original KB number:_ &nbsp; 3019157

## Symptoms

When you try to remove a user from the recycle bin (also sometimes known as the Deleted Users container) in a Microsoft cloud service such as Microsoft Office 365, Microsoft Intune, or Microsoft Azure, you receive the following error message:

> Remove-MsolUser: User Not Found

For example, you experience these symptoms when you run the following cmdlet:

```powershell
Remove-MsolUser -RemoveFromRecyleBin
```

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

## Cause

This problem occurs if the user who is performing the action is not a global admin.

## Resolution

Take one of the following actions:

- Have someone assign the global admin role to you, and then remove the user from the recycle bin.
- Have a global admin remove the user from the recycle bin.
- Wait 30 days. Deleted users will remain in the recycle bin for 30 days. After 30 days, they are automatically removed from the recycle bin.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
