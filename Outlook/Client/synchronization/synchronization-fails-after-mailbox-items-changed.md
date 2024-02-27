---
title: Synchronization fails after mailbox items changed
description: Synchronization is unsuccessful after mailbox items are changed through EWS calls in cached mode Outlook client. Provides a workaround.
ms.author: meerak
author: cloud-writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: sfellman, genli
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise CAL
search.appverid: MET150
ms.date: 01/30/2024
---
# Synchronization is unsuccessful after mailbox items are changed through EWS calls in cached-mode Outlook client

_Original KB number:_ &nbsp; 4093129

## Symptoms

Assume that you run the Microsoft Outlook 2013, Outlook 2016, Outlook 2019, or Outlook for Microsoft 365 client in cached mode. When you close your Outlook client and then reopen it later, changes that were made to your mailbox items while Outlook was closed aren't synchronized as expected.

This issue most frequently occurs when mailbox items are changed by using Exchange Web Services (EWS) calls. These changes are sometimes performed by archiving solutions.

Under these conditions, the synchronization failure is expected for Outlook in cached mode.

## Workaround

To work around this issue, use one of the following methods:

- For cached Outlook clients, clear offline items from the folder where the sync failures occur. To clear offline items, right-click the folder in question, select **Properties**, select the **General** tab, and then select **Clear Offline Items**.
- Use Outlook in online mode.

## More information

Outlook depends on several MAPI properties to govern cached mode synchronization. The specific properties that Outlook uses are `PR_CHANGE_KEY` and `PR_PREDECESSOR_CHANGE_LIST`. In this case, the values for these two properties are decremented instead of incremented when messages are altered through EWS calls, and that action leads to the sync failure.
