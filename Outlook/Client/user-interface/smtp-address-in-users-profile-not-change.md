---
title: SMTP address in user's profile doesn't change
description: Describes an Exchange Server 2013 and Exchange Server 2016 issue in which the SMTP address that's displayed in a user's profile fails to change when the user's primary email address is changed. Provides a workaround.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 3/31/2022
---
# SMTP address in user's profile doesn't change when primary email address is changed in Exchange Server

_Original KB number:_ &nbsp; 3040795

## Symptoms

When a user's primary SMTP email address is changed in Microsoft Exchange Server 2013 or Exchange Server 2016, the address that's displayed in the user's profile in Microsoft Outlook does not change.

For example, assume that a user's primary SMTP email address is `alias@domain.com`, as shown in Figure 1:

|Figure 1|Figure 2|
|---|---|
|:::image type="content" source="media/smtp-address-in-users-profile-not-change/figure-1.png" alt-text="Screenshot of Figure 1 showing the primary SMTP email address displayed in Outlook is alias@domain.com.":::<br/>|:::image type="content" source="media/smtp-address-in-users-profile-not-change/figure-2.png" alt-text="Screenshot of Figure 2 showing the primary SMTP email address displayed in Outlook is expected to be changed to alias@subdomain.domain.com if the user's primary SMTP email address is changed.":::<br/>|

However, if the user's primary SMTP email address is changed to `alias@subdomain.domain.com`, the primary SMTP email address that's displayed in Outlook does not change as expected. You expect the primary SMTP email address in Outlook to reflect the change, as shown in Figure 2.

## Cause

This issue is by design. The email address that's stamped in the root folder is determined at the time of profile creation and should reflect the primary SMTP address that's stamped on the user. The email address is strictly cosmetic and cannot be changed when the user's primary SMTP email address changes.

## Workaround

To work around this issue, delete and then re-create the profile for the user.

Learn how to [Create an Outlook profile](https://support.microsoft.com/office/create-an-outlook-profile-f544c1ba-3352-4b3b-be0b-8d42a540459d) and set up an email account in Outlook.
