---
title: Install Microsoft Dynamics CRM 2011 from the Splash Screen
description: This article provides a resolution for the problem that occurs when you try to install Microsoft Dynamics CRM from the Splash Screen with Internet Explorer 9.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "Microsoft CRM Splash Screen has stopped working" error occurs when trying to install Microsoft Dynamics CRM 2011 from the Splash Screen

This article helps you resolve the problem that occurs when you try to install Microsoft Dynamics CRM from the Splash Screen with Internet Explorer 9.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2709872

## Symptoms

When trying to install Microsoft Dynamics CRM from the Splash Screen with Internet Explorer 9, the following error occurs:

> Microsoft CRM Splash Screen has stopped working

## Cause

This issue has been recognized by Microsoft with the Splash Screen and Internet Explorer 9.

## Resolution

The current workaround to launch the Microsoft Dynamics CRM 2011 install is below:

1. Navigate to the location of the **serversetup.exe** in the install folder under `\server\amd64-folder`.
2. Temporarily uninstall Internet Explorer 9.
    1. Point to the **Start Menu** and click **Control Panel**.
    1. Click **Programs and Features**.
    1. Click **View Installed Updates**.
    1. Scroll down under Microsoft Windows and right-click on Windows Internet Explorer 9.
    1. Choose uninstall.
