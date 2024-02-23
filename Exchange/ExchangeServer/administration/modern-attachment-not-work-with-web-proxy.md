---
title: Modern attachment doesn't work with web proxy
description: Provides a workaround for an issue in which the modern attachment feature doesn't work when web proxy is used in Exchange Server 2016.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: robwhal, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
ms.date: 01/24/2024
---
# The modern attachment feature doesn't work when web proxy used in Exchange Server 2016

_Original KB number:_ &nbsp; 4056953

## Symptoms

After you set the `InternetWebProxy` property by using the `Set-ExchangeServer` cmdlet in Microsoft Exchange Server 2016, the [modern attachment feature](/exchange/hybrid-deployment/set-up-document-collaboration) doesn't work. An event like the following is logged on the Exchange Server:

> **Log Name:** Application  
> **Source:** MSExchange OWA  
> **Date:** \<Date>  
> **Event ID:** 164  
> **Task Category:** Configuration  
> **Level:** Error  
> **Keywords:** Classic  
> **User:** N/A  
> **Computer:** server.contoso.com  
> **Description:** There was a failure in finding the SharePoint endpoint. The document library and endpoint location couldn't be retrieved using "https://contoso123.sharepoint.com". System.Net.WebException: Unable to connect to the remote server The document library and endpoint location couldn't be retrieved using "https://contoso123.sharepoint.com". System.Net.WebException: Unable to connect to the remote server

## Cause

OAuth authentication is used between Exchange Server 2016 and the web location (such as OneDrive) that stores the attachment. The `InternetWebProxy` property isn't supported by OAuth authentication.

## Resolution

To resolve this issue, follow these steps:

1. Locate and open each web.config file for the virtual directories: OWA, Mapi, EWS.
1. Look for the proxy part of the web.config file, such as the following:

    ```xml
    <system.net>
        <defaultProxy>
            <proxy usesystemdefault="true" bypassonlocal="true" />
            <bypasslist>
    ```

1. Add the proxy server with a port number, such as `http://proxy.contoso.com:8080`, and set the necessary bypass list:

    ```xml
    <system.net>
        <defaultProxy>
            <proxy usesystemdefault="false" bypassonlocal="true" proxyaddress="http://proxy.contoso.com:8080" />
            <bypasslist>
                <add address=".*\.contoso\.com" />
            </bypasslist>
        </defaultProxy>
    </system.net>
    ```
