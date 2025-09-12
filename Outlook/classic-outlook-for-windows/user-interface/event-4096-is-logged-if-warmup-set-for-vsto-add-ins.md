---
title: Event 4096 is logged if WarmUp set for VSTO add-ins
description: Describes an issue that triggers event 4096 if the WarmUp entry is set for VSTO add-ins in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Developer Issues\Add-in errors
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: thomno, gbratton
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Event 4096 is logged if the WarmUp entry is set for VSTO add-ins in Outlook

_Original KB number:_ &nbsp; 4017116

## Summary

When you install and register Visual Studio Tools for Office (VSTO) application-level Add-Ins for Microsoft Office, there's an optional registry entry named `Warmup`, which can be set.

The [Registry entries for VSTO Add-ins](/visualstudio/vsto/registry-entries-for-vsto-add-ins) explains as follows:

|Entry name|Type|Description|
|---|---|---|
|Warmup|REG_DWORD|Optional. A value that indicates that the .NET Framework and Visual Studio Tools for Office runtime load before an add-in loads and reduce the perceived time to load an add-in. Set the `Warmup` entry to 1 and use this in conjunction with `LoadBehavior` entry to reduce the load time for Outlook 2010 add-ins that are deployed by using Windows Installer (.msi). This registry key cannot be set by using ClickOnce.|

## More information

If this entry is enabled (set to **0x1**), the following event is logged in the Application log when the application starts and loads the add-in:

> Event ID: 4096  
> Source: VSTO
>
> Customization URI: file:///C:/Program Files (x86)/Common Files/Microsoft Shared/VSTA/Pipeline.v10.0/PipelineSegments.store
>
> Exception: Exception reading manifest from file:///C:/Program%20Files%20(x86)/Common%20Files/Microsoft%20Shared/VSTA/Pipeline.v10.0/PipelineSegments.store: the manifest may not be valid or the file could not be opened.

This event can be safely ignored and does not affect the functionality of either the application or the add-in.
