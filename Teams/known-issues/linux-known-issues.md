---
title: Known issues for Teams when run on Linux
ms.author: luche
author: helenclu
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

This article lists known issues that occur in Teams when it runs on a Linux system.


 | <div style="column-width: 25%"> **Issue title** </div> |  **Behavior / Symptom**  |  **Known workaround**  |  **Discovery date**  | 
 | :-------- | :----- | :----- | :----- | 
 | Issue running in parallel with VMWare workstation.   | The Teams application experiences issues when it runs in parallel with a VMware workstation. |   Not applicable  | 12/05/19   | 
 | KDE notifications create new taskbar.  | A notification on KDE creates a new window in the taskbar.   |   Not applicable  | 12/05/19   | 
 | Package managers not showing change list.   | The package manager does not show a change list as expected.   |   Not applicable  | 12/05/19   | 
 | Cannot launch Teams client in offline mode.   | You cannot start Teams Offline on a Linux client.   |   Not applicable  | 12/05/19   | 
 | Device settings while in meeting/No microphone input.   | When you change device settings in a meeting, the microphone indicator doesn't register any sound. |   Not applicable  | 12/05/19   | 
 | Webcamera is reversed. | In some notebooks the camera is reversed when it's installed. Because the device drivers do not recognize this problem, video feeds are displayed upside-down. | <ol><li>Locate v4l1compat.so in your system by using `locate v4l1compat.so` </li><li>Open the `/usr/share/applications/teams.desktop` file. </li><li>Replace the Exec line by substituting the following:<br /> `Exec=sh -c 'export LIBV4LCONTROL_FLAGS=1 && LD_PRELOAD=<PATH_TO_v4l1compat.so> usr/bin/teams %U'` </li></ol> | 12/05/19   | 

## Resolution

Microsoft is researching these problems and will post more information in this article when the information becomes available.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
