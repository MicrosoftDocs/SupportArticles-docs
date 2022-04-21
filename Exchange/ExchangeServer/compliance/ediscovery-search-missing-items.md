---
title: Missing items in eDiscovery search results
description: Fixes an issue in which the eDiscovery search returns an incomplete set of results.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 161580
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: dpaul
appliesto: 
  - Exchange Server 2019
search.appverid: MET150
ms.date: 4/21/2022
---
# Missing items in eDiscovery search results in Exchange Server 2019

## Symptoms

In Microsoft Exchange Server 2019, when you use eDiscovery to search for content in mailboxes, and the expected number of search results is greater than 500 items, the search returns an incomplete set of results. This behavior also happens with other search methods, but you get accurate results if you use a targeted search query.

For example, consider a scenario in which the objective is to search for mail items in a specific date range that have the keyword "holiday" as part of the **Subject** field.

If you use a broader search query with the following parameters, you might see an incomplete set of results with missing items that you know should have been there.

- Date range: January 1, 2022 to March 31, 2022
- Recipient: user@contoso.com

However, if you use a more targeted search query with the following parameters, you get accurate results:

- Date range: January 1, 2022 to March 31, 2022
- Recipient: user@contoso.com
- Subject: holiday

This behavior indicates that the items which were missing from the search result of the previous query are indexed and searchable but aren't returned when you use a broader search query.

## Cause

In Exchange Server 2019, the default eDiscovery search query setting uses a **No Search Folder** query context type. Therefore, the items in the message table that were created most recently are queried first. The search results are paged as part of the search process when appropriate to avoid overloading the server. Each subsequent page request adds the oldest received date and time from the previous page into the query as the time stamp for where to begin from.

There are some scenarios though when the time stamp information that's passed on to a subsequent page request might not be correct. For example, if an item in the message table is a copy of an older item and has been created recently, it will be a placed along with items in the table which have newer received dates and time. However, the copy will still retain the received date and time of the original older message. In this scenario, if the received date and time of the copy happens to be the oldest in the message table at the end of a paging attempt, it might be used by the query for the next page attempt. This behavior can result in the newer items that are near the copy being skipped by the query because their received date time wasn't included in the previous page attempts.

## Workaround

To work around this issue, create a setting override to use the **Search Folder** type in the search query setting.

1. Run the following cmdlet to create a setting override:

    ```powershell
    New-SettingOverride -Name "Bigfunnel use Search Folder" -Component "BigFunnel" -Section "BigFunnelDiscoveryQuerySettings" -Parameters @("NoSearchFolder=false") -Reason "Improve Search Results" -MinVersion "<Build Number>" -MaxVersion "<Build Number>"
    ```

    **Note:** Replace \<Build Number> with the [build number](/exchange/new-features/build-numbers-and-release-dates) of the Exchange 2019 Servers in your environment.

2. Run the following cmdlet for the setting override to take effect immediately:

    ```powershell
    Get-ExchangeDiagnosticInfo -Process Microsoft.Exchange.Directory.TopologyService -Component VariantConfiguration -Argument Refresh
    ```

    After running this cmdlet, you should see the BigFunnel.Overrides.ini file in the *%ExchangeInstallPath%\v15\config* directory.

    :::image type="content" source="media/ediscovery-search-missing-items/file-path.png" alt-text="Screenshot of the BigFunnel.Overrides.ini file in the config directory.":::

3. Run the eDiscovery search again.
