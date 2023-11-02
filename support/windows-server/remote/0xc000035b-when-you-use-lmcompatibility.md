---
title: 0xC000035B when you use LmCompatibility
description: Discusses that Terminal Services client connection error 0xC000035B is logged when you use LmCompatibility for a connection through a Windows Server 2012 RD Gateway server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, Randym
ms.custom: sap:authentication, csstroubleshoot
ms.technology: windows-server-rds
---
# Terminal Services client connection error 0xC000035B when you use LmCompatibility

This article provides a solution to an error 0xC000035B that occurs when a Terminal Services client connection that uses Remote Desktop Protocol (RDP) 8.0 to connect through a Windows Server 2012 RD Gateway server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2903333

## Symptoms

A Terminal Services client connection that uses Remote Desktop Protocol (RDP) 8.0 to connect through a Windows Server 2012 RD Gateway server fails and generates the following error message:

> This computer can't connect to the remote computer.

Additionally, Event 4625 is logged in the Security sign in the Gateway server, and reports a 0xC000035B error.

> Log Name: Security  
Source: Microsoft-Windows-Security-Auditing  
Date: *\<DateTime>*  
Event ID: 4625  
Task Category: Logon  
Level: Information  
Keywords: Audit Failure  
User: N/A  
Computer: RDGW.CONTOSO.COM  
Description:  
An account failed to log on.
>
> Subject:  
Security ID: NULL SID  
Account Name: -  
Account Domain: -  
Logon ID: 0x0  
Logon Type: 3  
Account For Which Logon Failed:  
Security ID: NULL SID  
Account Name: Myuser  
Account Domain: Contoso  
Failure Information:  
Failure Reason: An Error occured during Logon.  
Status: 0xC000035B  
Sub Status: 0x0

## Cause

This problem occurs when the **LmCompatibility** registry value is configured to force the system to use NTLMv1. An **LmCompatibility** value of fewer than 3 forces the system to use NTLMv1.

By default, Windows Server 2012 enforces channel bindings in RDP 8.0. Because these bindings aren't sent when NTLMv1 is used, the authentication fails and generates the 0xC000035B "Client's supplied Security Support Provider Interface (SSPI) channel bindings were incorrect" error message. It indicates that the channel bindings aren't valid.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk. Before you modify it, [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756) in case problems occur.

For information about how to edit the registry, see the "Changing Keys And Values" Help topic in Registry Editor.

To resolve this problem, use one of the following methods.

### Method 1

Adjust the **LmCompatibility** registry value on the client to not force NTLMv1 by setting it to a value of 3 or larger. For more information about the **LmCompatibility** registry value, see [LmCompatibilityLevel](/previous-versions/windows/it-pro/windows-2000-server/cc960646(v=technet.10)).

### Method 2

Set the **EnforceChannelBinding** registry value to 0 (zero) to ignore missing channel bindings on the Gateway server. To do it, locate the following registry subkey, and use the given specifications:

`HKLM\Software\Microsoft\Windows NT\CurrentVersion\TerminalServerGateway\Config\Core`  
Type: **REG_DWORD**  
Name: **EnforceChannelBinding**  
Value: **0 (Decimal)**

> [!NOTE]
> By default, the **EnforceChannelBinding** value doesn't exist on the Gateway server. You must create this value.
