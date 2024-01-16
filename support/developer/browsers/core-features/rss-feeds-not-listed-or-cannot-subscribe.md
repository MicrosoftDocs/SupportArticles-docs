---
title: RSS feeds not listed or subscribed in Internet Explorer
description: Describes a solution for an issue in Internet Explorer in which RSS feeds are not listed or in which you cannot subscribe to RSS feeds.
ms.date: 03/08/2020
ms.reviewer: bchee
---
# RSS feeds are not listed or you cannot subscribe to RSS feeds in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides you the steps to solve the issue that the Really Simple Syndication (RSS) feeds are not listed or you cannot subscribe the RSS feeds in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 926448

## Symptoms

In Internet Explorer , you subscribe to Really Simple Syndication (RSS) feeds. Then, you may experience one or more of the following issues:

- The RSS feeds to which you subscribe are not listed in Internet Explorer.
- You cannot subscribe to RSS feeds in Internet Explorer.

## Cause

These issues may occur for one of the following reasons:

- The feed storage file is corrupted.
- An issue exists with the user profile.
- An issue exists with a browser add-on.
- A proxy server may be redirecting the form authentication page when you try to subscribe to feeds.

## Resolution

To resolve issues with missing feeds or to resolve issues when you try to subscribe to new feeds, follow these steps:

1. Start Internet Explorer.

2. Add a feed from an alternative trusted Web site.

3. Log on as a different user, and test the feed. If the issue is resolved, you can use the new user profile to work with RSS feeds.

4. If the issue continues, test in the Internet Explorer (No Add-ons) mode. To do this, follow these steps:

   1. Click **Start**, point to **All Programs**, point to **Accessories**, and then point to **System Tools**.
   2. Click **Internet Explorer (No Add-ons)**.

   > [!NOTE]
   > If the issue is resolved in this mode, use the **Manage Add-ons** option that is available in the **Tools** menu to isolate the specific browser add-ons that are causing the issue.

5. If the issue continues, remove and reimport the RSS feeds. To do this, follow these steps:

   1. Export the feeds on the computer to a file. For more information about how to export RSS feeds, see the [How to import or export RSS feeds](#how-to-import-or-export-rss-feeds) section.

   2. Close Internet Explorer.

   3. Remove the RSS feeds by removing the files from the following folder:  
      `%userprofile% \Local Settings\Application Data\Microsoft\Feeds`

   4. Open Internet Explorer, and then add one feed from a trusted Web site.

   5. Verify that the RSS feed from a trusted Web site is working correctly.

   6. Import the feeds from the file that you exported in step 5a earlier in this section. These are the feeds to which you previously subscribed. For more information about how to import RSS feeds, see the [How to import or export RSS feeds](#how-to-import-or-export-rss-feeds) section.

6. If you have determined that the proxy server is redirecting the form authentication page, you may be able to change the proxy setting to return the feeds.

   > [!NOTE]
   > Internet Explorer RSS Feed function does not support the form authentication page toward a request for the feeds.

### How to import or export RSS feeds

To export or import RSS feeds in Internet Explorer, follow these steps:

1. On the **File** menu, click **Import and Export**.

2. In the Import/Export Wizard, click **Next**.

3. In the **Choose an action to perform** list, click **Export Feeds** or **Import Feeds** as appropriate for your situation, and then click **Next**.

4. Follow the steps in the Import/Export Wizard to import or export feeds to a file.
