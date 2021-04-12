---
title: Error 0xC004F074 when you activate Windows
description: Helps fix the error 0xC004F074 that occurs when you activate Windows.
ms.date: 10/22/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Activation
ms.technology: windows-server-deployment
---
# You get error 0xC004F074 when you try to activate Windows: The Key Management Server (KMS) is unavailable

This article helps fix the error 0xC004F074 that occurs when you activate Windows.

_Original product version:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 974998

## Symptom

When trying to activate Windows 7 or Microsoft Windows Server 2008 R2 KMS client machines, you may get this error message:

> 0xC004F074 with description "The Key Management Server (KMS) is unavailable"

At the same time, the following entries may get logged in the KMS Event Log on KMS Client and KMS Host

In the application event log on KMS Client, you see the following event:

```output
Log Name: Application  
Source: Microsoft-Windows-Security-SPP  
Date:  

Event ID: 12288  
Task Category: None  
Level: Information  
Keywords: Classic  
User: N/A  
Computer:  

Description:  
The client has sent an activation request to the key management service machine.  
Info:  
0xC004F06C, 0x00000000, <KMS Host FQDN>:1688, 36f27b39-2fd5-440b-be67-a09996d27a38, 2010/09/29 17:52, 0, 2, 41760, 68531fb9-5511-4989-97be-d11a0f55633f, 5
```

In the application event log on KMS Host, you see the following event:

```output
Log Name: Key Management Service  
Source: Microsoft-Windows-Security-Licensing-SLC  
Date:  

Event ID: 12290  
Task Category: None  
Level: Information  
Keywords: Classic  
User: N/A  
Computer:  
Description:  
An activation request has been processed.  
Info:  
0xC004F06C,5,<KMS Client name>,36f27b39-2fd5-440b-be67-a09996d27a38,2010/9/29 21:46,0,2,41520,68531fb9-5511-4989-97be-d11a0f55633f
```

## Cause

This error can occur with a support version mismatch between the KMS client and the KMS host machine.

Most commonly we are seeing this when the KMS host is running on Windows Server 2003 or Windows Server 2008 and the KMS client is Windows 7 or Windows Server 2008 R2. An update is needed for the KMS host running on Windows Server 2003 and an update is needed for the KMS host running on Windows Server 2008 to be able to activate KMS clients that are Windows 7 or Windows server 2008 R2.

This error also can occur when there may be a time difference between the KMS client and KMS host machine.

The error 0xC004F06C listed in the info section may occur if the difference between system time on the client computer and the system time on the KMS host is more than 4 hours. We recommend that you use a Network Time Protocol (NTP) time source or the Active Directory service to synchronize the time between computers. Time is coordinated between the KMS host and the client computer in Coordinated Universal Time (UTC).

## Resolution

If you are running Windows Server 2008 as your KMS host, you need this update hotfix [968912](https://support.microsoft.com/help/968912).

Make sure that the system time on client and KMS host is the same.

The time zone that is set on the client computer does not affect Activation, since that is based on UTC time. 

Run the `w32tm /resync` command to resync the time on the client.

## References

[Resolve Windows activation error codes](/windows-server/get-started/activation-error-codes)
