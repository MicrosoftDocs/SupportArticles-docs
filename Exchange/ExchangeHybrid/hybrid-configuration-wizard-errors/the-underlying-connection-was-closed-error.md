---
title: The underlying connection was closed error
description: Describes an issue in which you receive an An error occurred accessing Windows Live error when you run the Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# (The underlying connection was closed) error when running Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3068838

## Symptoms

When you run the Hybrid Configuration wizard, you receive a **An error occurred accessing Windows Live. The underlying connection was closed: The connection was closed unexpectedly** error message. The full text of the message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'Subtask Configure execution failed: Creating Organization Relationships.
>
> Execution of the Set-FederatedOrganizationIdentifier cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.
>
> An error occurred while attempting to provision Exchange to the Partner STS. Detailed Information ""An error occurred accessing Windows Live. Detailed information: ""The underlying connection was closed: The connection was closed unexpectedly.""."".  
at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet, Dictionary`2 parameters, Boolean ignoreNotFoundErrors)

## Cause

This can occur if proxy settings are configured incorrectly. For example, this can occur proxy settings do not allow access to the endpoints that are used by Microsoft 365.

## Resolution

1. Configure the settings on the proxy server to allow access to the endpoints that are used by the service. For a list of IP addresses and URLs that are used by Microsoft Exchange Online, see the Exchange Online section of [Microsoft 365 URLs and IP addresses](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#bkmk_exo&preserve-view=true).

2. Make sure that proxy settings are configured correctly on the Exchange servers in your environment by doing the following:
   1. Set the proxy in Internet Explorer.
   2. Set the proxy by using the netsh command-line tool. For more information, see [Netsh Commands in for Windows Hypertext Transfer Protocol](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731131(v=ws.10)).
   3. Set the proxy by using the `Set-ExchangeServer` cmdlet. For example, run the following command:

        ```powershell
        Set-ExchangeServer NameOfServer -InternetWebProxy Http://proxyURL:Port
        ```

       For more information, see [Set-ExchangeServer](/powershell/module/exchange/set-exchangeserver?view=exchange-ps&preserve-view=true).
3. Rerun the Hybrid Configuration wizard.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
