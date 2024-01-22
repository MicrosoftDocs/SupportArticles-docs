---
title: A website doesn't load in the new Teams desktop client
description: Provides a workaround for an issue in which a site doesn't load when you select the Website tab in a Teams chat, channel, or meeting.
ms.date: 01/22/2024
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - New Microsoft Teams
ms.custom: 
  - CI 186119
  - CSSTroubleshoot
ms.reviewer: lomeybur
---

# A website doesn't load in the new Teams desktop client

## Symptoms

When you select the **Website** tab in a chat, channel, or meeting in Microsoft Teams, the site doesn't load correctly.

## Cause

This issue might occur in either of the following situations:

- The website is prevented from being embedded in other sites.
- Conditional Access policies are enforced in your organization. For more information, see [Tabs not working after enabling Conditional Access](./tabs-dont-work-after-enabling-conditional-access.md).

## Workaround

To work around the issue, select **Open in browser** in the following banner to open the site in a new browser tab outside Teams.

:::image type="content" source="media/websites-not-loaded-new-teams/open-in-browser.png" alt-text="Screenshot of the banner that shows the Open in browser button.":::

Or, if the content can be loaded by a corresponding app, use that app instead. For example, if you want to load a SharePoint page in a channel, use the **SharePoint Pages** app.
