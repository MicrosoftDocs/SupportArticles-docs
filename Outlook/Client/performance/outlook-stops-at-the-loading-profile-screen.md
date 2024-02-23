---
title: Outlook 2013 stops at the Loading Profile screen
description: Outlook may appear to freeze or hang at the start screen (splash screen).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans, aruiz
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook 2013 stops at the Loading Profile screen

_Original KB number:_ &nbsp; 2957336

## Symptoms

After starting Microsoft Outlook 2013, the program hangs or stops when the **Loading Profile** dialog appears, as shown in the following figure:

:::image type="content" source="media/outlook-stops-at-the-loading-profile-screen/loading-profile.png" alt-text="Screenshot of the loading profile screen." border="false":::

## Cause

This problem may occur when all of the following conditions are true:

- You have Office 2013 Service Pack 1 (SP1) installed as an MSI installation or you have the February 2014 update installed for a Click-to-Run installation.
- You have at least two video cards installed in your computer and one of them is an NVidia card (different models) and the other is an Intel(R) HD Graphics 4000 card.
- The **Disable hardware graphics acceleration** option is not selected in the **Outlook Options** dialog.

There is a conflict between the hardware graphics acceleration feature and this combination of video hardware when the video drivers are not at the latest version.

> [!NOTE]
> This issue has also been reported to occur on Office 2013 installations that do not have SP1 installed.

## Resolution

There are two resolutions to this problem. One is a temporary workaround and the other is the recommended long-term solution.

- Temporary workaround

  To get Outlook started without stopping at the **Loading Profile** dialog, add the `DisableHardwareAcceleration` registry subkey using the following steps.

  1. Exit all Office applications.
  2. Start Registry Editor.
  3.
     - In Windows 8, move your mouse to the upper-right corner, select **Search**, type *regedit*, in the search text box, and then select regedit.exe in the search results.

     - In Windows 7, select **Start**, type *regedit* in the **Search programs and files** text box, and then select regedit.exe in the search results.

  4. Locate and then select the registry subkey `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\Graphics\`.

  5. On the **Edit** menu, point to **New**, and then select DWORD Value.

  6. Type *DisableHardwareAcceleration*, and then press Enter.
  7. In the **Details** pane, right-click **DisableHardwareAcceleration**, and then select **Modify**.
  8. In the **Value** data box, type *1*, and then select **OK**.
  9. Exit Registry Editor, and then start Outlook.

  For more information, see [Display issues in Office client applications](/office/troubleshoot/settings/office-display-issues).

- This solution is considered a temporary solution because we recommend you take advantage of hardware graphics acceleration in Office programs. At your earliest convenience, follow the steps in the Recommended long-term solution section and re-enable hardware graphics acceleration in Office programs.

    > [!NOTE]
    > The setting shown in step 6 is an Office-wide setting even though you are disabling it from the Outlook options dialog box.

- Recommended long-term solution

  The recommended solution to fix this problem is to update your video drivers to the latest version. Once you have updated your video drivers, you should be able to re-enable hardware graphics acceleration for Office.

  Use the following steps to update your video card drivers.

  - Windows 8

    1. On the **Start** Screen, select **Settings** on the Charms Bar.
    2. Select **Change PC Settings**.
    3. In the PC settings app, select **Windows Update**.
    4. Select **Check for updates now**.
    5. If updates are available, select the driver that you want to install, and then select **Install**.

  - Windows 7

    1. Select **Start**.
    2. Type *Windows Update* in the **Search programs and files** box.
    3. In the search results, select **Check for updates**.
    4. If updates are available, select the driver that you want to install, and then select **Install**.

  > [!NOTE]
  > Video card manufacturers frequently release updates to their drivers to improve performance or to fix compatibility issues with new programs. If you do not find an updated video driver for your computer through Windows Update and you must have the latest driver for your video card, go to the support or download section of your video card manufacturer's website for information about how to download and install the newest driver.

  Once you have updated your video card drivers, revisit the steps in the Temporary workaround section. But, this time, select to clear the **Disable hardware graphics acceleration** option.

## More information

For more information, see [Display issues in Office client applications](/office/troubleshoot/settings/office-display-issues).
