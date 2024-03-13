---
title: How to use UPN matching for identity synchronization in Office 365, Azure, or Intune
description: Describes how to use UPN matching for identity synchronization in Office 365, Azure, or Intune.
ms.date: 05/11/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: enterprise-users
ms.custom: has-azure-ad-ps-ref
---
# How to use UPN matching for identity synchronization in Office 365, Azure, or Intune

_Original product version:_ &nbsp; Microsoft Entra ID, Cloud Services (Web roles/Worker roles), Microsoft Intune  
_Original KB number:_ &nbsp; 3164442

## Introduction

Sometimes you may have to transfer the source of authority for a user account if that account was originally authored by using Microsoft cloud services management tools. These tools include:

- The Office 365 portal
- Microsoft Azure Active Directory module for Windows PowerShell
- Azure Management Portal
- Intune portal

You can transfer the source of authority, so the account can be managed through your local directory service when using identity synchronization with Microsoft Entra ID.

This article discusses how to perform the transfer by using a process known as **UPN matching**. This process uses the user principal name (UPN) to match the on-premises user account to a work or school account in Microsoft Entra ID.

## UPN matching limitations

The UPN matching process has the following technical limitations:

- UPN matching can be run only when SMTP matching fails. For more information about SMTP matching, see [How to use SMTP matching to match on-premises user accounts to Office 365 user accounts for directory synchronization](https://support.microsoft.com/help/2641663). For UPN matching to work, make sure that there are no primary SMTP address matches between on-premises user accounts and user accounts in Microsoft Entra ID.
- UPN matching can be used only one time for user accounts that were originally authored by using Office 365 management tools. After that, the work or school account is bound to the on-premises user by an immutable identity value, not the UPN.
- The cloud user's UPN can't be updated during the UPN matching process. It's because the UPN is the value that's used to link the on-premises user to the cloud user.
- UPNs are considered unique values. Make sure that no two users have the same UPN. Otherwise, the sync process fails, and you may receive an error message that resembles the following example:

    > Unable to update this object in Microsoft Online Services because the user principal name that is associated with this object in the local Active Directory is already associated with another object. To resolve this error, remove the associated object in your local Active Directory.

## How to use UPN matching to match an on-premises user to a cloud identity

To start the UPN matching process, follow these steps:

1. If you started syncing to Microsoft Entra ID before March 30, 2016, run the following Azure AD PowerShell cmdlet to enable UPN soft match for your organization only:

    ```powershell
    Set-MsolDirSyncFeature -Feature EnableSoftMatchOnUpn -Enable $True
    ```

    > [!NOTE]
    > UPN soft match is automatically enabled for organizations that started syncing to Microsoft Entra ID on or after March 30, 2016.
2. Obtain the UPN from the user account in Microsoft Entra ID. To do so, use one of the following methods:

     - Method 1: Use the Office 365 portal.

        1. Sign in to the [Office 365 portal](https://portal.office.com) as a global admin.
        2. Go to the users management page.
        3. Find and then select the user.
        4. Note the user name, which is the UPN.

     - Method 2: Use the Azure portal.

        1. Sign in to the [Azure portal](https://ms.portal.azure.com) as a global admin.
        2. Select the Active Directory extension, and then select your directory.
        3. Go to the users management page.
        4. Find and then select the user.
        5. Note of the user name, which is the UPN.
3. On a domain controller or a computer that has the Remote Server Administration Tools installed (RSAT), open Active Directory Users and Computers. Create a user account, or update an existing user account, by using a user name/UPN that matches the target user account in Microsoft Entra ID. For more information, see [Create a User Account in Active Directory Users and Computers](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd894463(v=ws.10)).
4. Force directory synchronization. For more information, see [Force directory synchronization](https://techcommunity.microsoft.com/t5/itops-talk-blog/powershell-basics-how-to-force-azuread-connect-to-sync/ba-p/887043).

## More information

For more information about UPN soft match, see [Microsoft Entra Connect Sync service features](/azure/active-directory/hybrid/how-to-connect-syncservice-features#userprincipalname-soft-match).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
