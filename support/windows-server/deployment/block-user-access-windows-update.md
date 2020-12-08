---
title: How to block user access to Windows Update on Windows Server 2016
description: Describes how administrators can block user access to WU settings on Windows Server 2016.
ms.date: 12/04/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# How to block user access to Windows Update on Windows Server

_Original product version:_ &nbsp; Windows Server version 1803, Windows Server version 1709, Windows Server version 1803, Windows Server 2016  
_Original KB number:_ &nbsp; 4014345

## Symptoms

The default settings in Windows Server allow user who are not an administrator to scan for and apply Windows Updates. Administrators may want to change this setting to limit access to Windows Updates, especially in Remote Desktop Services Host deployments.

## More Information

To change this setting, use the Group Policy "Remove access to use all Windows update features." The full path to this Group Policy is:
Computer Configuration\Administrative Templates\Windows Components\Windows update\Remove access to use all Windows update features
