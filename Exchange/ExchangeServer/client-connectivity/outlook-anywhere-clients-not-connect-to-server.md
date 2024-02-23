---
title: Outlook Anywhere clients can't connect to server
description: Resolves an issue in which Outlook Anywhere clients receive a 503 error when they try to connect to the Exchange server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: davidsan, nasira, wduff, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Service Pack 3
ms.date: 01/24/2024
---
# Outlook Anywhere clients can't connect to an Exchange server after you install Exchange Server 2010 SP3

_Original KB number:_ &nbsp; 2832198

## Symptoms

Assume that you install Exchange 2010 SP3 in an Exchange Server environment. There are many Outlook Anywhere (RPC over HTTP) clients in the environment. When the Outlook Anywhere clients try to connect to the Exchange server, the Outlook Anywhere clients are not connected. Additionally, the Outlook Anywhere clients receive the following error message:

> 503 Service Unavailable

## Cause

This issue occurs because the limit of RPC over HTTP requests that ASP.NET can process is reached.

The RPC over HTTP requests in Exchange Server 2010 SP3 rely on the ASP.NET runtime to process the requests. However, the default limit of ASP.NET requests is 25,000.

> [!NOTE]
> In versions of Exchange Server earlier than Exchange Server 2010 SP3, RPC over HTTP requests do not rely on the ASP.NET runtime, and they are not affected by the request limit.

## Resolution

To resolve this issue, increase the limit of ASP.NET requests to the recommended value of 65535. To increase the limit of ASP.NET requests, follow these steps:

1. On the computer that is running the Client Access server role, locate the following file: `C:\WINDOWS\Microsoft.NET\Framework64\v2.0.50727\CONFIG\Machine.config`.
2. Open the Machine.config file.
3. In the `<system.web>` section, locate the following line:

    ```xml
    <processModel requestQueueLimit="25000" autoConfig="true" />
    ```

4. Change the value of `requestQueueLimit` property to **65535**.

## More information

You can use the following counters to monitor the number of ASP.NET requests and RPC over HTTP connections:

- ASP.NET Apps v2.0.50727\_LM_W3SVC_x_ROOT_RPC\Requests Executing
- RPC/HTTP Proxy\Current Number of Incoming RPC over HTTP Connections

When the issue occurs, the following errors are logged in the Internet Information Server (IIS) log:

```console
2013-03-21 23:06:14 10.0.0.1 RPC_OUT_DATA /rpc/rpcproxy.dll cas.contoso.com:6001 443 CONTOSO\user 10.0.0.10 MSRPC 503 3 0 15

2013-03-21 23:06:15 10.0.0.1 RPC_IN_DATA /rpc/rpcproxy.dll cas.contoso.com:6001 443 CONTOSO\user 10.0.0.10 MSRPC 503 3 0 46
```
