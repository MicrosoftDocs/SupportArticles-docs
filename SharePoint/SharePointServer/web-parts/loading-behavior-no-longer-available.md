---
title: Loading behavior option is removed
description: In SharePoint Search Results Web Part, the loading behavior option is removed after installing updates.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User experience\Webpart infrastructure
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - SharePoint Server 2010
  - SharePoint Server 2013
  - SharePoint Server 2016
search.appverid: MET150
ms.date: 12/17/2023
---
# Loading behavior no longer available in SharePoint Search Results Web Part properties

_Original KB number:_ &nbsp; 4052414

## Summary

When you set the properties of the Search Results Web Part in SharePoint Server, you can specify when the search results returned appear on the webpage by setting the loading behavior to synchronous or asynchronous. If you use synchronous loading, the site becomes vulnerable to cross-site search attacks. We strongly recommend that you use asynchronous loading to issue queries from the browser after the webpage is loaded.

[Description of the security update for SharePoint Enterprise Server 2016: December 11, 2018](https://support.microsoft.com/help/4461541), [Description of the security update for SharePoint Enterprise Server 2013: December 11, 2018](https://support.microsoft.com/help/4461549) and [Description of the security update for SharePoint Foundation 2010: December 11, 2018](https://support.microsoft.com/help/4461580) fix this vulnerability with the following changes:

- All existing Search Results Web Parts are automatically switched to use asynchronous loading.
- All newly created Search Results Web Parts use asynchronous loading.
- Loading behavior is no longer an option in the Search Results Web Part properties user interface (UI).

After you install the update, you can still add the loading behavior option back to the UI for each individual site, where the default setting for the loading behavior is asynchronous. Before you do this, we strongly recommend that you carefully consider whether this vulnerability can be exploited in your environment, and provide guidance to web part owners about this vulnerability.

## Add the loading behavior option

To add the loading behavior option to the UI of Search Results Web Part on a SharePoint site, follow these steps:

1. Log on by using a user account that has the `SharePoint_Shell_Access` role.
2. On one of the servers in the SharePoint farm, start the SharePoint Management Shell.
3. From the Windows PowerShell command prompt, run the following commands:

    ```powershell
    $sites = Get-SPSite
    $s = $sites[n]
    $s.RootWeb.AllowUnsafeUpdates = $true
    $s.RootWeb.AllProperties.Add("SyncSearchAllowed", 1)
    $s.RootWeb.Update()
    $s.RootWeb.AllowUnsafeUpdates = $false
    ```

    > [!NOTE]
    > *sites[n]* is the placeholder of the specified site.

## Set the loading behavior

To set the loading behavior in SharePoint Server 2013 or 2016, see [Configure properties of the Search Results Web Part in SharePoint Server](/SharePoint/search/configure-properties-of-the-search-results-web-part). To set the loading behavior in SharePoint Server 2010 Search Core Results Web Part, follow these steps:

1. Verify that the user account that is performing this procedure is a member of the Designers group.
2. On the search results page, click the **Site Actions** menu, and then click **Edit Page**. The search results page opens in Edit mode.
3. In the Search Core Results Web Part, click the arrow, and then select **Edit Web Part** from the menu.
4. Under **AJAX Options**, select on option to determine when the search results returned by the Web Part appear on the web page.

    By default, the **Use asynchronous loading** box is checked, and queries are issued from the end-user's browser after the complete page is received. If you clear the **Use asynchronous loading** box, queries are issued on the server, and the search results are included in the page response that's sent back from SharePoint.

## Remove the loading behavior option

To remove the loading behavior option from the UI of the Search Results Web Part on a SharePoint site, follow these steps:

1. Log on by using a user account that has the `SharePoint_Shell_Access` role.
2. On one of the servers in the SharePoint farm, start the SharePoint Management Shell.
3. From the Windows PowerShell command prompt, run the following commands:

    ```powershell
    $sites = Get-SPSite
    $s = $sites[n]
    $s.RootWeb.AllowUnsafeUpdates = $true
    $s.RootWeb.AllProperties.Remove("SyncSearchAllowed")
    $s.RootWeb.Update()
    $s.RootWeb.AllowUnsafeUpdates = $false
    ```

    > [!NOTE]
    > *sites[n]* is the placeholder of the specified site.
