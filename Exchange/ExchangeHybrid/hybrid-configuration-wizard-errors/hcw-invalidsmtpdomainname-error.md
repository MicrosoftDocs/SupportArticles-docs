---
title: InvalidSmtpDomainName(domain) error connecting to on-premises Exchange
description: Fixes an issue that returns a DataStrings.InvalidSmtpDomainName( domain) error when you run the Hybrid Configuration wizard. Also, an Exchange server that's no longer available in your environment is listed in the output when you run the Get-ExchangeServer * | FL command.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jeknight, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# DataStrings.InvalidSmtpDomainName(domain) error when running Microsoft 365 Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3132123

## Problem

When you run the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/HybridWizard), you receive the following error message when the wizard tries to connect to your on-premises Exchange environment:

> DataStrings.InvalidSmtpDomainName(domain)

:::image type="content" source="media/hcw-invalidsmtpdomainname-error/error.png" alt-text="Screenshot of the error message when the wizard tries to connect to your on-premises Exchange environment.":::

Additionally, you experience the following symptoms:

- When you run the `Get-ExchangeServer * | FL` command, the output returns an Exchange server that you don't expect to see. This server has either been decommissioned or is no longer available, and you don't intend to bring the server back online.
- When you view the Hybrid Configuration wizard log file at `%appdata%\Microsoft\Exchange Hybrid Configuration`, you see the following:

  - An entry that resembles the following for the Exchange server that's no longer available. This entry confirms that the server doesn't return a domain name.

    > \<property type="System.String" value="CN=MailServer001,CN=Servers,CN=Exchange Administrative Group (FYDIBOHF23SPDLT),CN=Administrative Groups,CN=Exchangetest,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=contoso,DC=com" name="DistinguishedName"/>\
    > \<property type="System.String" value="" name="Domain"/>

  - An entry that resembles the following for Exchange servers in your environment that are up and running. This entry shows that these servers return a domain name.

    > \<property type="System.String" value="CN=MailServer002,CN=Servers,CN=Exchange Administrative Group (FYDIBOHF23SPDLT),CN=Administrative Groups,CN=Exchangetest,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=contoso,DC=com" name="DistinguishedName"/>  
    > \<property type="System.String" value="contoso.com" name="Domain"/>

## Solution

> [!WARNING]
> These steps require Active Directory Service Interfaces Editor (ADSI Edit). Using ADSI Edit incorrectly can cause serious problems that may require you to reinstall your operating system. We can't guarantee that problems that result from the incorrect use of ADSI Edit can be resolved. Use ADSI Edit at your own risk.

Use ADSI Edit to remove the Exchange server from the domain configuration:

1. Open ADSI Edit, and then connect to the Configuration container.
2. Locate the following:

    CN=Servers, CN=Exchange Administrative Group (FYDIBOHF23SPDLT), CN=Administrative Groups, CN=Contoso,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=Contoso,DC=com

3. In the Servers container, remove the CN=\<ServerName>  object of the Exchange server that's no longer available in your environment.

4. Confirm that the Exchange server is removed from the domain configuration. To do this, open the Exchange Management Shell, and then run the following PowerShell command:

    ```powershell
    Get-ExchangeServer * | FL
    ```

    Make sure that the server is no longer listed in the output. You may have to wait for Active Directory replication to complete.

5. Rerun the Microsoft 365 Hybrid Configuration wizard.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
