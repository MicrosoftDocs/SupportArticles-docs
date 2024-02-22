---
title: We weren't able to connect to the remote server error
description: Describes an issue in which you can't create a migration endpoint when you try to perform a cutover migration from an on-premises Exchange organization that uses Outlook Anywhere to Exchange Online. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# We weren't able to connect to the remote server error when migrating from on-premises Exchange to Online

_Original KB number:_ &nbsp; 2903050

## Symptoms

When you try to perform a cutover migration from an on-premises Exchange organization that uses Outlook Anywhere (also known as **RPC over HTTP**) to Exchange Online, the migration engine doesn't create a migration endpoint. Additionally, you receive an error message that resembles the following:

> Microsoft.Exchange.Data.Storage.Management.MigrationTransientException: We weren't able to connect to the remote server. Please verify that the migration endpoint settings are correct and your certificate is valid, and then try again. Consider using the [Exchange Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365) to diagnose the connectivity issues. ---> Microsoft.Exchange.Rpc.ServerUnavailableException: Error 0x6ba (The RPC server is unavailable) from cli_NspiBind

## Cause

This issue may occur if one or both of the following conditions are true for Outlook Anywhere:

- Authentication settings for Outlook Anywhere are incorrect.
- RPC proxy configuration settings for Outlook Anywhere are incorrect.

## Resolution

To resolve this issue, follow these steps:

1. Make sure that the on-premises Outlook Anywhere client authentication method is set to **Basic authentication**. For more information, see one of the following articles, depending on the version of Exchange Server that you're running:
   - For Exchange Server 2013: [Outlook Anywhere](/exchange/outlook-anywhere-exchange-2013-help)
   - For Exchange Server 2010: [Enable Outlook Anywhere](/previous-versions/office/exchange-server-2010/bb123542(v=exchg.141))
   - Exchange Server 2007: [Enable Outlook Anywhere Wizard > Enable Outlook Anywhere page](/previous-versions/office/exchange-server-2007/bb123542(v=exchg.80))
   - Exchange Server 2003: [How to configure Outlook Anywhere with Exchange 2003](/previous-versions/office/exchange-server-2007/aa996922(v=exchg.80))

2. Make sure that the RPC proxy server is correctly set up to use specific ports to communicate with Outlook Anywhere and that the on-premises domain controllers are listening on port 6004. For more information, see [How does Outlook Anywhere work (and not work)?](https://techcommunity.microsoft.com/t5/exchange-team-blog/how-does-outlook-anywhere-work-and-not-work/ba-p/586046)

3. Verify Outlook Anywhere connectivity to the on-premises Exchange server. To do this, follow these steps:

   1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   2. Run the following PowerShell commands:

        ```powershell
        $pscred=Get-Credential
        ```

        ```powershell
        Test-MigrationServerAvailability -Credentials $pscred -ExchangeOutlookAnywhere -ExchangeServer <Internal FQDN of the Exchange server> -RPCProxyServer <FQDN of the proxyserver> -Authentication Basic -EmailAddress <AdminEmail>
        ```

      If the verification is successful, you can create a migration endpoint in Microsoft 365.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
