---
title: Object deletions aren't synchronized to Azure AD when using the Azure Active Directory Sync tool
description: Describes an issue in which a deleted on-premises Active Directory object isn't removed from Azure AD when directory synchronization is used in Office 365, Azure, or Microsoft Intune.
ms.date: 07/06/2020
ms.prod-support-area-path: 
ms.reviewer: 
---
# Object deletions aren't synchronized to Azure AD when using the Azure Active Directory Sync tool

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Azure Active Directory, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2709902

## Symptoms

Consider the following scenario:

- You have an on-premises Active Directory object.
- Directory synchronization is used to sync the Active Directory object to Microsoft Azure Active Directory (Azure AD). It creates a linked object.
- You delete the on-premises Active Directory object.

In this scenario, the linked object isn't removed from Azure AD.

## Cause

This issue may occur if one of the following conditions is true:

- Directory synchronization hasn't yet occurred.
- Directory synchronization unexpectedly failed to delete a specific cloud object and results in an orphaned Azure AD object.

## Resolution

To fix this issue, follow these steps:

1. [Force directory synchronization](https://technet.microsoft.com/library/jj151771.aspx#bkmk_synchronizedirectories).
2. Check that directory synchronization occurred correctly. For more information, see [Verify directory synchronization](https://technet.microsoft.com/library/jj151797.aspx).
3. If sync is working correctly but the Active Directory object deletion is still not propagated to Azure AD, manually remove the orphaned object. To do so, use one of the following cmdlets in Azure Active Directory Module for Windows PowerShell:

    ```powershell
    Remove-MsolContact
    ```

    ```powershell
    Remove-MsolGroup
    ```

    ```powershell
    Remove-MsolUser
    ```

    For example, to manually remove orphaned user ID `john.smith@contoso.com` that was originally created by using directory synchronization, you would run the following cmdlet:

     ```powershell
     Remove-MsolUser -UserPrincipalName John.Smith@Contoso.com
     ```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums/en-US/home?forum=windowsazuread) website.
