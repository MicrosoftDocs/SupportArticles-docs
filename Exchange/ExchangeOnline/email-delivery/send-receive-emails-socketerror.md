---
title: SocketError when sending/receiving emails
description: Fixes an issue in which users receive a 421 4.4.2 non-delivery report when sending email messages or admins see the errors on the server. This issue occurs because of the deprecation of Transport Layer Security (TLS) 1.0 and 1.1.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom:
- CI 144876
- Exchange Online
- CSSTroubleshoot
ms.reviewer: arindamt
appliesto:
- Exchange Server 2013
- Exchange Server 2016
- Exchange Server 2019
- Exchange Online
search.appverid: MET150
---
# Mail flow errors caused by TLS 1.0 and TLS 1.1 disablement

## Error 1: 421 4.4.2 Connection dropped due to SocketError

Users receive this non-delivery report (NDR) when sending email messages. Also, this error message appears in the server's [Queue Viewer](/exchange/mail-flow/queues/queue-viewer).

## Error 2: TLS negotiation failed with error SocketError

This error message appears in the [protocol log](/exchange/mail-flow/connectors/protocol-logging) file of the server's Send connector.

## Error 3: 451 5.7.3 Must issue a STARTTLS command first

This error message appears in the [protocol log](/exchange/mail-flow/connectors/protocol-logging) file of the Send or Receive connector.

## Cause: TLS 1.0 and TLS 1.1 disablement

Transport Layer Security (TLS) 1.0 and 1.1 protocols are deprecated for Office 365. Office 365 no longer accepts email connections that use TLS 1.0 or TLS 1.1 from external senders. Additionally, Exchange Online no longer uses TLS 1.0 or TSL 1.1 to send outbound email messages.

## Solution: Enable TSL 1.2

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. As a preventive measure, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) before you modify it.

To resolve the errors, enable TSL 1.2 on the server that sends and receive email messages. Here's how to enable TSL 1.2 by modifying the registry values:

1. Install latest Windows and Exchange updates because some Windows and Exchange versions require latest updates for TLS 1.2 to be enabled.
2. Locate each of the following registry subkeys:

    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2`
    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client`
    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server`

3. Double-click the `DisabledByDefault` value, type *0* in the **Value Data** box, and then select **OK**.
4. Double-click the `Enabled` value, type *1* in the **Value Data** box, and then select **OK**.
5. Restart the server for the settings to take effect.

## More information

For more information about TLS guidance, see the following articles:

- [Exchange Server TLS guidance, part 1: Getting Ready for TLS 1.2](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-1-getting-ready-for-tls-1-2/ba-p/607649)
- [Exchange Server TLS guidance Part 2: Enabling TLS 1.2 and Identifying Clients Not Using It](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-2-enabling-tls-1-2-and/ba-p/607761)
- [Understanding email scenarios if TLS versions cannot be agreed on with Exchange Online](https://techcommunity.microsoft.com/t5/exchange-team-blog/understanding-email-scenarios-if-tls-versions-cannot-be-agreed/ba-p/2065089)
