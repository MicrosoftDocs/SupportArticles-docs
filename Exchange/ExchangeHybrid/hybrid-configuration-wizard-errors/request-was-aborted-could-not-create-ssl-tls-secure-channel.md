---
title: Could not create SSL/TLS secure channel error
description: Describes an issue in which you receive a Could not create SSL/TLS secure channel error when running Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: scotro, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Could not create SSL/TLS secure channel error when running Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067292

## Symptoms

You want to set up a hybrid deployment between your on-premises Microsoft Exchange Server organization and Microsoft Exchange Online in Microsoft 365. However, when you run the Hybrid Configuration wizard, the wizard doesn't complete successfully, and you receive a **The request was aborted: Could not create SSL/TLS secure channel** error message. The full text of the message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'Subtask Configure execution failed: Creating Organization Relationships.  
Execution of the Set-FederatedOrganizationIdentifier cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.  
An error occurred while attempting to provision Exchange to the Partner STS. Detailed Information: "An error occurred accessing Windows Live." Detailed information: ""The request was aborted: Could not create SSL/TLS secure channel.""."".  
at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet, Dictionary`2 parameters, Boolean ignoreNotFoundErrors)

## Cause

This issue can occur if firewall settings or proxy server settings are configured incorrectly.

## Resolution

1. Configure the settings on the proxy server to allow access to the endpoints that are used by the service. For a list of IP addresses and URLs that are used by Exchange Online, see the Exchange Online section of [Microsoft 365 URLs and IP addresses](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#bkmk_exo&preserve-view=true).

2. Make sure that proxy settings are configured correctly on the Exchange servers in your environment by doing the following:

   1. Set the proxy in Internet Explorer.
   2. Set the proxy by using the netsh command-line tool. For more information, see [Netsh Commands in for Windows Hypertext Transfer Protocol](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731131(v=ws.10)).
   3. Set the proxy by using the `Set-ExchangeServer` cmdlet. For example, run the following command:

        ```powershell
        Set-ExchangeServer NameOfServer -InternetWebProxy Http://proxyURL:Port
        ```

        For more information, see [Set-ExchangeServer](/powershell/module/exchange/set-exchangeserver).

3. Rerun the Hybrid Configuration wizard.

If issue persists, contact [Microsoft Support](https://support.microsoft.com/contactus/), and reference this article.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
