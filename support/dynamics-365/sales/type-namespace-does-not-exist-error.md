---
title: Type or namespace doesn't exist error
description: Provides a solution to an error that occurs when a Microsoft Dynamics CRM organization is created by using the name Portal.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Type or namespace does not exist error received when accessing a Microsoft Dynamics CRM organization

This article provides a solution to an error that occurs when a Microsoft Dynamics CRM organization is created by using the name Portal.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2013 Service Pack 1  
_Original KB number:_ &nbsp; 3084967

## Symptoms

Consider the following scenario; A Microsoft Dynamics CRM organization is created using the name Portal. After creating the organization, a generic error message may be received when attempting to access the organization (URL: `https://crmwebsite.contoso.local/Portal`):

> An Error Has Occurred  
Try this action again. If the problem continues, check the Microsoft Dynamics CRM Community for solutions or contact your organizations Microsoft CRM administrator. finally you could contact Microsoft Support

Additionally, the following event may be reported in the Event Viewer Application log on the Microsoft Dynamics CRM Server:

> Event ID: 1310  
Event Source: ASP.NET 4.0.30319.0  
Event code: 3007  
Event message: A compilation error has occurred.  
Exception information:  
Exception type: HttpCompileException  
>
> Exception message: `C:\Windows\Microsoft.NET\Framework65\v4.0.30319\Config\web.config(393)`: error CS0234: The type or namespace name 'Linq' does not exist in the namespace 'System' (are you missing an assembly reference?)

## Cause

The name of the Microsoft Dynamics CRM organization matches a defined **Location Path** in the web.config of the website in IIS.

## Resolution

Create the Microsoft Dynamics CRM organization with a different name.

## More information

By default, the web.config for the Microsoft Dynamics CRM website contains several location paths. Each of these location paths is considered a reserved keyword and shouldn't be used as a stand-alone name for the Microsoft Dynamics CRM organization. Some of these names include:

- Portal
- Platform
- Support
