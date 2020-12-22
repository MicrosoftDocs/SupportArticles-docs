---
title: REST API is not yet supported error
description: REST API is not supported if you don't have a valid Office 365 mailbox, if an Outlook.com account isn't enabled, or if Flow isn't included in your plan.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: evsung, rachaudh
appliesto:
- Power Automate  
search.appverid: MET150
---
# REST API is not yet supported for this mailbox error for request to a mailbox

_Original KB number:_ &nbsp; 4462988

## Symptoms

When you use your account to issue any Outlook REST API request or when you use any Outlook functionality in Microsoft Flow, you may receive the following error message

> HTTP error: 404  
Error code: MailboxNotEnabledForRESTAPI or MailboxNotSupportedForRESTAPI  
Error message: "REST API is not yet supported for this mailbox."

## Cause

This error can for various reasons:

- The mailbox is on a dedicated Microsoft Exchange Server or is not a valid Office 365 mailbox.
- The mailbox is an Outlook.com account that hasn't been enabled yet.
- The mailbox is not part of an Office 365 plan that includes Flow.

## Resolution

To fix this issue, use one of the following options, as appropriate for your situation.

### Option 1: Migrate your mailbox account

If you don't have a valid Office 365 mailbox, you must submit a request to your Outlook administrator to migrate the mailbox account. Users who don't have administrator permissions can't migrate accounts. For  information about how to migrate the mailbox account, see [How to migrate mailbox data by using the Exchange Admin Center in Office 365](/exchange/troubleshoot/mailbox-migration/migrate-data-with-admin-center).

### Option 2: Wait for your mailbox to update, or request a developer preview account

Because enabling mailboxes on Outlook.com for the Outlook REST API happens over time, your existing Outlook.com account may still be in the queue. You can request a new, enabled Outlook.com developer preview account by sending an email message to [outlookdev@microsoft.com](mailto:outlookdev@microsoft.com).

### Option 3: Upgrade your Office 365 plan

The following Office 365 plans include the "Microsoft Flow for Office 365" plan:

- Office 365 Business Essentials
- Office 365 Business Premium
- Office 365 Education
- Office 365 Education Plus
- Office 365 Enterprise E1
- Office 365 Enterprise E3
- Office 365 Enterprise E5

> [!NOTE]
>
> - Office 365 Enterprise E2 includes the same capabilities as Office 365 Enterprise E1, and Office 365 Enterprise E4 includes the same capabilities as Office 365 Enterprise E3.
> - Office 365 Enterprise F1 includes the same capabilities as Flow Free. However, a service level agreement is provided, and the number of flow runs is aggregated across all users in an organization.

For more information, see [Flow Plan](https://preview.flow.microsoft.com/pricing/).

## More information

Outlook REST API includes the following subsets to enable access to your mailbox data in Office 365, Hotmail.com, Live.com, MSN.com, Outlook.com, and Passport.com.

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
