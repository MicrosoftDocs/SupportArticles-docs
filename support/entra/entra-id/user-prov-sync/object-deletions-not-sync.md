---
title: Object deletions aren't synchronized to Microsoft Entra ID when using the Microsoft Entra ID Connect
description: Describes an issue in which a deleted on-premises Active Directory object isn't removed from Microsoft Entra ID when directory synchronization is used in Office 365, Azure, or Microsoft Intune.
ms.date: 10/19/2023
ms.reviewer: 
ms.service: entra-id
ms.custom: sap:Microsoft Entra Connect Sync, no-azure-ad-ps-ref
---
# Object deletions aren't synchronized to Microsoft Entra ID when using the Microsoft Entra ID Connect

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2709902

## Symptoms

Consider the following scenario:

- You have an on-premises Active Directory object.
- Directory synchronization is used to sync the Active Directory object to Microsoft Entra ID. It creates a linked object.
- You delete the on-premises Active Directory object.

In this scenario, the linked object isn't removed from Microsoft Entra ID.

## Cause

This issue may occur if one of the following conditions is true:

- Directory synchronization hasn't yet occurred.
- Directory synchronization unexpectedly failed to delete a specific cloud object and results in an orphaned Microsoft Entra object.

## Resolution

To fix this issue, follow these steps:

1. Make sure that the [Microsoft Graph PowerShell module](/powershell/microsoftgraph/installation) and [ADSyncTools PowerShell](/azure/active-directory/hybrid/connect/reference-connect-adsynctools ) are installed.
1. Run the following ADSync command to force directory synchronization:
    ```powershell
    Start-ADSyncSyncCycle -PolicyType Initial
    ```
1. If sync is working correctly but the Active Directory object deletion is still not propagated to Microsoft Entra ID, manually remove the orphaned object. To do so, use one of the following cmdlets in Microsoft Graph PowerShell:

    - [Remove-MgContact](/powershell/module/microsoft.graph.identity.directorymanagement/remove-mgcontact)
    - [Remove-MgGroup](/powershell/module/microsoft.graph.groups/remove-mggroup)
    - [Remove-MgUser](/powershell/module/microsoft.graph.users/remove-mguser)

    For example, to manually remove orphaned user ID `john.smith@contoso.com` that was originally created by using directory synchronization, you would run the following cmdlet:

     ```powershell
     $user = Get-MgUser -Filter "userPrincipalName eq 'john.smith@contoso.com'"
     Remove-MgUser -UserId $user.id
     ```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
