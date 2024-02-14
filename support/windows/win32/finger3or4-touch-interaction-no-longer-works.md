---
title: Three-finger and four-finger touch interactions don’t work in Windows apps
description: In Windows 11, some three-finger and four-finger interactions are no longer usable by applications.
ms.date: 12/19/2023
ms.custom: sap:Desktop app UI development
ms.reviewer: kybeck
ms.subservice: desktop-app-ui-dev
---

# Three-finger and four-finger touch interactions don’t work in Windows apps

By default, Windows 11 uses three-finger and four-finger touch interactions for various operations, such as switching or minimizing windows, and changing virtual desktops. Because these interactions are handled at the system level, the functionality of various applications might be affected by this change.

To support three-finger or four-finger touch interactions within an application, a new user setting is introduced that specifies how the system handles these interactions.  

**Bluetooth & devices > Touch > Three- and four-finger touch gestures**

- If the setting is set to **On** (default), the system can use three-finger and four-finger interactions, but applications can't use them.
- If the setting is set to **Off**, applications can use three-finger and four-finger interactions, but the system can't use them.

If a particular application must support these interactions, we recommend that you inform users about this setting, and provide a link that starts the Windows Settings app and opens the relevant page (ms-settings:devices-touch). For more information, see [Launcher.LaunchUriAsync Method](/uwp/api/windows.system.launcher.launchuriasync?view=winrt-22000&preserve-view=true).
