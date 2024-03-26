---
title: Content Organizer doesn't comply with specified interval
description: This article describes an issue where Content Organizer doesn't comply with specified interval for sending alerts to rule managers, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Lists and Libraries\Rules
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# Content Organizer doesn't comply with specified interval for sending alerts to rule managers

## Problem

In Microsoft SharePoint 2013, SharePoint 2010, or SharePoint Online, you use the Content Organizer to configure a rule to route content to a target library. The Content Organizer settings are configured to send an email message to rule managers when one or both of the following conditions are true:

- Submissions don't match the conditions that are specified by any existing rules.

- Content is left in the Drop Off Library.

   :::image type="content" source="media/content-organizer-not-comply-with-interval/rule-managers.png" alt-text="Screenshot of Rule Managers page. E-mail rule managers when submissions do not match a rule and when content is left in the Drop Off Library options are selected.":::

Although an email message is sent to the specified rule manager (or managers) when the item does not match any existing rules, the message may not be sent at the interval that's specified by the **Number of days to wait before sending an e-mail** setting.

## Solution

This is the expected behavior. Every time the Content Organizer Processing job runs, it sends an email message for any item that fails to match a rule. When a submission doesn't match a rule, the rule manager must be alerted immediately so that the appropriate action can be taken.

On the other hand, the E-mail rule managers when content has been left in the Drop Off Library setting is linked to the **Number of days to wait before sending an e-mail** setting. Any content that is left sitting in the Drop Off Library triggers an email message to the rule manager, but only at the specified interval.

For example, consider the case of a document that's in the Drop Off Library but that is also checked out. Although this content matches a rule, the document can't be routed correctly because of its checked-out state. Therefore, it remains in the Drop Off Library.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
