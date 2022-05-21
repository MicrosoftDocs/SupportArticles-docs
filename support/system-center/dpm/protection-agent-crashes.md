---
title: DPM protection agent crashes
description: Describes an issue that causes the DPM protection agent in System Center 2012 Data Protection Manager to return errors when you run it.
ms.date: 07/23/2020
---
# Error ID 43 or 60 when you use System Center 2012 Data Protection Manager

This article helps you fix an issue where error 43 or 60 occurs when you try to protect a server by using System Center 2012 Data Protection Manager (DPM).

_Original product version:_ &nbsp; System Center 2012 Data Protection Manager, System Center 2012 R2 Data Protection Manager  
_Original KB number:_ &nbsp; 3082409

## Summary

When you try to protect a server by using System Center 2012 Data Protection Manager, you may receive one or both of the following error messages:

> DPM failed to communicate with the protection agent on <*ServerName*> because the agent is not responding. (ID 43 Details: Internal error code: 0x8099090E)
>
> The protection agent on DPM.contoso.com was temporarily unable to respond because it was in an unexpected state. (ID 60 Details: Internal error code: 0x809909B0)

It typically means that the DPM protection agent (DPMRA.EXE) is crashing.

## Resolution

1. Check recent records from the DPM protection agent (DPMRA) source in the Application event log on <*ServerName*> to discover why the agent failed to respond.

1. Examine the DPMRA log file for any details about the cause of the crash. The DPMRA log file will be in the format of DPMRA\*.errlog (for example, DPMRACURR.ERRLOG) and by default is located in `\Program Files\Microsoft Data Protection Manager\DPM\Temp`.

1. Make sure that the DPM server is remotely accessible from <*ServerName*>. If a firewall is enabled on the DPM server, make sure that it's not blocking requests from <*ServerName*>. For complete details about the necessary ports and recommended firewall configuration, see [Configure firewall settings for DPM](/previous-versions/system-center/system-center-2012-R2/hh757794(v=sc.12))

1. Restart the DPMRA on <*ServerName*>. If the service doesn't start, reinstall the protection agent.
