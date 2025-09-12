---
title: Can't open Visio files in Visio Web Access
description: Describes an issue in which you can't open Visio files in Visio Web Access even though you have Visio Viewer installed on the computer. Provides a resolution.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open
  - CSSTroubleshoot
ms.author: meerak
ms.reviewer: elzhou, jarrettr, aartigoyle
appliesto: 
  - Visio Pro for Microsoft 365
  - Visio 2019
  - Visio 2016
  - Visio 2013
ms.date: 06/06/2024
---

# You can't open Visio files in Visio Web Access even if Visio Viewer is installed

## Symptoms

Consider the following scenario:

- You are running Internet Explorer.
- You have Visio Viewer installed on the computer.
- You try to open Microsoft Office Visio files in Visio Web Access.

In this scenario, when you click Open in Visio, you receive the following error message:

> To open this document, your computer must be running a supported version of Microsoft Visio and a browser that supports opening files directly from Visio Web Access

## Cause

This issue occurs because Visio Web Access invokes the client application by using the **ms-visio:ofv|u|documenturl** protocol, but Visio Viewer doesn't support or process this protocol.

## Workaround

To work around this issue, install [Visio desktop app](https://support.microsoft.com/office/install-visio-or-access-visio-for-the-web-f98f21e3-aa02-4827-9167-ddab5b025710#VisioInstall=Install_Visio). 

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
