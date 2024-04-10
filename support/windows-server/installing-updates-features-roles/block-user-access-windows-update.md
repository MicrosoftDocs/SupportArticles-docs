---
title: How to block user access to Windows Update on Windows Server 2016
description: Describes how administrators can block user access to WU settings on Windows Server 2016.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
---
# How to block user access to Windows Update on Windows Server

This article describes how to block user access to Windows Update on Windows Server.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4014345

## Symptoms

The default settings in Windows Server allow user who is not an administrator to scan for and apply Windows Updates. Administrators may want to change this setting to limit access to Windows Updates, especially in Remote Desktop Services Host deployments.

## More Information

To change this setting, use the Group Policy "Remove access to use all Windows update features." The full path to this Group Policy is:  
Computer Configuration\\Administrative Templates\\Windows Components\\Windows update\\Remove access to use all Windows update features

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
