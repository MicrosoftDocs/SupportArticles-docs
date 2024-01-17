---
title: Online games error in Internet Explorer
description: Troubleshoot online game by updating your add-ons in Internet Explorer. Some sites that may be affected are Yahoo games, Facebook games, MSN games, and online games with other sites.
ms.date: 03/31/2023
ms.reviewer: 
---
# Troubleshoot problems playing online games using Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about resolving various errors reported by online games in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2528246

## Summary

When playing online games from websites like Facebook, Yahoo, MSN, and other websites using Internet Explorer, you may notice that the online games may not perform as expected. Playing or attempting to play online games may give the following results:

- Games may fail to download
- Games will not start
- Games may not load completely
- Some game functionality may not work
- You may be dropped from a game or game website when playing a game
- Your screen may go black when playing a game
- Games may freeze during play

> [!NOTE]
> If you're having issues with Internet Explorer functionality other than just games, see [Tips for solving problems when Internet Explorer crashes or stops working](https://support.microsoft.com/help/4026254/internet-explorer-has-stopped-working).

## More information

The most common cause is a missing or outdated add-on that's needed to play the game. Online games may be based on Silverlight, Flash, or Java and require Internet Explorer add-ons to function. Ensuring that you have the latest updates for Windows, Internet Explorer, and any Internet Explorer add-ons can help resolve many issues.

### Internet Explorer

If you're using **ActiveX Filtering** or **Tracking Protection** in Internet Explorer 9 or a later version, some content like games or videos might be disabled. To find out if you're using **ActiveX filtering** or **Tracking Protection**, see one of following articles:

- [Use ActiveX controls for Internet Explorer 11](https://support.microsoft.com/help/17469/windows-internet-explorer-use-activex-controls).
- [Use Do Not Track in Internet Explorer 11](https://support.microsoft.com/help/17288/windows-internet-explorer-11-use-do-not-track)

### Microsoft Silverlight

For games that use Silverlight, make sure you're using the latest version of Silverlight and that Silverlight is enabled in Internet Explorer.

> [!NOTE]
> Microsoft Silverlight reached the end of support in October 2021 and the installer is no longer available for download. For more information, see [Silverlight End of Support](https://support.microsoft.com/windows/silverlight-end-of-support-0a3be3c7-bead-e203-2dfd-74f0a64f1788).

### Java

For games that require Java add-ons, issues can be resolved by updating the add-ons to the latest version. The following troubleshooting steps may help to resolve the issue:

- Make sure you have the latest version of [Java](http://www.java.com/) installed.
- In some cases, it may be necessary to uninstall Java from your installed programs list and then reinstall the latest version.
- For help with Java issues, visit the [Java Help Center](https://www.java.com/en/download/help) website.

### Adobe Flash

For games that require Adobe Flash add-ons, make sure you're using the latest version of Adobe Flash.

> [!NOTE]
> Adobe Flash is no longer supported by Adobe. For more information, see [We have retired Flash](https://www.adobe.com/products/flashplayer/end-of-life-alternative.html).

### Adobe Shockwave Player

For games that require Adobe Shockwave Player add-ons, make sure you're using the latest version of Adobe Shockwave player.

> [!NOTE]
> Adobe Shockwave is no longer supported by Adobe. For more information, see [End of Life for Adobe Shockwave](https://helpx.adobe.com/shockwave/shockwave-end-of-life-faq.html).

### Make sure the add-ons are installed and enabled

To make sure that the necessary add-ons are enabled in Internet Explorer, follow these steps:

1. Start Internet Explorer and select **Tools** > **Internet Options**.
1. Select **Programs** > **Manage add-ons**.
1. From the **Show** dropdown selection, select **Run without Permissions**.
1. Look for the add-ons in the displayed list and make sure the **Status** is listed as **Enabled**.

> [!NOTE]
> When checking to see if the add-on is installed, you can also verify the version of the add-on.
