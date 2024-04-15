---
title: Communication issues when RD Connection Broker connects to SQL Server
description: Fixes an issue in which Remote Desktop Connection Broker does not work correctly in Windows Server 2012 R2.
ms.date: 03/08/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, robertvi
ms.custom: sap:Remote Desktop Services and Terminal Services\Connection Broker and load balancing, csstroubleshoot
---
# Communication issues occur when Remote Desktop Connection Broker connects to SQL Server in Windows Server 2012 R2

This article provides a solution to an issue in which Remote Desktop Connection Broker does not work correctly in Windows Server 2012 R2.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3020474

## Symptoms

This issue occurs when you use a Security Compliance Manager or Security Configuration Wizard tool to harden on a Windows Server 2012 R2-based server. Additionally, you may receive the following error message:

> Information **\<date & time>** Microsoft Windows security auditing. 5157 Filtering Platform Connection
>
> The Windows Filtering Platform has blocked a connection.
>
> Application Information:  
Process ID: **\<PID>**  
Application Name: \device\harddiskvolume2\windows\system32\tssdis.exe
>
> Network Information:  
Direction: Outbound  
Source Address: **\<some IP>**  
Source Port: **\<some port>**  
Destination Address: **\<some IP>**  
Destination Port: 1434  
Protocol: 17

To check for Event 5157 in the Security event logs, you may have to enable auditing for Windows Filtering Platform (WFP). To check the current auditing status and to set the correct auditing for Object Access, use the following commands:

```console
auditpol /get /subcategory:"Filtering Platform Connection"

auditpol /set /subcategory:"Filtering Platform Connection" /success:enable /failure:enable  
```

If you use a netsh wfp show filters command to inspect WFP filters, the Filter.xml file shows the following active filter:

\<name>WSH Default Outbound Block\</name>  
\<description>Blocks all outbound traffic for services who have been network hardened\</description>

## Cause

The Remote Desktop Connection Broker (RD Connection Broker) has to enable the UDP port 1434 to connect to the SQL Server. However, the UDP port 1434 is also required for SQL instance searches. Therefore, the UDP port 1434 is not automatically enabled.

## Resolution

To resolve this issue, add a WFP rule to enable the RD Connection Broker service to use UDP port 1434.
