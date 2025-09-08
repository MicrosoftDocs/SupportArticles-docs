---
title: SocketError when sending or receiving email messages
description: Fixes an issue in which errors occur on the mail flow when you send or receive email messages by using Transport Layer Security (TLS) 1.1 or TLS 1.0.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
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
ms.date: 01/24/2024
---
# Can't send or receive email when using TLS 1.1 or TLS 1.0

## Symptoms

Microsoft Exchange Server (on-premises) users and Microsoft 365 users can't send email messages to or receive messages from one another if the on-premises server uses Transport Layer Security (TLS) 1.1 or TLS 1.0. When this issue occurs, you receive one of the following error messages:

- > 421 4.4.2 Connection dropped due to SocketError

    Users receive this non-delivery report (NDR) when they send email messages. This error message is displayed in the [Queue Viewer](/exchange/mail-flow/queues/queue-viewer).

- > TLS negotiation failed with error SocketError

    This error message is displayed in the [protocol log](/exchange/mail-flow/connectors/protocol-logging) file of the Send connector.

- > 451 5.7.3 Must issue a STARTTLS command first

    This error message is displayed in the [protocol log](/exchange/mail-flow/connectors/protocol-logging) file of the Send or Receive connector.

## Cause

This issue occurs because TLS 1.1 and TLS 1.0 are deprecated in Microsoft 365.

## Resolution

To resolve this issue, enable TLS 1.2 on the on-premises server that sends and receives email. Here's how to enable TLS 1.2 by modifying the registry:

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. As a preventive measure, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) before you modify it.

1. Install the latest Windows and Exchange updates. This is because some Windows and Exchange versions require the latest updates for TLS 1.2 to be enabled.
2. Locate each of the following registry subkeys:

    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2`
    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client`
    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server`

3. Double-click the `DisabledByDefault` value, enter **0** in the **Value Data** box, and then select **OK**.
4. Double-click the `Enabled` value, type **1** in the **Value Data** box, and then select **OK**.
5. For the settings to take effect, restart the server.

## Related articles

For more TLS guidance, see the following articles:

- [Exchange Server TLS guidance, part 1: Getting Ready for TLS 1.2](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-1-getting-ready-for-tls-1-2/ba-p/607649)
- [Exchange Server TLS guidance Part 2: Enabling TLS 1.2 and Identifying Clients Not Using It](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-2-enabling-tls-1-2-and/ba-p/607761)
- [Understanding email scenarios if TLS versions cannot be agreed on with Exchange Online](https://techcommunity.microsoft.com/t5/exchange-team-blog/understanding-email-scenarios-if-tls-versions-cannot-be-agreed/ba-p/2065089)
