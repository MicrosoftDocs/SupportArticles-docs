---
title: SocketError when sending/receiving emails
description: Fixes an issue in which errors occur on the mail flow when sending or receive email messages using Transport Layer Security (TLS) 1.0 or TLS 1.1.
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
# Can't send or receive emails when using TLS 1.0 or TLS 1.1

This issue occurs because Transport Layer Security (TLS) 1.0 and TLS 1.1 protocols are deprecated in Office 365. If Exchange Server (on-premises) uses TLS 1.1 or TLS 1.1, Office 365 users can't send mail to or receive mail from the on-premises server users, and vice versa. Additionally, one of following errors occurs on the mail flow.

## 421 4.4.2 Connection dropped due to SocketError

Users receive this non-delivery report (NDR) when sending email messages. Also, this error message appears in the server's [Queue Viewer](/exchange/mail-flow/queues/queue-viewer).

## TLS negotiation failed with error SocketError

This error message appears in the [protocol log](/exchange/mail-flow/connectors/protocol-logging) file of the server's Send connector.

## 451 5.7.3 Must issue a STARTTLS command first

This error message appears in the [protocol log](/exchange/mail-flow/connectors/protocol-logging) file of the server's Send or Receive connector.

## Solution: Enable TLS 1.2

To resolve the errors, enable TLS 1.2 on the on-premises server that sends and receives email messages. Here's how to enable TLS 1.2 by modifying the registry values:

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. As a preventive measure, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) before you modify it.

1. Install latest Windows and Exchange updates because some Windows and Exchange versions require latest updates for TLS 1.2 to be enabled.
2. Locate each of the following registry subkeys:

    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2`
    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client`
    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server`

3. Double-click the `DisabledByDefault` value, type *0* in the **Value Data** box, and then select **OK**.
4. Double-click the `Enabled` value, type *1* in the **Value Data** box, and then select **OK**.
5. Restart the server for the settings to take effect.

## Related articles

For more information about TLS guidance, see the following articles:

- [Exchange Server TLS guidance, part 1: Getting Ready for TLS 1.2](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-1-getting-ready-for-tls-1-2/ba-p/607649)
- [Exchange Server TLS guidance Part 2: Enabling TLS 1.2 and Identifying Clients Not Using It](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-2-enabling-tls-1-2-and/ba-p/607761)
- [Understanding email scenarios if TLS versions cannot be agreed on with Exchange Online](https://techcommunity.microsoft.com/t5/exchange-team-blog/understanding-email-scenarios-if-tls-versions-cannot-be-agreed/ba-p/2065089)
