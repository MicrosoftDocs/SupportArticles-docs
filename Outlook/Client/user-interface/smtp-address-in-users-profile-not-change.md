---
title: SMTP address in user's profile doesn't change
description: Describes an Exchange Server 2013, Exchange Server 2016, or Exchange Online issue in which the SMTP address that's displayed in a user's profile fails to change when the user's primary email address is changed. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 10/30/2023
---

# SMTP address in user's profile doesn't change when primary email address is changed in Exchange Server

## Symptoms

When a user's primary SMTP email address is changed in Microsoft Exchange Server 2013, Exchange Server 2016, or Exchange Online, the address that's displayed in the user's profile in Microsoft Outlook doesn't change.

For example, assume that a user's primary SMTP email address is `alias@domain.com`, as shown in Figure 1:

|Figure 1|Figure 2|
|---|---|
|:::image type="content" source="media/smtp-address-in-users-profile-not-change/figure-1.png" alt-text="Screenshot of Figure 1 showing the primary SMTP email address displayed in Outlook is alias@domain.com.":::<br/>|:::image type="content" source="media/smtp-address-in-users-profile-not-change/figure-2.png" alt-text="Screenshot of Figure 2 showing the primary SMTP email address displayed in Outlook is expected to be changed to alias@subdomain.domain.com if the user's primary SMTP email address is changed.":::<br/>|

However, if the user's primary SMTP email address is changed to `alias@subdomain.domain.com`, the primary SMTP email address that's displayed in Outlook doesn't change as expected. You expect the primary SMTP email address in Outlook to reflect the change, as shown in Figure 2.

## Cause

This behavior is expected. The primary email address in Outlook will change in a few days. This delay is caused by the time it takes for the offline address book (OAB) to be updated in Exchange and the time it takes for Outlook to download the OAB. Only the primary email address will be updated. Without a new Outlook profile, the SMTP address of the shared mailbox won't change.   

## Workaround

To work around this behavior for shared mailboxes, re-create the Outlook profile for the user. 

**Note:** The time period for OAB update still applies.

Learn how to [Create an Outlook profile](https://support.microsoft.com/office/create-an-outlook-profile-f544c1ba-3352-4b3b-be0b-8d42a540459d) and set up an email account in Outlook.

