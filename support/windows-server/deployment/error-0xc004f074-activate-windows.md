---
title: Error 0xC004F074 when you activate Windows
description: Helps fix the error 0xC004F074 that occurs when you activate Windows.
ms.date: 04/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:activation, csstroubleshoot
ms.technology: windows-server-deployment
---
# Error 0xC004F074 when you try to activate Windows

This article helps fix the error 0xC004F074 that occurs when you activate Windows.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 974998

When you try to activate Windows, you may get error 0xC004F074 and one of the following error messages:

- > 0xC004F074 with description "The Key Management Server (KMS) is unavailable" 
- > Error: 0xC004F074 The Software Licensing Service reported that the product could not be activated. No Key Management Service (KMS) could be contacted. Please see the Application Event Log for additional information. 

## The Key Management Server (KMS) is unavailable

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

This error can occur because one of the following reasons:

- A support version mismatch between the KMS client and the KMS host machine
- A time difference between the KMS client and KMS host machine

### Support version mismatch between KMS client and KMS host machine

Most commonly we are seeing this when the KMS host is running on Windows Server 2003 or Windows Server 2008 and the KMS client is Windows 7 or Windows Server 2008 R2. An update is needed for the KMS host running on Windows Server 2003 and an update is needed for the KMS host running on Windows Server 2008 to be able to activate KMS clients that are Windows 7 or Windows server 2008 R2.

If you are running Windows Server 2008 as your KMS host, you need this update hotfix [968912](https://support.microsoft.com/help/968912).

### Time difference between KMS client and KMS host machine

The error 0xC004F06C listed in the info section may occur if the difference between system time on the client computer and the system time on the KMS host is more than 4 hours. We recommend that you use a Network Time Protocol (NTP) time source or the Active Directory service to synchronize the time between computers. Time is coordinated between the KMS host and the client computer in Coordinated Universal Time (UTC).

Make sure that the system time on client and KMS host is the same. The time zone that is set on the client computer does not affect the activation, since that is based on UTC time. 

Run the `w32tm /resync` command to resync the time on the client.

## No Key Management Service (KMS) could be contacted

When you try to activate Windows by using the `Slmgr /ato` command, you receive error code 0xC004F074 with the following error message:

> Error: 0xC004F074 The Software Licensing Service reported that the product could not be activated. No Key Management Service (KMS) could be contacted. Please see the Application Event Log for additional information. 

This error occurs because one of the following reasons:

- The Software Protection Platform Service (sppsvc service)  on the KMS host has stopped running.
- There are networking issues between the KMS client and the KMS host server. For example, TCP 1688 traffic is blocked between the KMS client and the KMS host server.
- There is incorrect or old KMS host server record in Domain Name System (DNS).

### Sppsvc service on the KMS host has stopped running

Verify if the sppsvc service is running on the KMS server. If the service is stopped, then start the sppsvc service.

### Networking issues between the KMS client and the KMS host server

Open port 1688 between the KMS client and KMS host server, and use the `Test-NetConnection` PowerShell cmdlet to verify if the port is open between the client and server. Here's an example:

```PowerShell
Test-NetConnection -ComputerName <KMS Host Server> -Port 1688

ComputerName           : <KMS host server>
RemoteAddress          : <KMS host server IP address>
RemotePort             : 1688
InterfaceAlias         : Wi-Fi
SourceAddress          : <Client machine IP address>
PingSucceeded          : True
PingReplyDetails (RTT) : 0 ms
TcpTestSucceeded       : False
```

Review the `TcpTestSucceeded` output parameter. If it is `False`, that suggests the port 1688 is blocked between the KMS client and KMS server.

### Incorrect or old KMS host server record in DNS

Verify the KMS DNS record in the DNS which is pointing to an incorrect or old KMS server in the environment by using the following steps:
	
1. Open DNS management console.
2. Select the *_tcp* folder under your domain name folder, and search for *_VLMCS* SRV record.
3. Verify if the correct KMS host server name is present in the *_VLMCS* SRV record.
4. Verify if the host record of the KMS host server by going to the domain name folder and verify the Host A record. Change the IP address to point to the new KMS server host if it is incorrect.

## References

[Resolve Windows activation error codes](/windows-server/get-started/activation-error-codes)
