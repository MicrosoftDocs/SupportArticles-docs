---
title: Error when opening a Visual Report in Project 2010 with Office 2013
description: Provides the resolution to fix the error that occurs when you open a Visual report in Project 2010 with Visio 2013.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project 2010
  - Office 2013
  - Visio 2013
ms.date: 03/31/2022
---

# Error when opening a Visual Report in Project 2010 with Office 2013

## Symptoms

When you attempt to open a Visual Report in Project 2010 with Visio 2013 installed you may receive the following error message:

> "This operation requires that you have Visio Professional 2007 or later installed on your computer."

When you attempt to open a Visual Report in Project 2010 with Excel 2013 installed you may receive the following error message:

> "The operation requires that you have Excel 2003 or later installed on your computer."

Project 2010 Visual Reports feature CANNOT work with either Visio 2013 or Excel 2013. You must use Office 2010 versions or lower for the reports to generate. 

## Cause

Office 2013 was developed and released after Project 2010.  The error message was relevant at the time Project 2010 was tested and released. 

## Resolution

You must install Visio 2010 or Excel 2010 (or lower) to utilize Project 2010's Visual Reports.  

## More Information

You can install both Office 2010 and 2013 products on the same machine, however the last product installed will update the registry.  Best practice would be to run the a repair on the 2013 product/s after 2010 is reinstalled.

Another option, if you have the Click-to-Run installation of Visio 2013 and/or Excel 2013 then they run in isolation which means they have their own registry keys and would not interfere with the 2010 versions of the same applications.  Click-to-Run versions of Office 2013 applications can be purchased and downloaded from Microsoft.