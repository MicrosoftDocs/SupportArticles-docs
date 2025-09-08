---
title: Emails sent to Poison queue with Unable to reserve MSAM error
description: Fixes an issue in which you receive the Unable to reserve MSAM for file parsing error message when email messages are sent to the Poison queue.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need Help with Configuring Mailflow, Mail routing (Connectors, Domains)
  - CI 144794
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jolarrew
appliesto: 
  - Exchange Server 2013
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# Emails sent to Poison queue with "Unable to reserve MSAM" error

If email messages are stuck in the Poison queue on one of the servers in your environment that's running Microsoft Exchange Server, try the following steps to troubleshoot the issue:

1. Check the event log on the server. You might find several relevant events logged, such as Event IDs 10001, 4010, 4007, 1051, 17025, 4999, or 2203. The messages in event IDs 4010, 4999, and 2203 should resemble the following samples, and will contain the text that's shown as bold.

   - Event 4010 – Source: MSExchange Messaging Policies – Task Category: Rules – Message: Transport engine failed to evaluate condition due to Filtering Service error. The rule is configured to ignore errors. Details: Message ID [\<message ID>]. Rule ID: [\<rule ID>]. Predicate [predicate] Action Filtering Service Failure Exception Error: **FIPS test Extraction failed with error: 'Scanning Process caught exception: … Unknown Error 2214608899. Unable to reserve MSAM for file parsing – the engine is permanently offline'**. See inner exception for details.

   - Event 4999 – Source: MSExchange Common – Task Category: General – Message: Watson report about to be sent for process id: [\<process id>], with parameters: E12II, **c-RTL-AMD64**, 15.02.0792.003, edgetransport, mscorlib, M.W.RegistryKey.CreateSubKeyInternal, System.UnauthorizedAccessException, a293-dempidset, 04.08.4300.000, ErrorReportingEnabled: False

   - Event 2203 – Source: FIPFS – Message: **A FIP-FS Scan process returned error** 0x84004003 PID: [\<PID>] Msg: Scanning Process caught exception "Unable to reserve MSAM for file parsing – the engine is permanently offline ID: {[\<GUID>]}"

2. Check whether the message tracking log contains "FAIL" events that have the following value for the `LastError` property:

   > LastError: DSN 5.3.0 Too many related errors.

If the affected Exchange-based server has the Transport Rule agent enabled, disable the agent, and resubmit the messages. This action removes the blockage in the message queue. However, when you enable the Transport Rule agent again, the issue recurs.

## Cause of the error

If you see the bold text from the sample messages in the event logs entries, this indicates that the issue occurs because the required files are missing from the *:::no-loc text="<%Exchange_Installation_Path%>FIP-FS\\Data\\Engines\\amd64":::* folder. When the FIP-FS engine tries to scan messages while they are being categorized, it requires the files in this folder to complete the process. If the files are missing, the event IDs that are listed in the previous section are generated, and the email messages are put into the Poison queue.  

## Resolve the error

To resolve this issue, copy all the files in the *:::no-loc text="<%Exchange_Installation_Path%>FIP-FS\\Data\\Engines\\amd64":::* folder on an unaffected Exchange-based server to the same folder on the affected Exchange-based server.

**Note:** The *:::no-loc text="<%Exchange_Installation_Path%>":::* path segment is usually *:::no-loc text="C:\\Program Files\\Microsoft\\Exchange Server\\V15\\":::* (including the trailing "\\").

If you don't have access to an unaffected Exchange-based server to be able to copy the appropriate files, contact [Microsoft Support](https://support.microsoft.com/contactus).
