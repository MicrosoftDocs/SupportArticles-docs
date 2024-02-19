---
title: Delete saved logs from Event Viewer
description: Describes how to delete files under Saved Logs from the Event Viewer.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:event-viewer, csstroubleshoot
---
# How to delete "Saved Logs" from the Event Viewer

This article describes how to delete files under **Saved Logs** from the Event Viewer.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2489761

## Symptoms

If you frequently view many EVT or EVTX files in Event Viewer (eventvwr.msc), you may notice a large number of files have accumulated under Saved Logs. These entries are persistent even if the original EVT and EVTX files have been deleted.

## Cause

Event viewer stores saved log locations in .XML format.  The .XML files can be found in the following directory.  
%programdata%\Microsoft\Event Viewer\ExternalLogs

## Resolution

The following command can be run from a command prompt to purge the Saved Logs.  
`del /s /q %programdata%\microsoft\eventv~1\extern~1`  
You can also browse to the following location and delete the logs manually:  
C:\ProgramData\Microsoft\Event Viewer\ExternalLogs
> [!Note]
> The contents of this folder are hidden so you must turn on **Show Hidden Files** and turn off **Hide Protected Operating System Files** to see them.

## More information

Event Viewer reads the saved log locations when it starts and saves them when it is closed.  The following actions should be taken to guarantee Saved Logs are deleted properly.  

- Close all instances of Event Viewer (MMC.EXE) before attempting to clear Saved Logs from a command prompt.
- Make sure only one instance of Event Viewer is open if you are manually deleting Saved Logs from the GUI.
