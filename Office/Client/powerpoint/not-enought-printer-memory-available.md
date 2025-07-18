---
title: Not enough printer memory available to print page
description: Explains that you may receive a Not enough printer memory error when you print a presentation. This issue may be caused by an incorrect memory setting in the Windows printer driver. Requires that you reset the memory setting to resolve the problem.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Printing
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Microsoft PowerPoint
ms.date: 06/06/2024
---

# "Not enough printer memory available to print page" when you print a presentation in PowerPoint

## Symptoms

When you print a presentation in Microsoft PowerPoint, you may receive the following error message:

**Not enough printer memory available to print page.**

## Cause

This problem can occur because the memory setting on the Microsoft Windows printer driver is too low. The default memory setting for some printer drivers is the lowest possible setting. Therefore, this setting may be insufficient for your print job.

## Resolution

To fix this problem, reset the memory setting on the printer driver to reflect the exact amount of memory installed on the printer in question.

To change the printer driver memory setting, follow these steps:

1. Click Start, point to Settings, and then click Printers.   
2. Right-click the appropriate printer icon, and then click Properties.
3. Click the Device Options tab.
4. In the Printer Memory list, click the correct setting, and then click OK.

## References

For information about how to verify the amount of memory installed on your printer, see your printer manufacturer's user guide.
