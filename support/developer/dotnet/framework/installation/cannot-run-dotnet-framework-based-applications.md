---
title: Can't run .NET Framework based applications
description: This article provides a workaround for the problem where you cannot run .NET Framework 4.5.1-based applications after you install the .NET Framework 4.5.1 on Windows 8 or Windows Server 2012.
ms.date: 10/27/2020
ms.custom: sap:installation
---
# Can't run .NET Framework 4.5.1-based applications after you install the .NET Framework 4.5.1 on Windows 8 or Windows Server 2012

This article helps you resolve the problem where you cannot run .NET Framework 4.5.1-based applications after you install the .NET Framework 4.5.1 on Windows 8 or Windows Server 2012.

_Original product version:_ &nbsp; .NET Framework 4.5.1, Windows 8, Windows Server 2012  
_Original KB number:_ &nbsp; 2867719

## Symptoms

Assume that you install the Microsoft .NET Framework 4.5.1 on Windows 8 or Windows Server 2012. When you try to run an application that depends on the .NET Framework 4.5.1, you may receive the following message:

> This application requires one of the following versions of the .NET Framework:  
.NETFramework, Version=v4.5.1  
Do you want to install this .NET Framework version now?

> [!NOTE]
> Installing the .NET Framework 4.5.1 on Windows 8 or Windows Server 2012 may require the computer to be restarted. This issue may occur if the computer is not restarted, or if a problem occurs when you complete the installation after the computer is restarted.

## Cause

This issue occurs because the installation of the .NET Framework 4.5.1 was not completed successfully.

## Workaround

To work around this issue, reinstall the .NET Framework 4.5.1.
