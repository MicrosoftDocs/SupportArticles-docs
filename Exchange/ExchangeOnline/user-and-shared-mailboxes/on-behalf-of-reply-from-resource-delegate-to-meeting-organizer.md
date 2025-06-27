---
title: On behalf of reply from resource delegate to organizer
description: Describes a scenario in which a meeting acceptance reply is sent to the meeting organizer on behalf of a delegate who has been added to a resource mailbox in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: chwillia, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# On behalf of reply from a resource delegate to the meeting organizer in Microsoft 365

_Original KB number:_ &nbsp; 2879458

## Symptoms

In Microsoft 365, assume that one or more delegates are added to a resource mailbox, and that a delegate accepts a meeting request. In this situation, the **From** line of the email message that's sent to the meeting organizer says <**Delegate**> on behalf of <**ResourceMailbox**>.

## Cause

When a delegate is added to a resource mailbox through the **Select delegates who can accept or decline booking requests** option, the delegate is granted **Send on Behalf** permissions. This behavior is by design in Microsoft 365.

## Workaround

Go to the Exchange admin center, and then open the settings for the resource mailbox. In the navigation pane, select **mailbox delegation**, and then under **Send As**, add the delegate.

> [!NOTE]
> Don't remove the delegate who is listed under **Send on Behalf**. Removing the delegate also removes delegate access.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
