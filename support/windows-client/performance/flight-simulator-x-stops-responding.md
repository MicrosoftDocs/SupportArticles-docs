---
title: Flight Simulator X hangs on loading screen
description: Fixes an issue in which Flight Simulator X hangs on the loading screen.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:applications, csstroubleshoot
ms.subservice: performance
---
# Flight Simulator X stops responding (hangs) on the loading screen

This article provides a solution to an issue where Microsoft Flight Simulator X stops responding on the loading screen.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 975084

## Symptoms

When you start Flight Simulator X, the game stops responding (hangs) on the loading screen.

## Resolution

To resolve this issue, rename the Logbook.bin file. To do this, follow these steps:

1. Click **Start**.
2. Click **My Documents** or **Documents**.
3. Double-click the Microsoft Flight Simulator X Files folder to open it.
4. Right-click the Logbook.bin file, and then click **Rename**.
5. Rename the file to *Logbook.OLD*, and then press ENTER.
6. Start Flight Simulator X to create a new Logbook file.
