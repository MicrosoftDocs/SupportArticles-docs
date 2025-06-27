---
title: Search-AdminAuditLog and Search-MailboxAuditLog with parameters return empty results
description: Workaround for an issue that returns empty results when you run Search-AdminAuditLog and Search-MailboxAuditLog cmdlets with parameters.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Messaging Policy and Compliance\Issues with eDiscovery, import/export of mailbox
  - Exchange Server
  - CSSTroubleshoot
  - CI 165075
ms.reviewer: batre, dkhrebin, nourdinb
appliesto: 
  - Exchange Server 2019 Enterprise Edition
  - Exchange Server 2019 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise Edition
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Search-AdminAuditLog and Search-MailboxAuditLog with parameters return empty results

_Original KB number:_ &nbsp;3054391

## Symptoms

In Exchange Management Shell, you run the [Search-AdminAuditLog](/powershell/module/exchange/search-adminauditlog) or [Search-MailboxAuditLog](/powershell/module/exchange/search-mailboxauditlog) cmdlets together with a **Cmdlets** or **Parameters** parameter to search a mailbox and filter the search results. In this scenario, an empty or incomplete result set is returned. Even if you run the `Search-AdminAuditLog` cmdlet without parameters, the full results might not be returned as expected.

## Resolution

To fix this issue, install the following cumulative updates (CUs), as appropriate:

[Cumulative Update 12 for Exchange Server 2019](https://support.microsoft.com/help/5011156) or [a later cumulative update](/Exchange/new-features/build-numbers-and-release-dates?view=exchserver-2019&preserve-view=true) for Exchange Server 2019

[Cumulative Update 23 for Exchange Server 2016](https://support.microsoft.com/help/5011155) or [a later cumulative update](/Exchange/new-features/build-numbers-and-release-dates?view=exchserver-2016&preserve-view=true) for Exchange Server 2016

## Workaround

If you still see the issue after you install the appropriate cumulative update, check the language format for system accounts. You might have a secondary regional language set as the language format on the server that contains the mailbox that you’re searching.

For example, the following screenshot shows the language format for system accounts set to a secondary language, German (Switzerland), instead of the primary language, German (Germany).

:::image type="content" source="media/search-adminauditlog-mailboxauditlog-return-no-result/welcome-screen-new-user-accounts-settings.png" alt-text="Screenshot of the Welcome screen and new user accounts settings dialog box with the language format for the welcome screen highlighted.":::

If a secondary regional language is set as the language format, update the format for the system and network service accounts to one of the following primary languages:

- Arabic (United Arab Emirates)
- English (United States)
- German (Germany)
- French (France)
- Korean (Korea)
- Spanish (Spain)

**Note**: This workaround has been determined to work for these languages only. It doesn’t work for the primary languages Italian (Italy) and Korean (North Korea).

To update the language format, follow these steps:

1. In Control Panel, select **Region**.  
1. On the **Formats** tab, select a primary regional language format, and then select **Apply**.
1. On the **Administrative** tab, select **Copy settings**.
1. In the **Welcome screen and new user accounts settings** dialog box, select **Welcome screen and system accounts**, and then select **OK**.

After you complete this step, you don’t have to restart the server or any processes or services.

**Notes**:

- The system account includes the network service account. Therefore, these updates apply to both accounts.  
- If you want, you can revert the format of the language setting for Current user to its original value. However, the format of the language setting for Welcome screen must remain set to one of the primary languages that are compatible with this workaround.
- Usually, the MSExchangeDelivery service starts together with Exchange Server. If the service doesn’t start, follow these steps:
  1. Change the logon account of the service to Local System.
  1. Revert the logon account to Network Service.
  1. Start the service.
