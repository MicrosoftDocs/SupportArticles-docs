---
title: The on-screen keyboard disappears in Skype Room Systems v2
description: The virtual keyboard isn't displayed in Skype Room Systems v2 after the Windows 10 Creators Update (version 1703) is installed on Surface Pro 4.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: chanh
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype Room System v2
ms.date: 03/31/2022
---

# The on-screen keyboard disappears in Skype Room Systems v2

## Symptoms

The virtual keyboard doesn't appear when you need to enter information in Skype Room Systems v2 (SRSV2). This issue occurs after the Windows 10 Creators Update (version 1703) is installed on the Surface Pro 4 on which SRSV2 is running.

## Workaround

To work around this issue, manually open the virtual keyboard. To do this, follow these steps:

1.Tap and hold the task bar, and then tap **Show touch keyboard button**. A keyboard icon should appear on the right side of the task bar.    
2. Tap the **keyboard** icon to open the virtual keyboard.    

## Resolution

> [!WARNING]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, back up the registry for restoration in case problems occur. 

To resolve this issue, create a "EnableDesktopModeAutoInvoke"=dword:00000001registry entry under HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\TabletTip\1.7. To do this, follow these steps:

1. Open Registry Editor.

    1. Tap and hold the task bar, and then tap **Show touch keyboard button**. A keyboard icon should appear on the right side of the task bar.
    2. Tap the **Search** icon on the left side of the task bar to open the search box.    
    3. Tap the **Search **box, type **regedit** on the virtual keyboard, and then tap **regedit** in the search results.    
    4. If Registry Editor doesn't open, swipe from the left side of the screen and tap **Registry Editor**.    
2. In Registry Editor, navigate to the following path:

    **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\TabletTip\1.7**

3. Tap and hold the **1.7** folder, tap **New** > **DWORD (32-bit) Value**.    
4. Enter the name **EnableDesktopModeAutoInvoke** and then tap **Enter **on the virtual keyboard.    
5. Double-tap the **EnableDesktopModeAutoInvoke** registry entry, enter **1** under "Value data", and then tap **OK**.    

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
