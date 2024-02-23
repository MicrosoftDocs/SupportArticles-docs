---
title: Mailbox Audit Log searches fail with exception ErrorInvalidServerVersion
description: When you run Search-MailboxAuditLog or New-MailboxAuditLogSearch command to search Mailbox Audit Logs, it fails with exception ErrorInvalidServerVersion. This article provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 114938
  - CSSTroubleshoot
ms.reviewer: cmcgurk, v-six
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2013
  - Exchange Server 2010
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# Mailbox Audit Log searches fail with exception "ErrorInvalidServerVersion" in Exchange Server 2016, 2013, and 2010 coexistence environment

## Symptoms

Consider the following scenario:

- You have an Exchange coexistence environment that includes mailboxes that are hosted on Microsoft Exchange Server 2016, 2013, and 2010.
- You move your arbitration mailboxes to Exchange Server 2016.
- You enable Mailbox Auditing for mailboxes that are hosted on Exchange Server 2010.
- From the Exchange Management Shell on Exchange Server 2016, you run either the `Search-MailboxAuditLog` or `New-MailboxAuditLogSearch` command to search the Mailbox Audit Logs for the mailbox that is hosted on Exchange Server 2010.

In this scenario, the audit log search fails.

If you run the `Search-MailboxAuditLog` command, an error message is returned in the Exchange Management Shell that resembles the following:

```
The Exchange Web Services returned an error while trying to access the audit log.  Reason: '','ErrorInvalidServerVersion','The specified server version is invalid.'
     + CategoryInfo : NotSpecified: (:) [Search-MailboxAuditLog], AuditLogServiceException
     + FullyQualifiedErrorID : (Server=E2K16,RequestID=<GUID>,Timestamp=DateTime) [FailureCategory=Cmdlet-AuditLogServiceException] AF0D01B1,Microsoft.Exchange.Management.SystemConfigurationTasks.SearchMailboxAuditLog
     + PSComputerName : E2K16.contoso.com
```

If you run the `New-MailboxAuditLogSearch` command, no error is returned in the Exchange Management Shell. However, Event ID 4002 is logged in the Event Viewer when the server tries to run the search:

```
Log Name:      Application

Source:        MSExchange AuditLogSearch
Date:          <DateTime>
Event ID:      4002
Task Category: General
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      E2K16.contoso.com
Description:
A runtime exception occurred in AuditLogSearchServicelet's worker while processing a request. Exception: 
Microsoft.Exchange.Data.ApplicationLogic.AuditLogServiceException: The Exchange Web Service returned an error while trying to access the audit log. Reason: '','ErrorInvalidServerVersion','The specified server version is invalid.'.
...
```

## Cause

This behavior is by design. If the arbitration mailbox was moved to Exchange Server 2016, the Mailbox Audit Log searches are run through Exchange Web Services by having a **RequestVersion** value of "Exchange Server 2013." When this request is presented to Exchange Server 2010, the response is an "ErrorInvalidServerVersion" exception.  

## Resolution

To fix this issue, run the `Search-MailboxAuditLog` command on Exchange Server 2010 directly when you search mailboxes that are hosted on Exchange Server 2010.
