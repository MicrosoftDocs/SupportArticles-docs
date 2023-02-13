---
title: Online games error in Internet Explorer
description: Troubleshoot online game by updating your add-ons in Internet Explorer. Some sites that may be affected are Yahoo games, Facebook games, MSN games, and online games with other sites.
ms.date: 04/29/2020
ms.reviewer: 
ms.technology: internet-explorer-development-website
---
# Troubleshoot problems playing online games using Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about resolving various errors reported by online games in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2528246

## Summary

When playing online games from websites like Facebook, Yahoo, MSN, and other websites using Internet Explorer you may notice that the online games may not perform as expected. Playing or attempting to play online games may give the following results:

- Games may fail to download
- Games will not start
- Games may not load completely
- Some game functionality may not work
- You may be dropped from a game or game website when playing a game
- Your screen may go black when playing a game
- Games may freeze during play

> [!NOTE]
> If you are having issues with Internet Explorer functionality other than just games, see [Tips for solving problems when Internet Explorer crashes or stops working](https://support.microsoft.com/help/4026254/internet-explorer-has-stopped-working).

## More information

The most common cause is a missing or outdated add-on that's needed to play the game. Most online games are based on Silverlight, Flash, or Java and do require Internet Explorer add-ons to function. In most cases, ensuring that you have the latest updates for Windows, Internet Explorer and any Internet Explorer add-ons can help resolve most issues. To troubleshoot online games issues in Internet Explorer do the following:

### Internet Explorer

If you are using **ActiveX Filtering** or **Tracking Protection** in Internet Explorer 9 or a later version, some content like games or videos might be disabled. To find out if you are using **ActiveX filtering** or **Tracking Protection**, see one of following articles:

- [Use ActiveX controls for Internet Explorer 11](https://support.microsoft.com/help/17469/windows-internet-explorer-use-activex-controls).
- [Use Do Not Track in Internet Explorer 11](https://support.microsoft.com/help/17288/windows-internet-explorer-11-use-do-not-track)

### Microsoft Silverlight

For games that use Silverlight, issues can be resolved by updating to the latest version of Silverlight. The following troubleshooting steps may help to resolve the issue:

- Install the latest version of [Silverlight](https://www.microsoft.com/silverlight) and then make sure Silverlight is enabled in Internet Explorer
- If you need to uninstall and then reinstall Silverlight visit the [Get Microsoft Silverlight](https://www.microsoft.com/getsilverlight/get-started/install/default.aspx) website and click the Uninstall Silverlight tab
- For help with Silverlight issues, visit the [Silverlight Community](https://www.microsoft.com/silverlight/community) website

### Java

For games that require Java add-ons, issues can be resolved by updating the add-ons to the latest version. The following troubleshooting steps may help to resolve the issue:

- Make sure you have the latest version of [Java](http://www.java.com/) installed
- In some cases, it may be necessary to uninstall Java from your installed programs list and then reinstall the latest version
- For help with Java issues, visit the [Java Help Center](https://www.java.com/en/download/help) website

### Adobe Flash

For games that require Java add-ons, issues can be resolved by updating the add-ons to the latest version. The following troubleshooting steps may help to resolve the issue:

- Update to the latest version of [Adobe Flash](http://www.adobe.com/downloads)
- In some cases, it may be necessary to uninstall Adobe Flash from your installed programs list and then reinstall the latest version
- For help with Adobe Flash issues, visit the Adobe [Flash Help and Support](http://www.adobe.com/support/flash) website

### Adobe Shockwave Player

For games that require Adobe Shockwave Player add-ons, issues can be resolved by updating the add-ons to the latest version. The following troubleshooting steps may help to resolve the issue:

- Update to the latest version of [Adobe Shockwave](http://get.adobe.com/shockwave/otherversions).
- In some cases, it may be necessary to uninstall Adobe Shockwave Player from your installed programs list and then reinstall the latest version.
- For help with Adobe Shockwave issues, visit the [Adobe Shockwave Player Help and Support](http://www.adobe.com/support/shockwave) website.

### Make sure the add-ons are installed and enabled

You will need to make sure that the necessary Add-ons are enabled in Internet Explorer, to do this follow the steps below:

1. Start Internet Explorer and click the **Tools** icon and then click **Internet Options**.
2. Click the **Programs** Tab and click the **Manage add-ons** button.
3. From the **Show** dropdown selection, select **Run without Permissions**.

Look for the following add-ons in the displayed list and make sure the Status is listed as Enabled.

> [!NOTE]
> When checking to see if the add-on is installed you can also verify the current version of the add-on.

- The add-on for Microsoft Silverlight is listed as:

  - Microsoft Silverlight

- The add-ons for Adobe Flash and Adobe Shockwave Player are listed as:

  - Shockwave Active X Control
  - Shockwave Flash Object

- The add-on for Java is listed as:

  - Java Plug-in (May be multiple add-ons)
