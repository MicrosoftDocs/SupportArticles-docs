---
title: Outlook cannot download the RSS content error
description: Explains a behavior that may occur when you subscribe to an RSS feed that requires authentication.
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
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook cannot download the RSS content error when subscribing to an RSS feed that needs authentication

_Original KB number:_ &nbsp; 917125

## Symptoms

When you subscribe to an RSS feed in Microsoft Office Outlook 2007, Outlook 2010, or Outlook 2013, you may receive one of the following error messages:

> Outlook cannot download the RSS content from **Web_site_URL** because you do not have the required credentials.

> Outlook cannot download the RSS content from **Web_site_URL** because of a problem connecting to the server.

## Cause

This behavior may occur if the RSS feed requires authentication. Outlook supports authenticated RSS feeds only in the scenarios that are described in the Workaround section.

## Workaround

To work around this behavior, use one of the following methods:  

- Use an RSS site that is a Microsoft Office SharePoint site and that is internal to your domain. In this scenario, Outlook allows the use of NTLM credentials that are passed to the SharePoint site.
- Add the RSS feed in Microsoft Internet Explorer. Then, let the RSS feed synchronize with Outlook. This scenario requires synchronizing the RSS feeds list between Outlook and Windows.

### Outlook 2007

To configure this option in Outlook 2007, follow these steps:

1. On the **Tools** menu, select **Options**.
2. Select the **Other** tab, and then select **Advanced Options**.
3. Enable **Sync RSS feeds to the System Feed List**.  

### Outlook 2010 and Outlook 2013

To configure this option in Outlook 2010 and Outlook 2013, follow these steps:

1. Select **File**, then select **Options**.
2. Select **Advanced**.
3. Enable **Synchronize RSS Feeds to the Common Feed List (CFL) in Windows**.

## Status

This behavior is by design.
