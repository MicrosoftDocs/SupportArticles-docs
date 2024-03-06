---
title: Use MSTSC or universal Remote Desktop client instead of RDMan in Windows 10
description: Discusses why you should use Remote Desktop Connection or universal Remote Desktop client instead of RDMan in Windows 10.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jomukher, v-jesits
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
---
# Use Remote Desktop Connection or universal Remote Desktop client instead of RDMan in Windows 10

Virtualization and remote desktops are an important part of your infrastructure and work. And, we recommend that you use Windows built-in Remote Desktop Connection (%windir%\\system32\\mstsc.exe) or [universal Remote Desktop client](https://www.microsoft.com/p/microsoft-remote-desktop/9wzdncrfj3ps) instead of Remote Desktop Connection Manager (RDCMan).

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4512838

## More information

We're increasing our investments in virtualization and remote desktops, such as Azure Virtual Desktop and RDS on Microsoft Azure.

RDCMan is a client that is widely used to manage multiple remote desktop connections because it's a convenient option. However, RDCMan has not kept pace with the level of advanced technology that we're pursuing.

Instead, we have two great supported client options: Remote Desktop Connection and Universal Client for Windows 10. These clients offer increased security, and they are a key part of our engineering roadmap moving forward. In the future, you can expect even more capabilities, such as the ability to better manage multiple connections.
