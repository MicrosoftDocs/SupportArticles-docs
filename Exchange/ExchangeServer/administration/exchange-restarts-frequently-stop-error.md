---
title: Exchange restarts with Stop Error
description: Exchange Server restarts frequently and you receive a Stop error. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Exchange Service or Server Crashed/Stopped, Cluster service issues
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Responder ServiceHealthMSExchangeReplForceReboot causes Exchange Server to restart with Stop Error

_Original KB number:_ &nbsp; 2969070

## Symptoms

Exchange Server 2016 or Exchange Server 2013 restarts frequently and displays the following Stop error on a blue screen.

> bugcheck  
Bugcheck code 000000EF  
Arguments fffffa80`1a5f9980 00000000`00000000 00000000`00000000 00000000`00000000

The restarts are initiated by the Managed Availability responder `ServiceHealthMSExchangeReplForceReboot`.

The recovery action event is observed in RecoveryActionResults:

> Log Name: Microsoft-Exchange-ManagedAvailability/RecoveryActionResults  
Source: Microsoft-Exchange-ManagedAvailability  
Date: DateTime  
Event ID: 500  
Task Category: Recovery  
Level: Information  
Keywords:  
User: SYSTEM  
Computer: `Exch1.contoso.com`  
Description:  
Recovery Action Started. (ActionId=ForceReboot, ResourceName=Exch1, Requester=ServiceHealthMSExchangeReplForceReboot, InstanceId=140428.105409.22538.004, ExpectedToFinishAt=2014-04-29T04:59:09.2253815Z

And associated Probe failure message:

> Log Name: Microsoft-Exchange-ActiveMonitoring/ProbeResult  
Source: Microsoft-Exchange-ActiveMonitoring  
Date: DateTime  
Event ID: 2  
Task Category: Probe result  
Level: Error  
Keywords:  
User: SYSTEM  
Computer: `Exch1.contoso.com`  
Description:  
Probe result (Name=ServiceHealthMSExchangeReplEndpointProbe/TCP/MSExchangeRepl)  
\<Error>Check 'Microsoft.Exchange.Monitoring.TcpListenerCheck' thrown an Exception!
Exception - Microsoft.Exchange.Monitoring.ReplicationCheckHighPriorityFailedException: High priority check TcpListener failed. Error: The health test of the TCP listener for the Microsoft Exchange Replication service on server 'Exch1' failed. This server cannot participate in replication until the error is resolved. Error: Couldn't determine the IP address for server 'Exch1' because DNS didn't return any information.  
at Microsoft.Exchange.Monitoring.ReplicationCheck.FailInternal()  
at Microsoft.Exchange.Monitoring.ReplicationCheck.Fail(LocalizedString error)  
at Microsoft.Exchange.Monitoring.TcpListenerCheck.InternalRun()  
at Microsoft.Exchange.Monitoring.ReplicationCheck.Run()  
at Microsoft.Exchange.Monitoring.ActiveMonitoring.HighAvailability.Probes.ReplicationHealthChecksProbeBase.RunReplicationCheck(Type checkType)  
Check 'Microsoft.Exchange.Monitoring.TcpListenerCheck' did not Pass!  
Detail Message - The health test of the TCP listener for the Microsoft Exchange Replication service on server 'Exch1' failed. This server cannot participate in replication until the error is resolved. Error: Couldn't determine the IP address for server 'Exch1' because DNS didn't return any information.  
\</Error>

## Cause

Misconfigured network adapter on Exchange Server causes failure in Domain Name System (DNS) name resolution.

## Resolution

Make sure that the **Register this connection's addresses in DNS** property is selected on the network adapter:

:::image type="content" source="media/exchange-restarts-frequently-stop-error/register-this-connection-s-addresses-in-dns.png" alt-text="Screenshot shows that Register this connection's addresses in DNS property is selected.":::

> [!NOTE]
> For Exchange server that is a member of DAG and has separate MAPI and Replication network adapters, make sure that this property is selected on the network adapter that represents the MAPI network.

Review the guidelines provided in the following article and make sure that the network adapter that represents the MAPI and Replication networks are configured accordingly.

[Planning for high availability and site resilience](/exchange/planning-for-high-availability-and-site-resilience-exchange-2013-help)

## More information

Use the following PowerShell command on the affected Exchange server to ensure the server restarts are indeed caused by the `ServiceHealthMSExchangeReplForceReboot` responder.

```powershell
Get-WinEvent -LogName Microsoft-Exchange-ManagedAvailability/* | where {$_.Message -like "*ServiceHealthMSExchangeReplForceReboot*"} | ft Message,TimeCreated
```

Or, you can search the crimson channel log named *Recovery Action Logs* and *Remote Action Logs* for word *ForceReboot* to find the responder that causes the restart.
