---
title: On behalf of reply from resource delegate to organizer
description: Describes a scenario in which a meeting acceptance reply is sent to the meeting organizer on behalf of a delegate who has been added to a resource mailbox in Office 365.
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
ms.reviewer: chwillia
appliesto:
- Exchange Online
search.appverid: MET150
---
# On behalf of reply from a resource delegate to the meeting organizer in Office 365

_Original KB number:_ &nbsp; 2879458

## Symptoms

In Microsoft Office 365, assume that one or more delegates are added to a resource mailbox, and that a delegate accepts a meeting request. In this situation, the **From** line of the email message that's sent to the meeting organizer says <**Delegate**> on behalf of <**ResourceMailbox**>.

## Cause

When a delegate is added to a resource mailbox through the **Select delegates who can accept or decline booking requests** option, the delegate is granted **Send on Behalf** permissions. This behavior is by design in Office 365.

## Workaround

Go to the Exchange admin center, and then open the settings for the resource mailbox. In the navigation pane, select **mailbox delegation**, and then under **Send As**, add the delegate.

> [!NOTE]
> Don't remove the delegate who is listed under **Send on Behalf**. Removing the delegate also removes delegate access.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
