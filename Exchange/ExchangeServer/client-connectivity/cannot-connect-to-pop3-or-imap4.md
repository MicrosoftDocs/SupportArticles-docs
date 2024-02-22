---
title: Cannot connect to POP3 or IMAP4
description: Describes an issue in which users cannot connect to POP3 or IMAP4 in Exchange Server 2016 and Exchange Server 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Users cannot connect to POP3 or IMAP4

_Original KB number:_ &nbsp; 3025138

## Symptom 1

Users who have a mailbox on Exchange Server 2016 or Exchange Server 2013 may find that their connections to POP3 or IMAP4 stop working. Additionally, they may receive the following error message:

> Microsoft.Exchange.Monitoring.ProtocolException: Authentication failed.  
The connection is being closed. Unable to read data from the transport connection: An  
existing connection was forcibly closed by the remote host.Server response while making  
connection:[]. ---> System.IO.IOException: Unable to read data from the transport  
connection: An existing connection was forcibly closed by the remote host. --->  
System.Net.Sockets.SocketException: An existing connection was forcibly closed by the  
remote hostThe related service are started, no error/warning events in system or  
application log.

## Symptom 2

Users can telnet to a POP3 or IMAP port by using the server FQDN. However, they don't see the banner. Instead, they see only a blank screen.

## Cause

This issue occurs because the PopProxy and ImapProxy components are in inactive state.

You can use the `Get-ServerComponentState <ServerName>` command to check on the status of components.

## Resolution

To resolve this issue, make the PopProxy and ImapProxy components active. To do this, follow these steps:

1. Use the following command to determine which requester made PopProxy inactive:

    Get-ServerComponentState -Identity \<*ServerName*> -Component PopProxy).LocalStates

    In the following example, `HealthAPI` is displayed as the requester that changed the state of PopProxy to **Inactive**.

   :::image type="content" source="media/cannot-connect-to-pop3-or-imap4/example-of-get-servercomponentstate.png" alt-text="Screenshot of the Get-ServerComponentState cmdlet.":::

2. Use the following command to make PopProxy active:

    Set-ServerComponentState -Identity \<*ServerName*> -component PopProxy -state Active -requester HealthAPI

    For example:

   :::image type="content" source="media/cannot-connect-to-pop3-or-imap4/example-of-set-servercomponentstate.png" alt-text="Screenshot of the Set-ServerComponentState cmdlet.":::
