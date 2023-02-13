---
title: Event ID 17018 when Microsoft Exchange Transport service stops
description: Fixes an issue in which the Microsoft Exchange Transport service stops on an Exchange server that has a high CPU core count and a high transport load.
ms.date: 07/13/2022
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
- CI 158355
- Exchange Server
- CSSTroubleshoot
ms.reviewer: nasira; lusassl; paulkwo; meerak
appliesto:
- Exchange Server 2016
- Exchange Server 2019
search.appverid: MET150
---
# Microsoft Exchange Transport service stops with event ID 17018

## Symptoms

On a server that's running Microsoft Exchange Server and that has a high CPU core count and a high transport load, the Microsoft Exchange Transport service continually stops and restarts. Additionally, the following event is logged in the Application log:

> Source: MSExchangeTransport  
> Event ID: 17018  
> Transport Mail Database: There are insufficient resources to perform a database operation. The Microsoft Exchange Transport service is shutting down.  
> Exception details: Microsoft.Isam.Esent.Interop.**EsentOutOfSessionsException: Out of sessions**
at Microsoft.Isam.Esent.Interop.Api.JetBeginSession(JET_INSTANCE instance, JET_SESID& sesid, String username, String password)
at Microsoft.Exchange.Transport.Storage.DataConnection..ctor(JET_INSTANCE instance, IDataSource source)

## Cause

This issue occurs because a high number of incoming connections can exhaust the session limit too quickly.

## Resolution

To fix this issue, decrease the `MaxInboundConnection` limit on the Receive connectors of each Exchange server as follows.

> [!NOTE]
> You may have to increase the `MaxInboundConnectionPercentagePerSource` parameter from the default value of **2** to prevent limiting connections from busy sources such as email gateways. We recommend that you also closely monitor the incoming mail flow and gradually increase the value as necessary.

1. Run the [Get-ReceiveConnector](/powershell/module/exchange/get-receiveconnector) cmdlet to check the current value of the `MaxInboundConnection` parameter.

    ```powershell
    Get-ReceiveConnector -Server <Server Name> | Format-Table Identity,MaxInboundConnection -Auto
    ```

    > [!NOTE]
    > The default value for this limit is 5,000 concurrent connections.

1. Run the following cmdlet to set the limit to a value of 1,000 concurrent connections.

    ```powershell
    Get-ReceiveConnector -Server <Server Name> | Set-ReceiveConnector -MaxInboundConnection 1000
    ```

    Run the [Set-ReceiveConnector](/powershell/module/exchange/set-receiveconnector) cmdlet to set each Receive connector limit individually:

    ```powershell
    Set-ReceiveConnector -Identity "<Receive Connector Identity>" -MaxInboundConnection 1000
    ```

1. Restart the Microsoft Exchange Transport service.
