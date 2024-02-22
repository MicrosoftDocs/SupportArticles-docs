---
title: Resource Scheduling options are disabled
description: This article provides a solution to solve the issue that the options in the Outlook Resource Scheduling dialog box are not available.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: abarglo, v-six
appliesto: 
  - Outlook 2010
  - Outlook 2007
  - Exchange Server 2013
  - Exchange Server 2010
  - Exchange Server 2007
search.appverid: MET150
ms.date: 01/24/2024
---
# Options in Outlook's Resource Scheduling dialog box are disabled

_Original KB number:_ &nbsp; 2859532

## Symptoms

When you open the **Resource Scheduling** dialog box in Microsoft Outlook, all the options in the dialog box are unavailable (dimmed). An example of this behavior is shown in this screenshot:

:::image type="content" source="media/disabled-options-in-resource-scheduling/resource-scheduling-dialog-box.png" alt-text="Screenshot of Resource Scheduling dialog box.":::

## Cause

This problem occurs when both of the following items are true:

- Your mailbox is on Exchange Server 2013, Exchange Server 2010, or Exchange Server 2007.
- There are no public folders in the Exchange environment.

Public folders are required for the direct booking feature (which is directly tied to the **Resource Scheduling** dialog box options).

## Resolution

To resolve this problem, use one of these approaches:

- Contact the Exchange administrator to see whether public folders can be added to the Exchange environment. Be aware that if they are currently not available, it is unlikely that the Exchange administrator will be able to do this because it is likely that the decision not to support public folders was already made.
- Instead of using direct booking, use an Exchange server resource mailbox instead. Starting in Outlook 2013, direct booking is no longer supported. Therefore, using an Exchange server resource mailbox would be the better option because direct booking cannot be used in later versions of Outlook.
