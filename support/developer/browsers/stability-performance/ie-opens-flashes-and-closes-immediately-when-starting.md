---
title: IE opens flashes and closes immediately when starting it
description: Helps resolve issues where Internet Explorer opens, flashes, and then closes immediately.
ms.date: 10/13/2020
ms.reviewer: lip, ramakoni
---
# Internet Explorer opens, flashes, and then closes immediately when you start it

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a resolution for the issue that Internet Explorer opens, flashes, and then closes immediately when you start it.

_Original product version:_ &nbsp; Internet Explorer 10, Internet Explorer 11  
_Original KB number:_ &nbsp; 967896

## Summary

You may notice that Internet Explorer opens, flashes, and immediately closes when you start Internet Explorer.

## Cause

The most common causes of Internet Explorer crashes like this are toolbars, add-ons, or Browser Helper Objects.

## Resolution

Reset Internet Explorer as per the following:

### For Windows 8.1 and Windows 10

1. Swipe in from the right edge of the screen (if you're using a mouse, press the Windows+C keys), and then tap or select **Search**. Enter *Internet options* in the search box, and then tap or select **Settings**.
2. In the search results, tap or select **Internet Options**. Tap or select the **Advanced** tab and then tap or select **Reset**.

   > [!NOTE]
   > Select the **Delete personal settings** check box if you would also like to remove browsing history, search providers, Accelerators, home pages, Tracking Protection, and ActiveX Filtering data.

3. In the **Reset Internet Explorer Settings** window, tap or select **Reset**.

    > [!NOTE]
    > To delete all personal settings, tap or select the checkbox for **Delete personal settings**.

4. Close and then restart Internet Explorer for the changes to take effect.

### For Windows XP, Windows Vista, and Windows 7

1. Exit all programs, including Internet Explorer.
2. If you use Windows XP, select **Start** > **Run**. Type *inetcpl.cpl* in the **Open** box, and then press Enter.

   If you use Windows 7 or Windows Vista, select the **Start** button. Type *inetcpl.cpl* in the **Search** box, and then press Enter. The **Internet Options** dialog box appears.

3. Select the **Advanced** tab.
4. Under **Reset Internet Explorer** settings, select **Reset**. Then select **Reset** again.

   Select the **Delete personal settings** check box if you also want to remove browsing history, search providers, Accelerators, home pages, Tracking Protection, and ActiveX Filtering data.

5. When Internet Explorer finishes resetting the settings, select **Close** in the **Reset Internet Explorer Settings** dialog box.
6. Start Internet Explorer again.

If you still can't access some websites, get help from the [Microsoft Community online](https://answers.microsoft.com).

For more information about How to reset settings in Internet Explorer, see the following video.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/c989d6d8-f8f9-4cb5-a2f1-da6a7e89f18b]

## Applies to

- Internet Explorer 11
- Internet Explorer 10
- Windows 10
- Windows 8.1
- Windows 8
- Windows 7 Ultimate
- Windows 7 Enterprise
- Windows 7 Home Basic
- Windows 7 Home Premium
- Windows 7 Professional
- Windows 7 Starter
