---
title: Event ID 17018 when Microsoft Exchange Transport service stops
description: Fixes an issue in which the Microsoft Exchange Transport service stops on an Exchange-based server that has a high CPU core count and a high transport load.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 158355
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: nasira, lusassl, paulkwo, meerak, v-chazhang
appliesto:
- Exchange Server 2019
search.appverid: MET150
---
# Microsoft Exchange Transport service stops and returns Event ID 17018

## Symptoms

On a server that's running Microsoft Exchange Server and that has a high CPU core count and a high transport load, the Microsoft Exchange Transport service continually stops and restarts. Additionally, the following event is logged in the Application log:

> Source: MSExchangeTransport  
> Event ID: 17018  
> Transport Mail Database: There are insufficient resources to perform a database operation. The Microsoft Exchange Transport service is shutting down.  
> Exception details: Microsoft.Isam.Esent.Interop.**EsentOutOfSessionsException: Out of sessions**
at Microsoft.Isam.Esent.Interop.Api.JetBeginSession(JET_INSTANCE instance, JET_SESID& sesid, String username, String password)
at Microsoft.Exchange.Transport.Storage.DataConnection..ctor(JET_INSTANCE instance, IDataSource source)

## Cause

This issue occurs because a high number of server-to-server connections can exhaust the session limit too quickly.

## Resolution

> [!NOTE]  
> This fix applies to only Microsoft Exchange Server 2019. 

To fix this issue, follow these steps:

1. Install the following security update:

   [Description of the security update for Microsoft Exchange Server 2019, 2016, and 2013: February 14, 2023 (KB5023038)](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-february-14-2023-kb5023038-2e60d338-dda3-46ed-aed1-4a8bbee87d23)

1. Decrease the `MaxInboundConnection` limit on the Receive connectors of each Exchange server, as follows.

    > [!NOTE]  
    > To prevent limiting the number of connections from busy sources, such as email gateways, you might have to increase the `MaxInboundConnectionPercentagePerSource` parameter from the default value of **2**. We recommend that you also closely monitor the incoming mail flow and gradually increase the value, as necessary.

    1. To check the current value of the `MaxInboundConnection` parameter, run the [Get-ReceiveConnector](/powershell/module/exchange/get-receiveconnector) cmdlet:

       ```powershell
       Get-ReceiveConnector -Server <Server Name> | Format-Table Identity,MaxInboundConnection -Auto
       ```

       **Note:** The default value for this limit is 5,000 concurrent connections.

    1. To set the limit to a value of 1,000 concurrent connections, run the following cmdlets:

       ```powershell
       Get-ReceiveConnector -Server <Server Name> | Set-ReceiveConnector -MaxInboundConnection 1000
       ```

    1. To set each Receive connector limit individually, run the [Set-ReceiveConnector](/powershell/module/exchange/set-receiveconnector) cmdlet:

       ```powershell
       Set-ReceiveConnector -Identity "<Receive Connector Identity>" -MaxInboundConnection 1000
       ```

    1. Restart the Transport service.

1. Override the server-to-server throttle. To set and refresh the override, run the **New-SettingOverride** and **Get-ExchangeDiagnosticInfo** cmdlets in Exchange Management Shell:

   ```powershell
   New-SettingOverride -Name "Throttle server to server inbound calls" -Component TransportConfiguration -Section ThrottleServerToServerInboundConnections -Parameters ("Enabled=True") -Reason "Any Text String " 

   Get-ExchangeDiagnosticInfo -Process Microsoft.Exchange.Directory.TopologyService -Component VariantConfiguration -Argument Refresh
   ```

1. Restart the Transport service.
