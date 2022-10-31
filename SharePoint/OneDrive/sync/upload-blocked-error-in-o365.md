---
title: Microsoft 365 (Upload blocked) error when syncing between different tenants in OneDrive
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 7/9/2020
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - OneDrive for Business
ms.custom: 
  - CI 120653
  - CSSTroubleshoot
ms.reviewer: dumitrim
description: How to resolve an Upload blocked error in Microsoft 365 when two different tenants sync files to OneDrive.
---

# (Upload blocked) error in Microsoft 365 when users sync files with OneDrive from different tenants

## Symptoms

When you open or edit files in Microsoft 365 Desktop applications, you receive the following error message: 

> UPLOAD BLOCKED: We couldn't verify you have the necessary permissions to upload the file. 

:::image type="content" source="media/upload-blocked-error-in-o365/upload-blocked-error-message.png" alt-text="Screenshot of the Upload blocked error message.":::

## Cause

This message appears if two different accounts (for example, username@contoso.onmicrosoft.com being the primary account and username@fabrikam.onmicrosoft.com is the second) are used to sync files on two different tenants (such as contoso.onmicrosoft.com and fabrikam.onmicrosoft.com). The Office application is trying to save the changes by using the primary account. However, the application does not have permissions on the second tenant.

## Resolution

To resolve this issue, follow these steps:

1.	Share the files with the primary account.
2.	Sign out of all accounts in Office, and sign back in by using only the account that has permissions to open and edit the document. 
3.	Pause file synchronization in OneDrive.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).