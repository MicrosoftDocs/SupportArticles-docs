---
title: Event ID 1014 when connecting to Exchange Online mailbox
description: Describes an issue that blocks users from connecting to their Exchange Online mailboxes in Outlook or Outlook on the web. Event ID 1014 is logged in this situation. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Event ID 1014 when users try to connect to their Exchange Online mailbox

_Original KB number:_ &nbsp; 3154531

## Symptoms

When users try to access their Exchange Online mailbox in Microsoft Outlook or Outlook on the web (formerly known as Outlook Web App), event ID 1014 is logged multiple times in the System log in Event Viewer:

## Cause

This issue may occur if the request was blocked by third-party malware or an Internet protection suite. The time to live (TTL) on the `outlook.office365.com` DNS record is five minutes. Therefore, Windows refreshes the record at an interval of five minutes. Third-party malware and Internet protection suites have been found to block the request at this frequency, which prevents users from using Outlook or Outlook on the web to connect to their Exchange Online mailbox.

## Resolution

Work with your third-party vendor to set up exclusions for the `outlook.office365.com` DNS record.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
