---
title: User photos aren't synced to Exchange Online
description: Describes an issue in which a user continues to see the previous Exchange Online profile photo even though you updated the user's photo by using that user's on-premises information.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: minhng, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# User photos aren't synced from the on-premises environment to Exchange Online in a hybrid deployment

## Symptoms

You have a hybrid deployment of on-premises Microsoft Exchange Server and Exchange Online in Microsoft 365. When you change a Microsoft 365 user's photo by accessing that user's on-premises information, the change isn't synced to Exchange Online. For example, when the user views the photo in Outlook, Outlook on the web (formerly known as Outlook Web App), or Microsoft Teams, the user's previous Exchange Online profile photo is still displayed.

## Cause

Although the `thumbnailPhoto` attribute is synced from the on-premises environment to Microsoft Entra ID, the following behaviors could cause this problem:

- The `thumbnailPhoto` attribute can store a user photo as large as 100 kilobytes (KB).
- Exchange Online accepts only a photo that's no larger than 10 KB from Microsoft Entra ID.

## Resolution

Use the Microsoft 365 admin center or Microsoft Graph PowerShell to change the user's photo. These methods enable admins to upload a photo that's as large as 4 MB. For instructions, see [Change user profile photos](/microsoft-365/admin/add-users/change-user-profile-photos).

## References

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
