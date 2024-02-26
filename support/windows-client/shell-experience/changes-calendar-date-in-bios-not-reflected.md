---
title: Changes to calendar date in BIOS are not reflected in Windows
description: In Windows 8 or later and Windows 2012 or later, changing the date in the BIOS to a date earlier than the date shown in Windows does not change the date shown in Windows.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dst-and-timezones, csstroubleshoot
---
# Changes to calendar date in BIOS are not reflected in Windows

This article provides a resolution to an issue where changes to calendar date in BIOS are not reflected in Windows.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 2792897

## Symptoms

Consider the following scenario:

- You have a computer that runs Windows 8 or a later version, or Windows Server 2012 or a later version.
- In the computer BIOS, you change the calendar date to a value that is earlier than the date that Windows shows.
- You save the change, and you restart Windows

In this scenario, the Windows date setting does not reflect the change that you made to the calendar date in the BIOS.

## Cause

This behavior is by design. Windows considers the fact that time does not travel backward. Also, the BIOS on a laptop or notebook device may report a date that is earlier than the Windows date if the battery is failing or dead. In such cases, the BIOS date and time are not reliable.

## Resolution

If you have to change the calendar date on your computer, use the Windows settings to make the change instead of changing the date in the BIOS. This change will be reflected across multiple restarts.

## More information

This behavior is new to Windows 8 and Windows Server 2012. Additionally, this behavior does not affect changes to the calendar date in the BIOS if the new date is later than the date that Windows reports.
