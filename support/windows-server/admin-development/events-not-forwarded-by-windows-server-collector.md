---
title: Event collector doesn't forward events
description: Describes an issue that occurs when you use source-initiated event forwarding to send events to a Windows Server event collector.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-remote-management-winrm, csstroubleshoot
ms.subservice: admin-mgmt-development
---
# Events are not forwarded if the collector is running Windows Server

This article helps fix an issue that occurs when you use source-initiated event forwarding to send events to a Microsoft Windows Server event collector.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4494462

## Symptoms

You configure a Windows Server 2019 or Windows Server 2016 computer as an event collector. You also configure a source-initiated subscription (and related Group Policy Objects) for event forwarding. However, the events are not forwarded and the event source computers log event messages that resemble the following:

```output
Log Name: Microsoft-Windows-Forwarding/Operational
Event ID: 105
Task Category: None
User: NETWORK SERVICE
Description:
The forwarder is having a problem communicating with subscription manager at address http://W19SRV.contoso.com:5985/wsman/SubscriptionManager/WEC. Error code is 2150859027 and Error Message is The WinRM client sent a request to an HTTP server and got a response saying the requested HTTP URL was not available. This is usually returned by a HTTP server that does not support the WS-Management protocol. </f:Message></f:WSManFault>.
```

## Cause

This behavior is caused by the permissions that are configured for the following URLs:

- `http://+:5985/wsman/`
- `http://+:5986/wsman/`

On the event collector computer, both the Windows Event Collector service (WecSvc) and the Windows Remote Management service (WinRM) use these URLs. However, the default access control lists (ACLs) for these URLs allow access for only the svchost process that runs WinRM.
In the default configuration of Windows Server 2016, a single svchost process runs both WinRM and WecSvc. Because the process has access, both services function correctly. However, if you change the configuration so that the services run on separate host processes, WecSvc no longer has access and event forwarding no longer functions.

The services function differently in Windows Server 2019. If a Windows Server 2019 computer has more than 3.5 GB of RAM, separate svchost processes run WinRM and WecSvc. Because of this change, event forwarding may not function correctly in the default configuration. For more information about the service changes, see [Changes to Service Host grouping in Windows 10](/windows/application-management/svchost-service-refactoring).

## Resolution

To view the URL permissions, open an elevated Command Prompt window and run the command `netsh http show urlacl`.  

To fix the URL permissions, use the elevated Command Prompt window and run the following commands:

```cmd
netsh http delete urlacl url=http://+:5985/wsman/
netsh http add urlacl url=http://+:5985/wsman/ sddl=D:(A;;GX;;;S-1-5-80-569256582-2953403351-2909559716-1301513147-412116970)(A;;GX;;;S-1-5-80-4059739203-877974739-1245631912-527174227-2996563517)
netsh http delete urlacl url=https://+:5986/wsman/
netsh http add urlacl url=https://+:5986/wsman/ sddl=D:(A;;GX;;;S-1-5-80-569256582-2953403351-2909559716-1301513147-412116970)(A;;GX;;;S-1-5-80-4059739203-877974739-1245631912-527174227-2996563517)  
```

### Default URL permissions used by Windows Server 2019 and Windows Server 2016

> Reserved URL: `http://+:5985/wsman/`  
> User: NT SERVICE\WinRM  
> Listen: Yes  
‎Delegate: No  
SDDL: D:(A;;GX;;;S-1-5-80-569256582-2953403351-2909559716-1301513147-412116970)
>
> Reserved URL: `https://+:5986/wsman/`  
> User: NT SERVICE\WinRM  
> Listen: Yes  
> Delegate: No SDDL: D:(A;;GX;;;S-1-5-80-569256582-2953403351-2909559716-1301513147-412116970)

### Default URL permissions used by Windows Server 2012 R2

> Reserved URL: `http://+:5985/wsman/`  
‎User: NT SERVICE\WinRM  
‎Listen: Yes  
‎Delegate: No  
User: NT SERVICE\Wecsvc  
‎Listen: Yes  
Delegate: No  
SDDL: D:(A;;GX;;;S-1-5-80-569256582-2953403351-2909559716-1301513147-412116970)(A;;GX;;;S-1-5-80-4059739203-877974739-1245631912-527174227-2996563517)  
>
> Reserved URL: `https://+:5986/wsman/`  
User: NT SERVICE\WinRM  
Listen: Yes  
Delegate: No  
User: NT SERVICE\Wecsvc  
Listen: Yes  
Delegate: No  
SDDL: D:(A;;GX;;;S-1-5-80-569256582-2953403351-2909559716-1301513147-412116970)(A;;GX;;;S-1-5-80-4059739203-877974739-1245631912-527174227-2996563517)
