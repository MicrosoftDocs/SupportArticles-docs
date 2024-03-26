---
title: Desktop Setup Tool cannot download updates
description: Describes an issue in which Office Desktop Setup can't download and install updates from Microsoft Update in a Microsoft 365 environment. Provides a resolution.
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
  - Microsoft 365 User and Domain Management
ms.date: 03/31/2022
---

# Microsoft 365 Desktop Setup Tool cannot download updates or you receive an "Your computer is not allowed to connect to the Microsoft Update service" error message

## Problem 

The Microsoft 365 Desktop Setup Tool can't download and install software updates from Windows Update or from Microsoft Update in a Microsoft 365 environment. You may also get the following error message:

> Your computer is not allowed to connect to the Microsoft Update service.

You may experience these symptoms even though the computer is set up to automatically receive Windows updates.

## Solution 

To fix this issue, use one or more of the following methods.

### Method 1: Verifythe Group Policy setting

Make sure that the computer can access Windows Update or Microsoft Update. 

1. Enable Windows Update and Automatic Updates. To do this, follow these steps:
   1. Open the Group Policy MMC snap-in, expand Computer Configuration, expand Administrative Templates, expand System, expand Internet Communication Management, and then click the Internet Communication node.   
   2. In the details pane, double-click Turn off access to all Windows Update features, click Disabled, and then click OK.   
   
2. Enable Windows Update and Automatic Updates by allowing access to Windows Update commands. To do this, follow these steps:
   1. Open the Group Policy snap-in, expand User Configuration, expand Administrative Templates, and then click the Start Menu and Taskbar node.   
   2. In the details pane, double-click Remove links and access to Windows Update, click Disabled, and then click OK.   
   
### Method 2: Make sure that you can connect to Windows Update

Make sure that you can access other websites. If you can't access other websites, your Internet connection may not be working correctly. Contact your Internet service provider for help.


In some cases, you may have to go the Microsoft Update website, and then manually install the Windows Update components.
This issue typically occurs when access to Windows Update or to Microsoft Update is blocked. The Microsoft 365 Desktop Setup Tool uses Windows Update to install software updates that are required to connect to Microsoft 365. If access to Windows Update is blocked, the Microsoft 365 Desktop Setup Tool can't install the required updates. 

In this scenario, Group Policy or other security configurations may block access to Windows Update or to Microsoft Update. This issue may also occur when a Windows Update component must be installed on the computer before the updates can be completed. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).