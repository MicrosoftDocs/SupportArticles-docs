---
title: Unable to connect to SharePoint through integration
description: This article provides a resolution for the problem where you are unable to connect to SharePoint through integration within Microsoft Dynamics CRM 2011.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Unable to connect to SharePoint through integration within Microsoft Dynamics CRM 2011

This article helps you resolve the problem where you are unable to connect to SharePoint through integration within Microsoft Dynamics CRM 2011.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2712152

## Symptoms

Users are unable to connect to SharePoint through integration within Microsoft Dynamics CRM 2011.

## Cause

Microsoft Dynamics CRM uses .NET Framework 4, which SharePoint 2010 does not support access to is not able to run in a .NET Framework 4 app domain. All server-side customizations directly for SharePoint 2010 need to be either .NET Framework 3.5 or the .NET Framework 3.5 SP1.

## Resolution

If .NET Framework 4 is needed, it is recommended that a web service is developed that uses .NET Framework 4 and then connect to it from SharePoint

## More information

Currently all server-side customizations directly for SharePoint 2010 must use either .NET Framework 3.5 or .NET Framework 3.5 SP1.
