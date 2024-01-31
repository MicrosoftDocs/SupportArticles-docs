---
title: Docked external monitor not working in Windows 10 version 1703
description: Address an issue in which the second monitor connected to a docking station does not work in Windows 10 version 1703.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dpi-and-display-issues, csstroubleshoot
ms.subservice: shell-experience
---
# Docking station external monitors not working when a Windows 10 version 1703-based portable computer is connected

This article provides a workaround for an issue where an external monitor connected to a docking station doesn't work when a Windows 10 version 1703-based portable computer is connected.

_Applies to:_ &nbsp; Windows 10  
_Original KB number:_ &nbsp; 4051625

## Symptoms

Consider the following scenario:

- You have external monitors that are connected to a docking station.
- You have a portable computer that is running Windows 10 version 1703.
- In **Power Options**, the **Lid close action** setting is configured to "Do nothing."
- You turn on the computer and then close the lid.
- You attach the computer to the docking station.

In this scenario, the computer doesn't detect the external monitors. Therefore, the external monitors display a black screen.

## Workaround

Use either of the following methods to force detection of the external monitors:

- Use the keyboard shortcut Win+Ctrl+Shift+B.
- In **Display Settings**, click the **Detect** button.

To work around this issue, use one of the following methods:

- Change **Lid close action** to any setting other than "Do nothing.". Before you make this change, make sure that the change does not affect your docking experience.
- Upgrade to Windows 10 Version 1709 that does not have this issue.
