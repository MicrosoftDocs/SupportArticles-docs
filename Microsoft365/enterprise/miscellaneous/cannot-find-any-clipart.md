---
title: Can't find clip art when you open Office Online
description: Describes a problem in which you cannot find any clip art when you open Microsoft OneNote Online and try to insert a clip art whether the ClipArt button is disabled or enabled.
author: MaryQiu1987
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: v-maqiu
ms.custom: CSSTroubleshoot
localization_priority: Normal
search.appverid: 
  - MET150
ms.reviewer: samwilli, ctronent
appliesto: 
  - Word Web App
  - IIS Media Services 3.0
ms.date: 3/31/2022
---

# You cannot find any clip art when you open Microsoft Word Online or Microsoft OneNote Online and try to insert some clip art

## Symptoms

Consider the following scenarios.

Scenario 1

You have a server that is running Microsoft Microsoft Offices Online. You open the Microsoft Word Online or Microsoft OneNote Online and then you click the ClipArt button. However, when you type an item to search, the search returns no clip art results.

This behavior occurs when the ClipArt button is enabled.

Scenario 2

You have a server that is running Microsoft Microsoft Offices Online. When you open the Microsoft Word Online or Microsoft OneNote Online and try to insert some clip art, you notice that the ClipArt button is disabled. 

## Cause

This problem occurs because the service retrieves clip art by contacting Microsoft Office Online directly from the SharePoint server. However, firewall or proxy rules may prohibit outgoing traffic from reaching the required URLs.

## Workaround

To work around this problem, validate that you can access all three required URLs from the SharePoint box. Additionally, make sure that the proxy settings are configured appropriately for the server. To do this, follow these steps: 

1. Log on to the computer that hosts the Microsoft Word Online or OneNote Web App.

   **Note** Typically, this computer is a front-end computer.   
2. In a browser, validate that you can browse to the following three URLs:
   - https://r.office.microsoft.com/r/rlidClientConfig   
   - https://office2010.microsoft.com    
   - https://office.microsoft.com   
   
3. If you cannot access these URLs from a Web browser, your firewall may be blocking access to these sites. Change the settings on your firewall to enable access to each of these URLs.    

Frequently, outgoing traffic will have to use a proxy in order to reach these URLs. In order to instruct the Microsoft OneNote Online to use a proxy, use the following cmdlet for each site that the Microsoft OneNote Online is enabled:

```powershell
PS C:\> Set-SPOneNoteWebAppConfig -Site "http://localhost" -Proxy "http://myproxyURL"
```
**Note** You can check the current proxy settings by using the following cmdlet:

```powershell
PS C:\> $w = Get-SPOneNoteWebAppConfig -Site "http://localhost"

PS C:\> $w.Properties
```