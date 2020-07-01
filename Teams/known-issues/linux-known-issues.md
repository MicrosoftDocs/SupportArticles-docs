---
title: Known issues for Teams when run on Linux
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 7/1/2020
audience: Admin
ms.topic: article
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 120622
- CSSTroubleshoot 
ms.reviewer:  billw
description: Known issues for Teams when run on a Linux system.
---

# Teams known issues on Linux

## Known issues

This article lists known issues in Teams when operating on a Linux system.

| **Issue title** | **Behavior / Symptom** | **Known workaround** | **Discovery date** |
|:-----|:-----|:-----|:-----|
|AutoStart on Linux is not working.  |AutoStart on Linux does not start the Teams application.  |  |12/05/19 |
|White screen when resuming from sleep/suspend. <br/> |When your computer resumes / wakes from sleep or suspend mode there can be a network change (especially when the computer is connected to VPN before put to sleep/suspended) and that takes some time for the computer to reobtain the connection. The combination of these things can lead to a Teams white screen. <br/> |Restarting Teams client will help.  <br/> |12/05/19  <br/>|
|Cursor missing when screen sharing. <br/> |While sharing screen, the other party does not see the cursor of the person sharing the screen. <br/> | <br/> |12/05/19  <br/>|	
|Issue running in parallel with VMWare workstation. <br/> |The Teams application experiences issues when running in parallel with VMWare workstation. <br/> | <br/> |12/05/19  <br/>|
|KDE notifications create new taskbar.<br/> |Notification on KDE creates new window in taskbar. <br/> | <br/> |12/05/19  <br/>|
|Package managers not showing change list. <br/> |Package manager does not show change list. <br/> | <br/> |12/05/19  <br/>|
|Cannot launch Teams client in offline mode. <br/> |Unable to launch Teams Offline in Linux client. <br/> | <br/> |12/05/19  <br/>|
|Device settings while in meeting. <br/> |When in a meeting and changing device settings, the Microphone indicator isn't registering anything being picked up. <br/> | <br/> |12/05/19  <br/>|
|Can't close Teams application using keyboard. <br/> |Can't close the Teams application using the default `$mod + shift + q` or by clicking the close button in the app. <br/> | <br/> |12/05/19  <br/>|


## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).