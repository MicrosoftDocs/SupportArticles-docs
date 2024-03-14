---
title: Can't find clip art when you open Office Online
description: Describes the problem when you can't find clip art in OneNote Online to insert.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
localization_priority: Normal
search.appverid: 
  - MET150
ms.reviewer: samwilli, ctronent
appliesto: 
  - Word Web App
  - IIS Media Services 3.0
ms.date: 03/31/2022
---

# You can't find any clip art in Word Online or OneNote Online to insert 

## Symptoms

Consider the following scenarios.

Scenario 1

You have a server that is running Microsoft Office Online. You open either Microsoft Word Online or Microsoft OneNote Online and then click the ClipArt button. However, when you search for an item, the search returns no clip art results.

This behavior occurs when the ClipArt button is enabled.

Scenario 2

You have a server that is running Microsoft Office Online. When you open Microsoft Word Online or Microsoft OneNote Online and try to insert a clip art, the ClipArt button is disabled.

## Cause

This problem occurs because the service retrieves clip art by contacting Office Online directly from the Microsoft SharePoint server. However, firewall or proxy rules may prohibit outgoing traffic from reaching the required URLs.

## Workaround

To work around this problem, validate that you can access all three required URLs from the computer that's running SharePoint server. Additionally, make sure that the proxy settings are configured appropriately for the server. To do this, follow these steps:

1. Log on to the computer that hosts the Word Online or OneNote Web App.

   **Note** Typically, this is a front-end computer.
2. In a browser, validate that you can browse to the following three URLs:
   - https://r.office.microsoft.com/r/rlidClientConfig
   - https://office2010.microsoft.com
   - https://office.microsoft.com

3. If you can't access these URLs from a Web browser, your firewall may be blocking access to these sites. Change the settings on your firewall to enable access to each of these URLs.

Frequently, outgoing traffic will have to use a proxy in order to reach these URLs. In order to instruct OneNote Online to use a proxy, use the following cmdlet for each site for which OneNote Online is enabled:

```powershell
PS C:\> Set-SPOneNoteWebAppConfig -Site "http://localhost" -Proxy "http://myproxyURL"

**Note** You can check the current proxy settings by using the following cmdlet:

```powershell
PS C:\> $w = Get-SPOneNoteWebAppConfig -Site "http://localhost"

PS C:\> $w.Properties
```
