---
title: Incorrect search results when using a date filter in the Outlook search bar
description: Provides a workaround for an issue in which you receive incorrect search results when you enter a received or sent date filter in the Outlook search bar.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Rules, search and Printing\Indexing
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 181611
ms.reviewer: gbratton, batre, meerak, v-trisshores
appliesto: 
  - Microsoft 365 Apps for enterprise
search.appverid: MET150
ms.date: 01/30/2024
---

# Incorrect search results when using a date filter in the Outlook search bar

## Symptoms

When you enter a "received" or "sent" date filter as text in the Microsoft Outlook search bar, you find that one or both of the following issues occur:

- The search results don't include all matching items.

- The search results include nonmatching items.

For example, your time zone is Pacific Time and you enter "received:01/20/2023" in the Outlook search bar to search your mailbox for messages that arrived on that day. However, the following issues occur:

- The search results don't include email messages that you received between 4 PM and midnight on January 20, 2023.

- The search results include email messages that you received between 4 PM and midnight on January 19, 2023.

## Cause

The issue might occur if all the following conditions apply:

- You have an on-premises Microsoft Exchange Server mailbox.

- Your time zone isn't UTC+0.

- You use the Outlook desktop app from Microsoft 365 Apps for enterprise.

- You enter a date-based search query as text in the Outlook search bar.

If these conditions are true, Outlook doesn't include your time zone when it sends your search query to the on-premises Exchange server that hosts your mailbox. In the absence of a specified time zone, Exchange Server uses the UTC+0 time zone for the search query. Therefore, the following issues occur:

- The search results exclude messages that are within your time zone window but outside the UTC+0 window.

- The search results include messages that are outside your time zone window but within the UTC+0 window.

## Workaround

To work around the issue, run your search in the Outlook Advanced Search window. Follow these steps:

1. Select the Outlook search box, and then select the down arrow to open the Advanced Search window.

2. Set the search criteria. If you want to search received email messages, set the **Received** date range by using the drop-down calendars for the start and end dates of the **Received** field. If you want to search sent email messages, select **Add more options** \> **Sent** \> **Apply**, and then set the **Sent** period.

3. Select **Search**.

For searches that are initiated in the Advanced Search window, Outlook includes your time zone when it sends your search query to Exchange Server.
