---
title: Failed to process message due to a transient exception error in message tracking logs
description: Works around an issue in which Exchange Server logs an error message when you send an email message that has an attachment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 179711
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: nourdinb, arindamt, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 01/24/2024
---

# "Failed to process message due to a transient exception" error in message tracking logs

## Symptoms

You send an email message that has an attachment, but the recipient doesn't receive the email message.

When you search the Microsoft Exchange Server [message tracking logs](/exchange/mail-flow/transport-logs/search-message-tracking-logs), you find an event entry that displays the following information:

```Output
EventId: "SUBMITDEFER"
Source: "STOREDRIVER"
EventData: "{[ItemEntryId, <item entry ID>], [DiagnosticInfo, Error:RetryMailboxServerError,
Diagnostic Information: Stage:CreateMailItem, SmtpResponse:431-4.3.1 STOREDRV; disk is full 
431 4.3.1 STOREDRV.Submit.Exception:StorageTransientException.IOException;
Failed to process message due to a transient exception with message The message content has become corrupted.
IOException: There is not enough space on the disk.], [DeliveryPriority,Normal]}"
```

> [!NOTE]
> To search the message tracking logs on a specific server, run the following command:
>
> ```PowerShell
> Get-MessageTrackingLog -Server <server name> -Start <start of date range> -End <end of date range> -Sender <SMTP address> -EventId "SUBMITDEFER" -Source "STOREDRIVER" | Select -Property Timestamp,EventId,Source,EventData | FL
> ```

Similarly, if you search the Exchange Server [connectivity logs](/exchange/mail-flow/transport-logs/connectivity-logging), you find an entry that displays the following information:

```Output
Direction: ">"
Description: "Failed; HResult: 1140850693; DiagnosticInfo: Stage:CreateMailItem,
SmtpResponse:431-4.3.1 STOREDRV; disk is full
431 4.3.1 STOREDRV.Submit.Exception:StorageTransientException.IOException;
Failed to process message due to a transient exception with message The message content has become corrupted.
IOException: There is not enough space on the disk."
```

**Note**: This issue only occurs in Exchange Server 2016 and later versions.

## Cause

When you send an email message that has an attachment that exceeds 128 KB, the [Mailbox Transport Submission service](/exchange/mail-flow/mail-flow#understanding-the-transport-pipeline) on Exchange Server 2016 and later versions creates a temporary file in the system temporary folder to process the attachment. However, if the drive that contains the system temporary folder has insufficient disk space to create the temporary file, Exchange Server drops the email message. In that scenario, Exchange Server doesn't send a non-delivery report (NDR) to the sender and doesn't retry delivery.

## Workaround

Monitor the free disk space on the drive that contains the system temporary folder to make sure that the drive has at least 1 GB of free disk space. The system temporary folder path is specified by the `TMP` system environment variable.

Because Exchange Server automatically monitors disk space on the drive that contains the Exchange Server [mail.que](/exchange/mail-flow/queues/queues#queue-database-files) file, consider setting the path value of the `TMP` system environment variable to a folder on the drive that contains the *mail.que* file. In the event of low free disk space on a drive that Exchange Server monitors, Exchange Server records [back pressure events](/exchange/mail-flow/back-pressure#back-pressure-logging-information) in the application log.
