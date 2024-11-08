---
title: REST API is not yet supported error
description: REST API is not supported if you don't have a valid Microsoft 365 mailbox, if an Outlook.com account isn't enabled, or if Flow isn't included in your plan.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: evsung, rachaudh, brianja, jasonjoh, v-six
appliesto: 
  - Power Automate
search.appverid: MET150
ms.date: 08/13/2024
---
# REST API is not yet supported for this mailbox error for request to a mailbox

_Original KB number:_ &nbsp; 4462988

## Symptoms

When you use your account to issue an Outlook REST API request, you may receive the following error message:

> HTTP error: 404  
Error code: MailboxNotEnabledForRESTAPI or MailboxNotSupportedForRESTAPI  
Error message: "REST API is not yet supported for this mailbox."

## Cause

This error can occur if the mailbox is on a dedicated Microsoft Exchange Server and is not a valid Microsoft 365 mailbox.

## Resolution

To get a valid Microsoft 365 mailbox, submit a request to your Exchange administrator to migrate the mailbox account. Users who don't have administrator permissions can't migrate accounts. For information on how to migrate the mailbox account, see [How to migrate mailbox data by using the Exchange Admin Center in Microsoft 365](/exchange/troubleshoot/mailbox-migration/migrate-data-with-admin-center).

## More information

Outlook REST API includes the following subsets to enable access to your mailbox data in Microsoft 365, Hotmail.com, Live.com, MSN.com, Outlook.com, and Passport.com.

- [Batching multiple API calls](/previous-versions/office/office-365-api/api/version-2.0/batch-outlook-rest-requests)
- [Calendar API](/previous-versions/office/office-365-api/api/version-2.0/calendar-rest-operations)
- [Contacts API](/previous-versions/office/office-365-api/api/version-2.0/contacts-rest-operations)
- [Data Extensions API](/previous-versions/office/office-365-api/api/version-2.0/extensions-rest-operations)
- [Extended Properties API](/previous-versions/office/office-365-api/api/version-2.0/extended-properties-rest-operations)
- [Mail API](/previous-versions/office/office-365-api/api/version-2.0/mail-rest-operations)
- [Push Notifications API](/previous-versions/office/office-365-api/api/version-2.0/notify-rest-operations)
- [Streaming Notifications API (preview)](/previous-versions/office/office-365-api/api/beta/notify-streaming-rest-operations)
- [People API](/previous-versions/office/office-365-api/api/beta/people-rest-operations)
- [Task API](/previous-versions/office/office-365-api/api/version-2.0/task-rest-operations)
- [User Photo API](/previous-versions/office/office-365-api/api/version-2.0/photo-rest-operations)

For more information, see [Use the Outlook REST API (version 2.0)](/previous-versions/office/office-365-api/api/version-2.0/use-outlook-rest-api).
