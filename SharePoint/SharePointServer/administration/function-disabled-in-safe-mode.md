---
title: Disabled Functions in safe mode in SharePoint
description: Lists the functions that are disabled when you start Microsoft SharePoint Workspace 2010 in safe mode. Also describes how to start in safe mode and provides an example of a problem that can be resolved in safe mode.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: patrigan
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Workspace 2010
ms.date: 12/17/2023
---

# Functions that are disabled in safe mode in SharePoint Workspace

## Summary

You can run Microsoft SharePoint Workspace 2010 in safe mode. Safe mode is useful in trying to resolve issues that prevent SharePoint Workspace from loading or that cause SharePoint Workspace to stop responding. 

## More Information

In safe mode, SharePoint Workspace starts without the following product functions: 

- Synchronization for any workspace type   
- Awareness   
- Messages, such as invitations   
- Notifications   
- Task Scheduler   

### How to start in safe mode

SharePoint Workspace usually starts in safe mode if the previous session failed. However, in some cases, you may want to manually start SharePoint Workspace in safe mode. There are two ways to do this:

- While SharePoint Workspace is starting, hold down the Control key.   
- Run the Groove.exe application from the command line, and use the /Safe option, as in the following example: C:\Program Files\Microsoft Office\Office14\Groove.exe /Safe   

### How to use safe mode

For example, consider the following scenario: 

- While you were offline, you added an oversized file to a Groove workspace.   
- When you come online, the file starts to transmit but consumes all application resources. This causes SharePoint Workspace to stop responding.   
- You shut down SharePoint Workspace by using Task Manager to end the Groove.exe process.    
- When you restart SharePoint Workspace, the application stops responding before you can access the workspace.   

In this scenario, starting SharePoint Workspace in safe mode may help you resolve the issue. Because synchronization is disabled, resources are not consumed, and you can work within SharePoint Workspace to save other unsynchronized changes from the workspace to local files, delete the local copy of the workspace from the computer, and clear the communications queue.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
