---
title: Performance issues in Cached Mode on Citrix Virtual Desktop
description: Documenting an OffCAT rule to identify potential performance issue configuration in Microsoft Outlook 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tmoore, gregmans
appliesto: 
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook 2010 performance issues in Cached Mode on Citrix Virtual Desktop

_Original KB number:_ &nbsp; 2994798

## Symptoms

Microsoft Outlook 2010 appears to run slowly in a Citrix Virtual Desktop environment, with degraded performance in, but not limited to the following:

- searches
- mailflow
- other actions involving client to server requests

## Cause

This behavior can occur if Outlook 2010 is using a Cached Mode profile in a Citrix Virtual Desktop environment. A Cached Mode profile is in use if the Outlook 2010 status bar displays **Connected to Microsoft Exchange**, as shown in the following figure:

:::image type="content" source="media/performance-issues-in-cached-mode-on-citrix-virtual-desktop/connected-to-microsoft-exchange.png" alt-text="Screenshot of Outlook 2010 status bar which displays Connected to Microsoft Exchange." border="false":::

## Resolution

Configure Microsoft Outlook 2010 to use an Online Mode profile instead of Cached Mode, using the following steps.

1. Launch Control Panel.

    - In Windows 8 and Windows 8.1

      Swipe in from the right to open the charms, tap or select **Search**, and then type *control panel* in the search box. Or, type *control panel* at the Start screen, and then tap or select Control Panel in the search results.

    - In Windows Vista and Windows 7

      Select **Start**, type *Control Panel* in the **Start Search** box, and then press Enter.

2. In Control Panel, locate and double-click **Mail**.
3. Select **Show Profiles**, and select **Add**.
4. Enter a profile name, and select **OK**.
5. Configure your Exchange email settings as needed, and select **Next**.
6. Check the **Manually configure server settings** checkbox, and select **Next**.
7. Uncheck the **Use Cached Exchange Mode** checkbox and select **Finish**.
8. In the Mail Control Panel, select either Prompt for a profile to be used, or select **Always use this profile** and select the new profile from the dropdown.
9. Select **OK**, and launch Outlook using the new profile.

    You can confirm that Outlook is using an Online Mode profile if the Outlook status bar displays **Online with Microsoft Exchange** as shown in the figure below.

    :::image type="content" source="media/performance-issues-in-cached-mode-on-citrix-virtual-desktop/online-with-microsoft-exchange.png" alt-text="Screenshot of Outlook status bar which displays Online with Microsoft Exchange." border="false":::

## More information

More information on this issue can be found in [Outlook 2010 Runs Slow in Citrix Virtual Desktop Infrastructure](https://support.citrix.com/article/CTX135084).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
