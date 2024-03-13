---
title: Error when you attempt to start Integration Manager
description: This article provides a resolution for the problem that occurs when you attempt to start Integration Manager for Microsoft Dynamics GP 2010 on a Windows Server 2008 or Windows 7 machine.
ms.reviewer: grwill, dlanglie
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# You receive an error message (Access to the Path is Denied) when you start Integration Manager for Microsoft Dynamics GP 2010

This article helps you resolve a problem that occurs when you attempt to start Integration Manager for Microsoft Dynamics GP 2010 on a Windows Server 2008 or Windows 7 machine.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2254133

## Symptoms

You receive the error message:

> Could not create all default application data

due to the following error:

> Access to the path `C:\ProgramData\Microsoft\Microsoft Dynamics GP\11.0.0.0` is denied.

when you attempt to start Integration Manager for Microsoft Dynamics GP 2010 on a Windows Server 2008 or Windows 7 machine.

## Cause

This error occurs because the User Account Control (UAC) feature is turned on by default for Windows Server 2008 and Windows 7 machines. With UAC enabled, Integration Manager cannot create the directory structure and write the default configuration file because the ProgramData directory is protected by the UAC feature. This results in the error message above.

## Resolution

To resolve this problem, start Integration Manager by Right-Clicking on the Integration Manager shortcut and choose **Run as administrator**. This will start Integration Manager using the Administrator access token so the application will have sufficient rights to create the directory structure mentioned in the error message and write the default configuration file.

## More information

For more information on the User Account Control feature in Windows 7 and Windows Server 2008, see [User Account Control in Windows 7 Best Practices](/previous-versions/windows/it-pro/windows-7/ee679793(v=ws.10)).
