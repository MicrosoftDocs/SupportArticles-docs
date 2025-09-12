---
title: Resolve free/busy sharing issues in a hybrid Exchange environment  
description: How to resolve free/busy sharing issues in a hybrid Exchange environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
  - CI 168618
ms.reviewer: ruxandra, lusassl, meerak, v-trisshores
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Resolve free/busy sharing issues in a hybrid Exchange environment

## Free/busy sharing and MailTips issues

After you set up a hybrid Microsoft Exchange environment, the following issues might occur:

- When a user who has an on-premises mailbox tries to use the Scheduling Assistant in Microsoft Outlook to retrieve [free/busy](/exchange/shared-free-busy) information for another user who has an Exchange Online mailbox, free/busy sharing either doesn't work or works intermittently.

- When a user who has an on-premises mailbox tries to add the shared calendar of a user who has an Exchange Online mailbox, Outlook displays a "Could not update" message.

- When a user who has an on-premises mailbox drafts a message to a user who has an Exchange Online mailbox, [MailTips](/exchange/clients-and-mobile-in-exchange-online/mailtips/mailtips) aren't displayed. This issue can occur in Outlook or Outlook on the web.

## Federation trust and authorization errors

When you try to configure the components that are required for free/busy sharing by using Hybrid Configuration wizard (HCW) or the Exchange Management Shell (EMS), you might encounter any of the following errors.

### Errors when creating a federation trust

> PowerShell failed to invoke 'Set-FederatedOrganizationIdentifier': An error occurred while attempting to provision Exchange to the Partner STS. Detailed Information "An error occurred accessing Windows Live. Detailed information: "The underlying connection was closed: An unexpected error occurred on a receive."."

> PowerShell failed to invoke 'Set-FederatedOrganizationIdentifier': An error occurred while attempting to provision Exchange to the Partner STS. Detailed Information "An error occurred accessing Windows Live. Detailed information: "The underlying connection was closed: An unexpected error occurred on a send."."

HCW logs these errors in the HCW log file. If you use EMS, you encounter these errors when you run the [Set-FederatedOrganizationIdentifier](/powershell/module/exchange/set-federatedorganizationidentifier) cmdlet.

### Errors when adding a domain to a federation trust

> PowerShell failed to invoke 'Add-FederatedDomain': Unable to reserve the URI "contoso.com" for the domain "contoso.com" on application identifier \<application ID\>. Detailed information: "An error occurred accessing Windows Live. Detailed information: "The underlying connection was closed: An unexpected error occurred on a send."."

HCW logs this error in the HCW log file. If you use EMS, you encounter this error when you run the [Add-FederatedDomain](/powershell/module/exchange/add-federateddomain) cmdlet.

### Error when creating authorization server objects

> New-AuthServer -Name "WindowsAzureACS" -AuthMetadataUrl "https://accounts.accesscontrol.windows.net/contoso.com/metadata/json/1" Cannot acquire auth metadata document from 'https://accounts.accesscontrol.windows.net/contoso.com/metadata/json/1'. Error: The underlying connection was closed: An unexpected error occurred on a receive.

HCW logs this error in the HCW log file. If you use EMS, you encounter this error when you run the [New-AuthServer](/powershell/module/exchange/new-authserver) cmdlet in EMS.

### Error when testing OAuth connectivity

> System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send.
> System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host.

HCW logs this error in the HCW log file. If you use EMS, you encounter this error when you run the [Test-OAuthConnectivity](/powershell/module/exchange/test-oauthconnectivity) cmdlet.

## Resolution

Any of the listed issues and errors can occur if TLS 1.2 isn't fully enabled and configured on all Exchange-based servers in your organization. Follow the guidelines in [Exchange Server TLS configuration best practices](/Exchange/exchange-tls-configuration) to make sure that all the servers in your environment are compliant.

## More information

- To diagnose free/busy issues in Outlook and Outlook on the web, see [Demystifying hybrid free/busy](https://techcommunity.microsoft.com/t5/exchange-team-blog/demystifying-hybrid-free-busy-finding-errors-and-troubleshooting/ba-p/607727) and [Free/busy sharing fails if TLS 1.2 is misconfigured](https://techcommunity.microsoft.com/t5/exchange/tls-1-2-is-coming-to-exchange-on-premises-using-hybrid-and-free/m-p/3260911).

- To check the TLS configuration in Exchange Server, use the [Exchange Server Health Checker](https://microsoft.github.io/CSS-Exchange/Diagnostics/HealthChecker/).

- To check a server's SSL/TLS configuration, use the [Microsoft SSL Server Test](https://testconnectivity.microsoft.com/tests/SslServer/input) or [Qualys SSL Server Test](https://www.ssllabs.com/ssltest/).

- To check the TLS version of network traffic for a specific issue, trigger the issue while you use a network protocol analyzer to capture the network traffic. The following screenshot shows the TLS version of a [ClientHello](https://www.rfc-editor.org/rfc/rfc5246#section-7.4.1.2) handshake that was captured by using [Wireshark](https://www.wireshark.org/).

  :::image type="content" source="./media/free-busy-sharing-issues-tls12/wireshark-client-hello-tls.png" border="true" alt-text="Screenshot of a Wireshark capture of network traffic.":::

> [!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
