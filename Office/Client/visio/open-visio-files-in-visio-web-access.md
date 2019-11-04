---
title: Can't open Visio files in Visio Web Access
description: Describes an issue in which you can't open Visio files in Visio Web Access even though you have Visio Viewer installed on the computer. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: elzhou, genli, christys
appliesto:
- Visio Pro for Office 365
- Visio 2019
- Visio 2016
- Visio 2013
- Visio 2013 Service Pack 1
- Visio 2010
---

# You can't open Visio files in Visio Web Access even if Visio Viewer is installed

## Symptoms

Consider the following scenario:

- You are running Internet Explorer.   
- You have Visio Viewer installed on the computer.   
- You try to open Microsoft Office Visio files in Visio Web Access.   
In this scenario, when you click Open in Visio, you receive the following error message:

```adoc
To open this document, your computer must be running a supported version of Microsoft Visio and a browser that supports opening files directly from Visio Web Access
```

## Cause

This issue occurs because Visio Web Access invokes the client application by using the **ms-visio:ofv|u|documenturl** protocol, but Visio Viewer doesn't support or process this protocol.

## Resolution

To resolve this issue, install [Microsoft Office Visio](https://products.office.com/en-US/Visio). 

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
