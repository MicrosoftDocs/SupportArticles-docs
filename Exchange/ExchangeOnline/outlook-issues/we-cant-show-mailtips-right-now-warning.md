---
title: We can't show MailTips right now warning
description: Describes an issue that occurs after you change the From address to the address of a non-mailbox-enabled recipient.
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
ms.reviewer: kellybos
appliesto:
- Exchange Online
search.appverid: MET150
---
# We can't show MailTips right now warning in Outlook in Microsoft 365

_Original KB number:_ &nbsp; 3083843

## Symptoms

In Outlook in Microsoft 365, you receive a **We can't show MailTips right now** warning after you change the **From** address to the address of a non-mailbox-enabled recipient.

:::image type="content" source="media/we-cant-show-mailtips-right-now-warning/we-cant-show-mailtips-right-now-warning.png" alt-text="A screenshot of the We can’t show MailTips right now warning" border="false":::

You may also see a similar warning when you forward a meeting invite for a non-mailbox-enabled recipient.

:::image type="content" source="media/we-cant-show-mailtips-right-now-warning/warning-when-forwarding-meeting.png" alt-text="A screenshot of a warning when forwarding a meeting invite for a non-mailbox-enabled recipient" border="false":::

However, in Outlook Web App (OWA), you don't see this warning. Instead, OWA displays a MailTip from the current forest.

## Cause

This behavior is by design.

## More information

The attempt to complete a MailTips lookup fails if the From  address that you specify isn't associated with a mailbox in the current user's forest when you use Outlook. The MailTips feature tries to complete the lookup under the security context of the user in the From  address. The attempt fails if the recipient isn't a mailbox user in the current forest.

For example, if the address is associated with a distribution group or a mail user, you receive the following error message in the Outlook logs:

The **ActingAs** parameter does not match a user in the directory.

MailTips from the current forest are displayed in OWA.
