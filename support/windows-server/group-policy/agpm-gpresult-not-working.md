---
title: AGPM and GPRESULT are not working
description: Describes scenarios in which AGPM and GPRESULT do not work on a Windows Server Core installation.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
ms.subservice: group-policy
---
# AGPM and GPRESULT not working in Windows Server Core

This article provides a solution to an error that occurs where AGPM and GPRESULT do not work on a Windows Server Core installation.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2987708

## Symptoms

### Microsoft Advanced Group Policy Management (AGPM) Scenario

Assume that AGPM Server is installed on a computer that is running Windows Server Core (Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2). AGPM is installed on a client computer that is running Windows Server or a Windows client operating system that has Remote Server Administration Tools installed. In this situation, the following error occurs whenever an administrator tries to take control of an unmanaged Group Policy Object (GPO):

> Control GPO: < **GPO Name** > ...Failed
>
> The overall error was: The data is invalid. (Exception from HRESULT: 0x8007000D)  
Additional details follow.  
[Error] Unable to cast object of type 'System.DBNull' to type 'Microsoft.Agpm.GroupPolicy.Interop.GPMBackup'

### GPRESULT Scenario

On a Windows Server Core computer, when an administrator runs the gpresult /h \<filename.htm> command to retrieve the GPO settings for this computer or user, GPRESULT returns the following error message:

> ERROR: The Parameter is incorrect.

## Cause

These issues occur because the AGPM Server component and the GPRESULT /h command require the Group Policy Management Console (GPMC) to be installed on the Local System. Several GPMC Interfaces will be installed on the system only when GPMC is installed.

[GPMC Interfaces](/previous-versions/windows/desktop/gpmc/gpmc-interfaces)

Because Windows Server Core doesn't have the GPMC Interfaces installed, applications that use this interface will fail.

## Resolution

Resolution for AGPM

Install the AGPM Server component on a Windows Server-based computer that has the GUI installed.

Resolution for GPRESULT

Run the GPRESULT report from a remote computer against the Windows Server Core computer.
