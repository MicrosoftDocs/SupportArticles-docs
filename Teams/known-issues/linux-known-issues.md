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


 | <div style="column-width: 25%"> **Issue title** </div> |  **Behavior / Symptom**  |  **Known workaround**  |  **Discovery date**  | 
 | :-------- | :----- | :----- | :----- | 
 |  AutoStart on Linux is not working.   | AutoStart on Linux does not start the Teams application.   |    |  12/05/19  | 
 |  White screen when resuming from sleep/suspend. | When your computer resumes/wakes from sleep or suspend mode, there can be a network change (especially when the computer is connected to VPN before put to sleep/suspended) and that takes some time for the computer to reobtain the connection. The combination of these things can lead to a Teams white screen. |  Restarting Teams client will help. | 12/05/19   | 
 |  Cursor missing when screen sharing. |  While sharing screen, the other party does not see the cursor of the person sharing the screen. |   | 12/05/19  | 
 | Issue running in parallel with VMWare workstation.   | The Teams application experiences issues when running in parallel with VMWare workstation. |    | 12/05/19   | 
 | KDE notifications create new taskbar.  | Notification on KDE creates new window in taskbar.   |    | 12/05/19   | 
 | Package managers not showing change list.   | Package manager does not show change list.   |    | 12/05/19   | 
 | Cannot launch Teams client in offline mode.   | Unable to launch Teams Offline in Linux client.   |    | 12/05/19   | 
 | Device settings while in meeting.   | When in a meeting and changing device settings, the Microphone indicator isn't registering anything being picked up. |    | 12/05/19   | 
 | Can't close Teams application using keyboard. | Can't close the Teams application using the default `$mod + shift + q` or by clicking the close button in the app. |    | 12/05/19   | 

## Resolution

Microsoft is researching these problems and will post more information in this article when the information becomes available.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).