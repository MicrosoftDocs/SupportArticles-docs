---
title: Management Reporter 2012 Process Service will not stay running
description: Describes a problem where the Management Reporter 2012 Process Service will stop and restart continually. Provides a resolution.
ms.reviewer: theley, gbyer, jopankow
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Management Reporter 2012 Process Service will not stay running

This article provides a resolution for the issue that Management Reporter 2012 Process Service stops and restarts continually.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics AX 2009, Microsoft Dynamics SL 2015, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 3144801

## Symptoms

After you install Management Reporter 2012, the Process Service will stop and restart continually. It will not stay running for more than a few seconds. You may see the following error in the Event Viewer:

> Log Name: Application  
Source: .NET Runtime  
Event ID: 1026  
Task Category: None  
Level: Error  
Keywords: Classic  
Description:  
Application: MRServiceHost.exe  
Framework Version: v4.0.30319  
Description: The process was terminated due to an unhandled exception.  
Exception Info: System.TypeInitializationException

## Cause

This is a known issue that will happen if the 32-bit SP3 (11.3.xxxx.x) version of Microsoft System CLR Types for SQL Server 2012 is installed without the 64-bit SP3 (11.3.xxxx.x) version.

## Resolution

You will need to install the 64-bit SP3 version of Microsoft System CLR Types for SQL Server 2012. The 64-bit version will work together with the 32-bit version. If you are not certain which one is installed, 32-bit version is named "Microsoft System CLR Types for SQL Server 2012", and the 64-bit version is named *Microsoft System CLR Types for SQL Server 2012 (x64)*.

The file name is "ENU\x64\SQLSysClrTypes.msi". The 32-bit version has a similar name, so be sure that you are using the file in the x64 folder.

## More information

If the correct versions of Microsoft System CLR Types are installed and the Process Service continues to restart, see [The Management Reporter 2012 Process Service stops unexpectedly](https://support.microsoft.com/topic/the-management-reporter-2012-process-service-stops-unexpectedly-c00401b9-98cb-5bdc-aede-b39238b20e46) for additional troubleshooting steps.
