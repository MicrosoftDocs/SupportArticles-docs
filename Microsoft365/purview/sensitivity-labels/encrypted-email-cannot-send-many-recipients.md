---
title: Can't send an encrypted email to many recipients
description: Provides some options to avoid an issue in which you can't send an encrypted email message to many recipients.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sensitivity Labels
  - CI 166253
  - CSSTroubleshoot
ms.reviewer: esaggese, keschott, mvergara, cabailey, jricaurt, lindabr
appliesto: 
  - Microsoft Purview
  - Azure Information Protection 
search.appverid: MET150
ms.date: 05/07/2025
---
# "Too many users" error when adding many recipients to encrypted email

## Symptoms

You apply one of the following options to an email message by using a [sensitivity label](/microsoft-365/compliance/encryption-sensitivity-labels#outlook-restrictions) or email encryption in Outlook:

- **Do Not Forward**
- **Encrypt-Only**

When you try to send this encrypted email message to many recipients, you receive the following error message:

> Too many users have been granted access to this protected content. Reduce the number of users or replace users with user groups, and try again.

> [!NOTE]
>
> - The number of recipients that causes this error varies, depending on both the number of recipients and the length of each recipient's email address. For typical email addresses, this error usually occurs if hundreds of email addresses are added to the message.
> - Only the number of email addresses that are individually added to the recipient list causes this error. For example, this issue doesn't occur if you add a distribution list or group that contains hundreds of recipients if you don't expand the distribution list or group.

## Cause

This issue is caused by the size limit of the protection policy that’s applied to the email.  

In Microsoft Purview Information Protection, this fixed size limit is 4 megabytes (MB). The protection policy includes permissions that are granted to each recipient who is authorized to access the email message. If you add too many recipients, the size of the protection policy might exceed the 4 MB limit and cause the error.  

## Workaround

To work around this issue, try one of the following options:

- Reduce the number of recipients. For example, reduce the number to less than 200. Or, send the email message to each recipient individually.
- Send the email message to distribution lists or groups that contain the recipients.  

  > [!NOTE]
  >
  > - Don't expand the distribution lists or groups by selecting the plus sign.
  > - Don't use a [personal distribution list](https://support.microsoft.com/office/create-a-contact-group-or-distribution-list-in-outlook-for-pc-88ff6c60-0a1d-4b54-8c9d-9e1a71bc3023) in Outlook because doing this is treated the same as adding users individually.

- If the recipients are within your organization, use a sensitivity label that has a different policy that grants permissions to all the desired users. For example, a label that uses administrator-defined permissions (such as the **All Employees** label) doesn't cause this error.

  **Note** You must have the administrator permission to configure the sensitivity label.
