---
title: Email messages stuck in the Poison queue
description: Fixes an issue in which you get the "Unable to reserve MSAM for file parsing" error when email messages are sent to poison queue.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom:
- CI 144794
- Exchange Server
- CSSTroubleshoot
ms.reviewer: jolarrew
appliesto:
- Exchange Server 2013
- Exchange Server 2016
- Exchange Server 2019
search.appverid: MET150
---
# Email messages sent to the Poison queue

If email messages are stuck in the queue on one of the Exchange servers in your environment, try the following steps to troubleshoot the issue.

1. Check the event log on the server. You might see that a number of events have been logged such as event IDs 10001, 4010, 4007, 1051, 17025, 4999, and 2203. The messages in event IDs 4010, 4999 and 2203 should be similar to the following and contain the text in bold font.

   - > Event 4010 – Source: MSExchange Messaging Policies – Task Category: Rules – Message: Transport engine failed to evaluate condition due to Filtering Service error. The rule is configured to ignore errors. Details: Message ID [\<message ID>]. Rule ID: [\<rule ID>]. Predicate [predicate] Action Filtering Service Failure Exception Error: **FIPS test Extraction failed with error: 'Scanning Process caught exception: … Unknown Error 2214608899. Unable to reserve MSAM for file parsing – the engine is permanently offline'**. See inner exception for details.

   - > Event 4999 – Source: MSExchange Common – Task Category: General – Message: Watson report about to be sent for process id: [\<process id>], with parameters: E12II, **c-RTL-AMD64**, 15.02.0792.003, edgetransport, mscorlib, M.W.RegistryKey.CreateSubKeyInternal, System.UnauthorizedAccessException, a293-dempidset, 04.08.4300.000, ErrorReportingEnabled: False

   - > Event 2203 – Source: FIPFS – Message: **A FIP-FS Scan process returned error** 0x84004003 PID: [\<PID>] Msg: Scanning Process caught exception "Unable to reserve MSAM for file parsing – the engine is permanently offline ID: {[\<GUID>]}"

2. Check whether the message tracking log has FAIL event IDs with the following value for the `LastError` property:

   > LastError: DSN 5.3.0 Too many related errors.

If the affected Exchange server has the Transport Rule agent enabled, then disable the agent and resubmit the messages. This action will remove the blockage in the message queue. However, when you enable the Transport Rule agent again, the issue will recur.

## Cause of the error

If you see the text in bold in the event logs, they indicate that the issue occurs because the required files are missing from the *:::no-loc text="<%ExchangeInstallPath%>FIP-FS\\Data\\Engines\\amd64":::* folder. When the FIP-FS engine tries to scan emails while they are being categorized, it requires the files in this folder to complete the process. If they're missing, the event IDs listed above are generated, and the email messages are placed in the Poison queue.  

## Resolve the error

To resolve this issue, copy all the files in the *:::no-loc text="<%ExchangeInstallPath%>FIP-FS\\Data\\Engines\\amd64":::* folder on an unaffected Exchange server to the same folder on the affected Exchange server.

**Note:** *:::no-loc text="<%Exchange_Install_Path%>":::* is usually *:::no-loc text="C:\\Program Files\\Microsoft\\Exchange Server\\V15\\":::* (includes a trailing "\\")

If you don't have access to an unaffected Exchange server to copy the appropriate files, contact [Microsoft Support](https://support.microsoft.com/contactus).
