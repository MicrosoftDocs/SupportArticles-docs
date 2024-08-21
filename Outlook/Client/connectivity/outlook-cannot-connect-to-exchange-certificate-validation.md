---
title: Outlook connection fails when certificate is required
description: This article explains that Outlook doesn't support using the Windows certificate store as a credential to connect Exchange Server, and provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: sfellman, jonl
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Network disconnects, password or credentials prompt
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
ms.date: 01/30/2024
---
# Outlook can't connect to an Exchange server that uses certificate validation on a network device

_Original KB number:_ &nbsp; 4488049

## Symptoms

After you configure a network device to require certificate validation between Outlook and Exchange Server 2019, 2016, or 2013, you experience connection failures in Outlook clients.

> [!NOTE]
> The network device can be a load balancer or another network device, as described in [Certificate Selection and Validation](/dotnet/framework/network-programming/certificate-selection-and-validation).

This problem occurs especially if the network device is configured to require the client to present a certificate during the SSL handshake in the network layer instead of passing the traffic directly to the server that is running Exchange Server.

## Cause

This issue occurs because Outlook doesn't support using the Windows certificate store as a credential. Outlook uses the Windows Credential Manager to provide credentials to servers.

## Resolution

To configure certificate authentication in Outlook 2016 and later versions, we recommend that you use Modern Authentication. For more information about how to enable Modern Authentication, see the following articles:

- [Enable Modern Authentication in Microsoft 365](https://social.technet.microsoft.com/wiki/contents/articles/36101.office-365-enable-modern-authentication.aspx)
- [Configure on-premises Exchange to use Hybrid Modern Authentication](/office365/enterprise/configure-exchange-server-for-hybrid-modern-authentication)

## More information

Outlook supports connecting directly to Smart Card Authentication by using a physical smart card or a TPM chip-embedded virtual smart card for each user.
Certificate-based authentication is supported for Outlook Web App (OWA) and Exchange ActiveSync clients, but not in Outlook that is running on Windows. For more information, see the following articles:

- [Configure Smart Card Authentication for Outlook Anywhere in Exchange Server](/previous-versions/exchange-server/exchange-150/dn960152%28v=exchg.150%29)
- [Demystifying Certificate Based Authentication with Exchange ActiveSync in Exchange Server](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-certificate-based-authentication-with-activesync-in/ba-p/606736)
