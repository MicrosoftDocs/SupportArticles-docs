---
title: Printer setting doesn't work with XPS-based print drivers
description: Describes a problem that prevents the printer on a Windows 7 Service Pack 1-based system from printing. This issue occurs when the printer uses an XPS-based print driver.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Print, Fax, and Scan\Print Performance - failures, crashes, not responsive, csstroubleshoot
---
# Print directly to the printer setting doesn't work with XPS-based print drivers

This article provides a solution to an issue where the **Print directly to the printer** option doesn't work with XPS-based print drivers.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 3017432

## Symptoms

Consider the following scenario:

- On a Windows 7 Service Pack 1-based system, you have a printer installed that uses an XPS-based print driver.
- On the **Advanced** tab of the printer properties, the **Print directly to the printer** option is selected.

In this scenario, print jobs do not print.

## Cause

When the **Print directly to the printer** option is selected, the print job must be rendered under the application process. However, with XPS-based print drivers, the print job is rendered under the PrintFilterPipelineSvc.exe process. Therefore, the print job must be sent to the spooler, where it is then sent to the PrintFilterPipelineSvc.exe process to be rendered.

## Workaround

To work around this issue, use one of the following methods:

- Configure the printer to use spooling.
- Use a GDI-based print driver.

## More information

Windows 8 and Windows 8.1 use the new v4 XPS-based printer model. Therefore, the **Print directly to the printer** option is unavailable (appears dimmed).
