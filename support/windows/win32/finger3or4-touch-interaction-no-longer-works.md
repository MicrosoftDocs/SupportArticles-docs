---
title: Some three- and four-finger touch interactions will no longer work in Windows apps by default
description: In Windows 11, some of the three or four finger interactions are no longer consumable by applications.
ms.date: 10/7/2020
ms.prod-support-area-path: Desktop app UI development
ms.reviewer: kybeck
---
# Some three- and four-finger touch interactions will no longer work in Windows apps by default

Windows 11, by default, uses three- and four-finger touch interactions for various operations such as switching or minimizing windows and changing virtual desktops. As these interactions are handled at the system level, your app's functionality might be affected by this change.

To support three- or four-finger touch interactions within an application, a new user setting has been introduced that specifies how the system handles these interactions.  

**Bluetooth & devices > Touch > Three- and four-finger touch gestures**

- When the setting is set to “On” (the default), the system can consume the three- and four-finger interactions and the apps can't use them.
- When the setting is set to “Off,” the system can't consume the three- and four-finger interactions, and the apps can use them.

If your application must support these interactions, we recommend that you inform users of this setting and provide a link that launches the Settings app to the relevant page (ms-settings:devices-touch). For more information, see [Launch the Windows Settings app](https://docs.microsoft.com/windows/uwp/launch-resume/launch-settings-app)
