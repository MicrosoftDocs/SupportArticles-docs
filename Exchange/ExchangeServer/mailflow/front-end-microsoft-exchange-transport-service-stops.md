---
title: Front-end Microsoft Exchange Transport service stops and doesn't start in Exchange
description: Describes an issue that occurs when an Exchange server has both back-end and front-end roles.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Not Able to Send or Receive Emails from Internet
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2016 Enterprise Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# The front-end Microsoft Exchange Transport service stops and doesn't restart in Exchange Server 2013 SP1 or Exchange Server 2016

_Original KB number:_ &nbsp;2958036

## Symptoms

Consider the following scenario:

- You upgrade to Microsoft Exchange Server 2013 Service Pack 1 (SP1) or upgrade an Exchange Server 2016 server.
- The Exchange server has both back-end and front-end roles.
- You run the front-end Microsoft Exchange Transport service on the server.

In this scenario, the service stops and doesn't restart. Additionally, the following events are logged in the Application log:

```console
Log Name: Application
Source: MSExchangeTransport
Event ID: 1019
Task Category: SmtpReceive
Level: Error
Computer: 2013 Server
Description: Failed to start listening (Error: 10048). Binding: 0.0.0.0:25.


Log Name: Application
Source: MSExchangeTransport
Event ID: 1018
Task Category: SmtpReceive
Level: Error
Computer: 2013 Server
Description: The address is already in use. Binding: 0.0.0.0:25.


Log Name: Application
Source: MSExchangeTransport
Event ID: 1036
Task Category: SmtpReceive
Level: Error
Computer: 2013 Server
Description: Inbound direct trust authentication failed for certificate %1. The source IP address of the server that tried to authenticate to Microsoft Exchange is [%2]. Make sure EdgeSync is running properly.


Log Name: Application
Source: MSExchange Common
Event ID: 4999
Task Category: General
Level: Error
Computer: 2013 Server
Description: Watson report about to be sent for process id: 19848, with parameters: E12IIS, c-RTL-AMD64, 15.00.0847.032, MSExchangeTransport, M.Exchange.Net, M.E.P.WorkerProcessManager.HandleWorkerExited, M.E.ProcessManager.WorkerProcessRequestedAbnormalTerminationException, 5e2b, 15.00.0847.030. ErrorReportingEnabled: False


Log Name: Application
Source: MSExchange TransportService
Event ID: 1046
Task Category: ProcessManager
Level: Warning
Computer: 2013 Server
Description: Worker process with process ID 18420 requested the service to terminate with an unhandled exception.
```

> [!NOTE]
> If you stop the Microsoft Exchange Transport service, you can start the front-end Microsoft Exchange Transport service. Then, when you try to start the Microsoft Exchange Transport service, that service doesn't start, and the events that are mentioned earlier in this section are logged.

## Cause

This issue occurs if there's a receive connector having a Transport type of HubTransport that has the binding set to port 25 on the affected Exchange server. Only the FrontendTransport server-type receive connector should have the binding set to port 25.

## Resolution

### Method 1

Run the following command to change the connector type from HubTransport to FrontendTransport:

```powershell
Set-ReceiveConnector -Identity "Receive connector name" -TransportRole FrontendTransport  
```

### Method 2

Delete and re-create the receive connector, and then set its role to **FrontendTransport**.
