---
title: Cache trimming occurs in an ASP.NET web application
description: This article provides resolutions for the problem of cache trimming in an ASP.NET web application running in IIS.
ms.date: 12/11/2020
ms.custom: sap:General Development
---
# Cache trimming occurs in an ASP.NET web application running in IIS

This article helps you resolve the problem of cache trimming in an ASP.NET web application running in Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2537528

## Symptom

Consider the following scenario:

- You have an ASP.NET 4.0 web application running on a 64-bit version of Microsoft Windows.
- The web application is hosted in an IIS worker process that is configured to run in 32-bit mode.
- The application pool is configured with a Private Bytes recycle limit of 0 (unlimited).

In this scenario, you may see lots of caches trims occurring when the work process' private bytes usage reaches approximately 740 megabytes (MB). To alleviate the problem, you have to restart the application pool or unload the application domain.

## Status

Microsoft has confirmed that this is a bug in the product(s).

## Resolution

To work around this problem, configure the application pool's Private Bytes memory limit to be 4 GB. A value of 4 GB is effectively the same as the default value of 0 (unlimited) for the 32-bit application pool process running on the 64-bit operating system (wow64).

## More information

For more information on configuring application pool recycling for private bytes usage in IIS, see [Configure an Application Pool to Recycle after Reaching Maximum Used Memory (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc725749(v=ws.10)).
