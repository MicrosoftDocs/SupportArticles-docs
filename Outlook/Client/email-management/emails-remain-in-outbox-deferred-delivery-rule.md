---
title: Emails remain in Outbox for at least one minute
description: This article provides a solution to an issue where email messages remain in the Outbox folder for at least one minute before it's sent.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: gregmans
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Office Outlook 2007
  - Office Outlook 2003
ms.date: 01/30/2024
---
# Email messages remain in the Outbox because of Deferred Delivery rule

_Original KB number:_ &nbsp; 2894412

## Symptoms

When you send an email message, it may remain in the Outbox folder for at least one minute before it's sent.

## Cause

This problem can occur if you have a Deferred Delivery rule configured to delay the sending of some or all email messages.

## Resolution

Use the following steps to determine if you have a Deferred Delivery rule configured and if so, the criteria configured for the rule.

- Outlook 2010 or later versions

  1. Click **Rules** on the Ribbon and then click **Manage Rules & Alerts**.

  2. Select each rule listed on the **Email Rules** tab and then examine the information under **Rule description**.

      Rules that delay delivery on *Send* will have *defer delivery by # minutes* in the rule description.

      :::image type="content" source="media/emails-remain-in-outbox-deferred-delivery-rule/outlook-2010-rules-and-alerts.png" alt-text="Screenshot of the Rules and Alerts dialog box.":::

  3. Double-click any rule to examine the criteria specified for the rule.
  
  4. If needed, clear the defer delivery by a number of minutes action.

     This setting is shown enabled in the following figure.

     :::image type="content" source="media/emails-remain-in-outbox-deferred-delivery-rule/outlook-2007-rules-wizard.png" alt-text="Screenshot of the Rules Wizard dialog box. Defer delivery by a number of minutes option is enabled." border="false":::

- Outlook 2007 or earlier versions

  1. On the **Tools** menu, click **Rules and Alerts**.
  
  2. Select each rule listed on the **E-mail Rules** tab and then examine the information under **Rule description**.

     Rules that delay e-mail delivery on *Send* will have *defer delivery by # minutes* in the rule description.

  3. Double-click any rule to examine the criteria specified for the rule.
