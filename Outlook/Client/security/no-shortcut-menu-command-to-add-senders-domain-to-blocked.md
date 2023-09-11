---
title: Cannot add sender's domain to Blocked Senders list
description: Describes an Outlook 2007, Outlook 2010 and Outlook 2013 behavior in which a shortcut menu command is not available to add a sender's domain to the Blocked Senders list. A workaround is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Outlook 2013
  - Microsoft Office Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 03/31/2022
---
# There is no shortcut menu command to add a sender's domain to the Blocked Senders list in Outlook

_Original KB number:_ &nbsp; 980552

## Symptoms

When you right-click an email message in Microsoft Office Outlook 2007, Outlook 2010 or in Outlook 2013, there is no shortcut menu command to add a sender's domain to the **Blocked Senders** list.

> [!NOTE]
> When you right-click an email message, there is a shortcut menu command to add a sender's domain to the **Safe Senders** list.

|Outlook 2007|Outlook 2010 and Outlook 2013|
|---|---|
|:::image type="content" source="./media/no-shortcut-menu-command-to-add-senders-domain-to-blocked/junk-email-menu-2007.png" alt-text="Screenshot showing Outlook 2007 Junk Email menu." border="false":::|:::image type="content" source="./media/no-shortcut-menu-command-to-add-senders-domain-to-blocked/junk-email-menu-2010-2013.png" alt-text="Screenshot showing Outlook 2010 Junk Email menu." border="false":::|

## Cause

This behavior is by design in Outlook 2007, Outlook 2010 and in Outlook 2013. The command to block the sender's domain was not added to the shortcut menu in order to prevent users from accidentally selecting it. By selecting such a command, a user might have unintentionally blocked everyone who sends an email message from that specific domain. This includes everyone who uses a common carrier or ISP, such as `@example.com`.

## Workaround

To work around this behavior, manually add the sender's domain to the **Blocked Senders** list. To do this, follow these steps.

1. Right-click the email message that was sent from a domain that you want to block, point to **Junk E-mail**, and then select **Junk E-mail Options**.
2. Select the **Blocked Senders** tab.
3. Select **Add**.
4. Type the domain that you want to block, such as `@example.com`.
5. Select **OK**.
6. Select **OK** to close the **Junk E-mail Options** dialog box.
