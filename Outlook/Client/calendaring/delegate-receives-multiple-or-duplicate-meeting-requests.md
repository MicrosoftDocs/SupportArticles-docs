---
title: Delegate gets multiple or duplicate meeting requests
description: Provides a resolution for the issue that a delegate receives multiple or duplicate meeting requests in their Inbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2016 for Mac
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Delegate receives multiple or duplicate meeting requests in Outlook

_Original KB number:_ &nbsp; 3201352

## Symptoms

In Microsoft Outlook, a delegate receives multiple or duplicate meeting requests in their Inbox.

## Cause

This issue occurs when there are multiple hidden delegate rules in the Manager's mailbox, or when there's a corrupted delegate rule.

## Resolution

To resolve this issue, follow these steps:

1. Close the Manager's and Delegate's Outlook clients.
2. Download and start Microsoft Foundation Classes MAPI (MFCMAPI) on a computer that has Outlook installed. To do this, go to [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/).
3. Go to Quick Start, and then select **Inbox Rules**. If you're prompted, select the manager profile.
4. Find the rule whose `PR_RULE_PROVIDER` option is set to **SCHEDULE+ EMS Interface**, and then delete it.
5. Start Outlook by using the Manager profile: **File** > **Account Settings** > **Delegate Access**. Then, remove the delegate.
6. Restart Outlook.
7. Add the delegate to the Manager profile.
