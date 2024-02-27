---
title: Calendar items for the next year may display an incorrect time in Outlook
description: After time zone or daylight savings time changes, some calendar items scheduled for the next year may appear with an incorrect time in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 109336
  - CSSTroubleshoot
ms.reviewer: tasitae, sbradley, randyto, gbratton
appliesto: 
  - Outlook 2013
  - Outlook 2016
  - Outlook 2019
search.appverid: 
  - MET150
ms.date: 01/30/2024
---

# Calendar items for next year may display an incorrect time in Outlook

## Symptoms

After your country/region makes time zone or daylight saving time changes, some of your Microsoft Outlook calendar items that are scheduled for the next year may be displayed at an incorrect time when you view them in Outlook.

## Cause

This issue occurs because Outlook doesn't apply time zone rules for recurring meetings until the year in which the time zone definition changes are set to occur.

## Workarounds

**Option 1**: Wait until the year of the time zone definition change. After that the year begins, your meetings will be displayed at the correct time in Outlook.

**Option 2**: Use Outlook on the web (OWA) to view Outlook calendar items. OWA isn't affected by this issue.

**Option 3**: Install the latest build of Microsoft 365 Subscription products (version 1910 (build 12130.20410)) or a Windows Installer (MSI)-based version of Outlook 2016, and then set the **TimeZoneOverride** registry key. This workaround lets you configure the year that Outlook uses when it applies time zone rules for recurring meetings by using the **TimeZoneOverride** registry key setting.

**Special considerations for Brazil**

To work around the Brazil issues that are described in the "**More information**" section, set the year that Outlook uses to 2020 in the **TimeZoneOverride** registry key.

To apply this workaround for Brazil, follow these steps:

1. Install the applicable update for Office.
    
    **For Microsoft 365 Subscription installations**
    
    1. Install Microsoft 365 version 1910 (build 12130.20410) or a later version. To do this, follow these steps:
       1. In Outlook, select **File** > **Office Account**.
       1. Select **Update Options** > **Update Now**. 

           **Note** If **Update Now** is not available, select **Enable updates**. Then, select **Update Now** under **Update Options** again.
    
    1. After the update is applied, select **File** > **Office Account**, and then verify that the version that is listed is version 1910 (build 12130.20410) or a later version. If it is not, select **Update Options** > **Update Now** again to install the latest update.
    
    **For a Windows Installer (MSI) based version of Outlook 2016**
     1. Download and install [KB 4484172](https://support.microsoft.com/help/4484172).
     2. Verify that Outlook.exe is version 16.4939.1001 or a later version. To do this, follow these steps:
         1. Locate Outlook.exe in either C:\Program Files\Microsoft Office\Office16 or C:\Program Files (x86)\Microsoft Office\Office16.
         2. Right-click Outlook.exe and then select **Properties**.
         3. View the **Details** tab to verify that the file version is 16.4939.1001 or a later version.
1. Set the **TimeZoneOverride** registry key:
    1. Select **Start**, select **Run**, type regedit in the **Open** box, and then select **OK**.
    1. Locate **HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook**, and then select the **Outlook** node in the navigation pane.
    1. On the **Edit** menu, select **New** > **Key**.
    1. Type TimeZoneOverride and then press **Enter**.
    1. Select the **TimeZoneOverride** registry key that you just created.
    1. On the **Edit** menu, select **New** > **DWORD (32-bit) Value**.
    1. Type E. South America Standard Time, and press Enter.
    1. Double-click **E. South America Standard Time**, set **Base** to **Decimal**, type **2020** in the **Value data**, and then select **OK**. 

The final registry data should be displayed as follows:

:::image type="content" source="./media/calendar-items-display-incorrect-time/e-south-america-standard-time-registry.png" alt-text="Screenshot of the TimeZoneOverride registry key setting.":::

> [!NOTE]
> - You should remove the **E. South American Standard Time** registry value after January 1, 2020.
> - When this workaround is applied, meetings that occur in early 2019 will appear to be one hour off.

## More information

As an example of this issue, the government of Brazil announced in 2019 that it would not change its clocks for the upcoming daylight saving time period, that was scheduled to last from November 3, 2019, through February 15, 2020. Recurring meetings for January 7, 2020, through February 15, 2020, that are received by users in 2019 in the Brazil time zone may appear one hour off when they are viewed in the Outlook calendar through December 31, 2019. These meetings will be displayed at the correct time on or after January 1, 2020. 
