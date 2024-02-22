---
title: Missing items in eDiscovery search results
description: Provides a workaround for an issue in which eDiscovery search returns an incomplete set of results.
author: cloud-writer
ms.author: meerak
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
ms.date: 01/24/2024
---
# Missing items in eDiscovery search results in Exchange Server 2019

## Symptoms

In Microsoft Exchange Server 2019, when you use eDiscovery to search for content in mailboxes, and the expected number of search results is greater than 500 items, the search returns an incomplete set of results. This behavior also occurs when you use other search methods. However, you get accurate results if you use a targeted search query.

For example, consider a scenario in which the objective is to search for mail items in a specific date range that have the keyword "holiday" as part of the **Subject** field.

If you use a broader search query that uses the following parameters, you might see an incomplete set of results that's missing items that you know should be included:

- Date range: January 1, 2022, to March 31, 2022
- Recipient: user@contoso.com

However, if you use a more targeted search query that uses the following parameters, you get accurate results:

- Date range: January 1, 2022, to March 31, 2022
- Recipient: user@contoso.com
- Subject: holiday

This behavior indicates that the items that were missing from the search results of the previous query are indexed and searchable but aren't returned when you use a broader search query.

## Cause

In Exchange Server 2019, the default eDiscovery search query setting uses a **No Search Folder** query context type. Therefore, the items in the message table that were created most recently are queried first. The search results are paged as part of the search process, when appropriate, to avoid overloading the server. In each subsequent page request, the oldest received date and time from the previous page request are added to the query as the time stamp that marks where to begin the search.

In some scenarios, the time stamp information that's passed on to a subsequent page request might not be correct. For example, if a recently created item in the message table is a copy of an older item, it will be grouped with items in the table that have newer received dates and times. However, the copied item will still retain the received date and time of the original, older message. In this scenario, if the received date and time of the copied item are the oldest in the message table at the end of a page request, this information might be used by the query for the next page request. This behavior can cause the newer items that are indexed near the copy to be skipped by the query because their received date and time weren't included in the previous page requests.

## Workaround

To work around this issue, create a setting override to use the **Search Folder** type in the search query setting. The setting override will be retained for 180 days only. To maintain the override, you must re-create it before it expires.

1. Run the following cmdlet to create a setting override:

    ```powershell
    New-SettingOverride -Name "Bigfunnel use Search Folder" -Component "BigFunnel" -Section "BigFunnelDiscoveryQuerySettings" -Parameters @("NoSearchFolder=false") -Reason "Improve Search Results"
    ```

2. Run the following cmdlet for the setting override to take effect immediately:

    ```powershell
    Get-ExchangeDiagnosticInfo -Process Microsoft.Exchange.Directory.TopologyService -Component VariantConfiguration -Argument Refresh
    ```

    After you run this cmdlet, you should see the BigFunnel.Overrides.ini file in the *%ExchangeInstallPath%\v15\config* directory.

    :::image type="content" source="media/ediscovery-search-missing-items/file-path.png" alt-text="Screenshot of the BigFunnel.Overrides.ini file in the config directory.":::

3. Run the eDiscovery search again.
