---
title: Event ID 17018 when Microsoft Exchange Transport service stops
description: Fixes an issue in which the Microsoft Exchange Transport service stops on an Exchange-based server that has a high CPU core count and a high transport load.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Not Able to Send or Receive Emails from Internet
  - CI 158355
  - CI 9823
  - CI 11514S
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: nasira, lusassl, paulkwo, meerak, v-chazhang, v-kccross
appliesto:
- Exchange Server SE
- Exchange Server 2019
search.appverid: MET150
ms.date: 05/12/2026
---

# Microsoft Exchange Transport service stops and returns Event ID 17018

## Summary

The Microsoft Exchange Transport service can repeatedly stop and restart on servers that have a high number of CPU cores and handle heavy mail flow. This issue occurs when the system exhausts the available database sessions due to too many simultaneous server-to-server connections. As a result, Event ID 17018 is logged, indicating insufficient resources and an `EsentOutOfSessionsException`.
To resolve the issue, reduce the number of concurrent inbound connections on Receive connectors and optionally adjust connection limits per source. You can also override server-to-server throttling settings. After you apply these changes, restart the Transport service to restore normal operation.

## Symptoms

On a computer running Microsoft Exchange Server that has a high CPU core count and a high transport load, the Microsoft Exchange Transport service continually stops and restarts. Additionally, the following event is logged in the Application log:

> Source: MSExchangeTransport  
> Event ID: 17018  
> Transport Mail Database: There are insufficient resources to perform a database operation. The Microsoft Exchange Transport service is shutting down.  
> Exception details: Microsoft.Isam.Esent.Interop.**EsentOutOfSessionsException: Out of sessions**
at Microsoft.Isam.Esent.Interop.Api.JetBeginSession(JET_INSTANCE instance, JET_SESID& sesid, String username, String password)
at Microsoft.Exchange.Transport.Storage.DataConnection..ctor(JET_INSTANCE instance, IDataSource source)

## Cause

This issue occurs because a high number of server-to-server connections can exhaust the session limit too quickly.

## Resolution

You resolve this issue in the Exchange Management Shell (EMS). For more information about the EMS, see [Connect to Exchange servers using remote PowerShell](/powershell/exchange/connect-to-exchange-servers-using-remote-powershell).

To resolve this issue, follow these steps:

1. Decrease the `MaxInboundConnection` limit on the Receive connectors of each Exchange server, as follows.

    > [!NOTE]  
    > To prevent limiting the number of connections from busy sources, such as email gateways, you might have to increase the `MaxInboundConnectionPercentagePerSource` parameter from the default value of **2**. We recommend that you also closely monitor the incoming mail flow and gradually increase the value, as necessary.

    1. To check the current value of the `MaxInboundConnection` parameter, run the [Get-ReceiveConnector](/powershell/module/exchange/get-receiveconnector) cmdlet:

       ```powershell
       Get-ReceiveConnector -Server <Server Name> | Format-Table Identity,MaxInboundConnection -Auto
       ```

       The default value for this limit is 5,000 concurrent connections.

    1. To set the limit to a value of 1,000 concurrent connections, run the following cmdlets:

       ```powershell
       Get-ReceiveConnector -Server <Server Name> | Set-ReceiveConnector -MaxInboundConnection 1000
       ```

    1. To set each Receive connector limit individually, run the [Set-ReceiveConnector](/powershell/module/exchange/set-receiveconnector) cmdlet:

       ```powershell
       Set-ReceiveConnector -Identity "<Receive Connector Identity>" -MaxInboundConnection 1000
       ```

    1. Restart the Transport service.

       ```powershell
       Restart-Service MSExchangeTransport
       ```

1. Override the server-to-server throttle. To set and refresh the override, run the [New-SettingOverride](/powershell/module/exchange/New-SettingOverride) and [Get-ExchangeDiagnosticInfo](/powershell/module/exchange/Get-ExchangeDiagnosticInfo) cmdlets in Exchange Management Shell:

   ```powershell
   New-SettingOverride -Name "Throttle server to server inbound calls" -Component TransportConfiguration -Section ThrottleServerToServerInboundConnections -Parameters ("Enabled=True") -Reason "Any Text String " 

   Get-ExchangeDiagnosticInfo -Process Microsoft.Exchange.Directory.TopologyService -Component VariantConfiguration -Argument Refresh
   ```

1. Restart the Transport service.

   ```powershell
   Restart-Service MSExchangeTransport
   ```
