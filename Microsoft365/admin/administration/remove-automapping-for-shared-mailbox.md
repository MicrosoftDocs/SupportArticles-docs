---
title: Remove automapping for a shared mailbox
description: Describes how to disable automapping for a shared mailbox in Outlook for Office 365.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
ms.reviewer: eileenor, jhayes
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Outlook for Office 365
---

# How to remove automapping for a shared mailbox in Office 365

## Introduction

This article discusses how to remove automapping for shared mailboxes in Microsoft Outlook for Microsoft Office 365.

In Microsoft Outlook 2010 and in Microsoft Office Outlook 2007, Autodiscover automatically maps to any mailbox for which a user has full access permissions. Autodiscover automatically loads all mailboxes for which the user has full access permissions in the following scenarios:

- An administrator grants full access permissions for a user to access another user's mailbox.    
- The user has full access permissions to a shared mailbox.   

If the user has many mailboxes to which he or she has full access, this behavior may cause performance issues when Outlook starts. For example, in some organizations, administrators have full access to all users' mailboxes in their organization. If this is the case, Outlook tries to open all mailboxes in the organization.

## Procedure

To disable automapping, use Windows PowerShell to remove full access permissions from the user for the mailbox, and then add back full access permissions to the user. When you add back full access permissions to the user, use the AutoMapping:$false parameter.

To do this, follow these steps: 
1. Connect to Exchange Online by using remote PowerShell. For more info about how to do this, see [Connect to Exchange Online Using Remote PowerShell](https://technet.microsoft.com/library/jj984289%28v=exchg.150%29.aspx)     
2. Remove full access permissions for the user from the mailbox. This removes automapping. To do this, at the command prompt, type the following command, and then press Enter:  

    ```powershell
    Remove-MailboxPermission -Identity <Mailbox ID1> -User <Mailbox ID2> -AccessRights FullAccess
    ```
   > [!NOTE]
   > In this command, \<Mailbox ID1> represents the mailbox to which the user is granted permissions, and \<Mailbox ID2> is the mailbox of the user from whom you want to remove full access permissions.

   For example, to remove full access permissions for an administrator from John Smith's mailbox, use the following command:  
   
   ```powershell
   Remove-MailboxPermission -Identity johnsmith@contoso.onmicrosoft.com -User admin@contoso.onmicrosoft.com -AccessRights FullAccess  
   ```
   
   After you run this command, you're prompted to confirm the action:  
    
   ```adoc
   Confirm
   Are you sure you want to perform this action?
   Removing mailbox permission "johnsmith@contoso.onmicrosoft.com" for user "admin@contoso.onmicrosoft.com" with access rights 'FullAccess'".
   [Y] Yes [A] Yes to All [N] No [L] No to All [?] Help (default is "Y"): y  
   ```     
3. Grant full access permissions back to the user for the mailbox, but don't enable automapping. To do this, at the command prompt, type the following command, and then press Enter:

    ```powershell
    Add-MailboxPermission -Identity <Mailbox ID1> -User <Mailbox ID2> -AccessRights FullAccess -AutoMapping:$false 
    ```
   > [!NOTE]
   > In this command, <Mailbox ID1> represents the mailbox to which the user is granted permission and <Mailbox ID2> is the mailbox of the user to whom you want to add full access permissions.

   For example, to add full access permissions for an administrator to John Smith's mailbox, type the following command, and then press Enter:

   ```powershell
   Add-MailboxPermission -Identity johnsmith@contoso.onmicrosoft.com -User admin@contoso.onmicrosoft.com -AccessRights FullAccess -AutoMapping:$false
   ```
    
   After you run this command, the following output is displayed.  

   |Identity| User| Access Rights |IsInherited |Deny |
   |---|---|---|--|--|
   |John Smith|\<Domain>\\\<UserName>|Full access|False|False |


## More Information

For more info, see [Disable Outlook Auto-Mapping with Full Access Mailboxes](https://technet.microsoft.com/library/hh529943.aspx).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
