---
title: Private items in the shared mailbox aren't displayed in Outlook
description: Provides workarounds to an issue in which Private items in the shared mailbox aren't displayed in Outlook.
author: TobyTu
ms.author: Shannon.McDaniel
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 123194
ms.reviewer: Shannon.McDaniel
appliesto:
- Exchange Online
- Outlook for Microsoft 365
search.appverid: MET150
---

# Private items in the shared mailbox aren't displayed in Outlook

## Symptoms

Some Inbox items such as emails or meeting requests in a shared mailbox aren't displayed in Microsoft Outlook 2013, 2016 and 2019.  

## Cause

These items were [marked as **Private**](https://support.microsoft.com/office/mark-your-email-as-normal-personal-private-or-confidential-4a76d05b-6c29-4a0d-9096-71784a6b12c1), Outlook client can't display private items in a shared folder.

> [!NOTE]
> Only the sender can set the sensitivity level for the items and the option will be greyed out when the items arrive at the recipient's Inbox.

## Workaround

- Use Outlook on the Web (OWA).
- Add the user as a calendar delegate to the shared mailbox with access to private items. Here's how to proceed:

    In PowerShell:

    ```powershell
    Add-MailboxFolderPermission -Identity ayla@contoso.com:\Calendar -User laura@contoso.com -AccessRights Editor -SharingPermissionFlags Delegate,CanViewPrivateItems
    ```

    In Outlook:

    1. Select **File** > **Account Settings** > **Delegate Access**
    2. Double-click the username of the delegate or select **Add** to add a new delegate.
    3. In the **Delegate Permissions** dialog, check **Delegate can see my private items**.
    4. Select **OK**.
