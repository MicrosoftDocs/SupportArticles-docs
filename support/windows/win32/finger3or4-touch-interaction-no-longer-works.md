---
title: Some three- and four-finger touch interactions no longer work in apps by default
description: In Windows 11, some of the three or four finger interactions are no longer consumable by applications by default.
ms.date: 10/7/2020
ms.prod-support-area-path: Desktop app UI development
ms.reviewer: kybeck
---
# Some three- and four-finger touch interactions no longer work in apps by default

Windows 11 uses three- and four-finger touch swipe gestures for various operations such as switching or minimizing windows and changing virtual desktops.  As these interactions are handled at the system level, they are no longer consumable by applications by default, thus some functionalities inside your application(s) might be impacted.
To enable the use of three- or four-finger swipe interactions inside an application, there's a new user setting that controls whether or not the system will react to the gestures.  

This setting is: **Bluetooth & devices > Touch > Three- and four-finger touch gestures**
- When the setting is set to “On” (the default), the system will consume the three- and four-finger interactions and the apps will not be able to utilize them.
- When the setting is set to “Off,” the system will not consume the three- and four-finger interactions, and the apps will be able to utilize them.

If your application is reliant upon these interactions, you can direct users to this setting to disable the system interactions, allowing your application to behave as it did in Windows 10.

> [!NOTE]
> When enabled, this setting may also add a slight delay to some single- or two-finger touch interactions.
