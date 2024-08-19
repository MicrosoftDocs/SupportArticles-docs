---
title: Messages aren't evenly distributed if BasicAuth, BasicAuthRequireTLS or NTLM is used in Exchange Server 2013 or later
description: Describes an issue that blocks mail flow on the SMTP server when messages are sent to Exchange Server 2013 or later. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Not Able to Send or Receive Emails from Internet
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: dpaul, jarrettr, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# Messages aren't evenly distributed if BasicAuth, BasicAuthRequireTLS or NTLM is used in Exchange Server 2019, 2016, or 2013

_Original KB number:_ &nbsp;3195087

## Symptoms

Consider the following scenario:

- You create a receive connector to use **Basic Authentication**, **Basic Authentication over TLS**, or **NTLM Authentication (Integrated)**.
- You don't use **Anonymous Users** as a permission group on this connector.
- You send email messages to the Microsoft Exchange Front End Transport Service.

In this scenario, the mail flow always seems to proxy the message to the same Transport Service regardless of which Front End Transport Service the message comes in on. The mail queue database can unexpectedly grow on the SMTP server. This causes more resources to be consumed because of the additional messages that are routed to this server.

## Cause

This behavior is by design. When you require **Basic Authentication**, **Basic Authentication over TLS**, or **NTLM Authentication (Integrated)**, these messages are authenticated and then are routed to the host of the active mailbox database copy where the authenticated user is located. If no mailbox exists for that user, the organization's arbitration mailbox is used.

## Workaround 1

Disable the Client Proxy Prefer Mailbox Mounted Server by setting its value to "false." This action distributes the load to other servers in the database availability group (**DAG**). To do so, follow these steps for all smart hosts in the send connector:

1. Locate the MSExchangeFrontEndTransport.exe configuration file.

    > [!NOTE]
    > By default, this file can be found in the following location:  
    *%ExchangeInstallPath%Bin\MSExchangeFrontendTransport.exe.config*

2. Add the following line under \<appSettings>:

    ```console
    <appSettings>
    // Add the following line.
    <add key="ClientProxyPreferMailboxMountedServer" value="false" />
    // End of the added line.
    ```

3. Save the changes, and then restart the Front End Transport service on the server.
    >[!NOTE]
    > When randomization is used, the server selection of a different Active Directory site can be used. The random servers used are only in the DAG of the active mailbox database copy and servers containing active database copies. If the active database isn't part of a DAG, only that server will be used.

## Workaround 2

Don't use **Basic Authentication** or **NTLM Authentication (Integrated)** on the receive connector. Instead, use an external secure authentication method.

> [!NOTE]
> This will make the server an open relay type. This is not a recommended configuration. For more information, see [Allow anonymous relay on Exchange servers](/exchange/mail-flow/connectors/allow-anonymous-relay).

## Workaround 3

Send messages to the Microsoft Exchange Transport Service directly. Do so by sending the mail to port 2525 or to another port the service is listening on. It doesn't do any load balancing at this point. The server that the message is sent to is the server that processes the message. We recommend that you create a new receive connector to allow those connections coming from the SMTP source.
