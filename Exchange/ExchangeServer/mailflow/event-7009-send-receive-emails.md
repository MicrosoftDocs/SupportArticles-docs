---
title: Event 7009 when users send or receive emails
description: This article describes an issue that prevents mail delivery in Exchange Server 2013 and Exchange Server 2016. This issue occurs when the Microsoft Exchange Transport service is inactive. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: stephgil, v-six
ms.custom: 
  - sap:Mail Flow\Not Able to Send or Receive Emails from Internet
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise Edition
ms.date: 01/24/2024
---
# Event 7009 when users try to send or receive email in Exchange Server 2013 or Exchange Server 2016

_Original KB number:_ &nbsp; 2866822

## Symptoms

When a user tries to send email messages in an Exchange Server 2013 or Microsoft Exchange Server 2016 environment, the email is not sent as expected. Instead, it remains in the Outbox folder or the Drafts folder.

When this issue occurs, an event that resembles the following is logged in the Application folder:

Additionally, connection activity information that resembles the following is logged in the Mailbox Connectivity log. (Notice the "Server not active" error.)

```console
2013-06-27T21:08:37.520Z,08D03F2DE58E0D70,MapiSubmission,89294a5c-bf90-4ae2-a3ff-7f2b81b4ba71,+,Exchange-Server.contoso.com
2013-06-27T21:08:37.536Z,08D03F2DE58E0D71,SMTP,mailboxtransportsubmissioninternalproxy,+,Undefined 00000000-0000-0000-0000-000000000000;QueueLength=0
2013-06-27T21:08:37.536Z,08D03F2DE58E0D71,SMTP,mailboxtransportsubmissioninternalproxy,>,Exchange-Server.contoso[192.168.0.12]
2013-06-27T21:08:37.536Z,08D03F2DE58E0D71,SMTP,mailboxtransportsubmissioninternalproxy,>,Established connection to 192.168.0.12
2013-06-27T21:08:37.583Z,08D03F2DE58E0D71,SMTP,mailboxtransportsubmissioninternalproxy,-,Messages: 0 Bytes: 0 (Retry : Service not active)
```

When you try to test SMTP communications by using Telnet, you receive a 412.4.3.2 error that resembles the following:

```console
220 Exchange-Server.contoso.comMicrosoft ESMTP MAIL Service ready at Thu, 27 Jun 2013 17:04:17 -0400
ehlo
250-Exchange-Server.contoso.com Hello [fe80::2174:c9da:4ac0:74c2%13]
250-SIZE
250-PIPELINING
250-DSN
250-ENHANCEDSTATUSCODES
250-STARTTLS
250-X-ANONYMOUSTLS
250-AUTH NTLM
250-X-EXPS GSSAPI NTLM
250-8BITMIME
250-BINARYMIME
250-CHUNKING
250-XEXCH50
250-XRDST
250 XSHADOWREQUEST
mail from: user@contoso.com

412 4.3.2 Service not active
```

## Cause

This issue occurs if the Transport service is in an inactive state.

In Exchange Server, administrators can put servers in Maintenance mode. When a server is in Maintenance mode, it is in an inactive state and no longer accepts connections.

## Resolution

To resolve this issue, set the Hub Transport component to an active state. To do this, follow these steps:

1. Run the following cmdlet:

    ```powershell
    Set-ServerComponentState -Identity <Exchange_server_name>  -Requester Functional -State active -Component HubTransport
    ```

    If the `Set-ServerComponentState` cmdlet doesn't change the component state to active, run the following cmdlet:

    ```powershell
    Set-ServerComponentState -Identity <Exchange_server_name>  -Requester Maintenance -State Active -Component HubTransport
    ```

2. Restart the Exchange Transport service.

## Verify that a server is inactive

To verify that a server is in an inactive state, run the `Get-ServerComponentState` cmdlet. The output from this cmdlet resembles the following:

:::image type="content" source="media/event-7009-send-receive-emails/cmdlet-output.png" alt-text="Screenshot showing the output by running Get-ServerComponentState using cmdlet.":::

## References

- [Use Telnet to test SMTP communication](/exchange/use-telnet-to-test-smtp-communication-exchange-2013-help)

- [Connectivity logging](/exchange/connectivity-logging-exchange-2013-help)

- [Get-ServerComponentState](/powershell/module/exchange/get-servercomponentstate)

- [Set-ServerComponentState](/powershell/module/exchange/set-servercomponentstate)
