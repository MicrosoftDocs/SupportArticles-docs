---
title: Can't find clipart when you open Office Web App
description: Describes a problem in which you cannot find any clipart when you open OneNote Web App and try to insert a clipart whether the ClipArt button is disabled or enabled.
author: simonxjx
manager: dcscontentpm
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
localization_priority: Normal
search.appverid: 
- MET150
ms.reviewer: samwilli, ctronent
appliesto:
- Word Web App
- IIS Media Services 3.0
---

# You cannot find any clipart when you open Word Web App or OneNote Web App and try to insert some clipart

## Symptoms

Consider the following scenarios.

Scenario 1

You have a server that is running Microsoft Office Web Apps. You open the Microsoft Word Web App or Microsoft OneNote Web App and then you click the ClipArt button. However, when you type an item to search, the search returns no clipart results.

This behavior occurs when the ClipArt button is enabled.

Scenario 2

You have a server that is running Microsoft Office Web Apps. When you open the Word Web App or OneNote Web App and try to insert some clipart, you notice that the ClipArt button is disabled. 

## Cause

This problem occurs because the service retrieves clipart by contacting Microsoft Office Online directly from the SharePoint server. However, firewall or proxy rules may prohibit outgoing traffic from reaching the required URLs.

## Workaround

To work around this problem, validate that you can access all three required URLs from the SharePoint box. Additionally, make sure that the proxy settings are configured appropriately for the server. To do this, follow these steps: 

1. Log on to the computer which hosts the Word Web App or OneNote Web App.

   **Note** Typically, this computer is a front-end computer.   
2. In a browser, validate that you can browse to the following three URLs:
   - https://r.office.microsoft.com/r/rlidClientConfig   
   - https://office2010.microsoft.com    
   - https://office.microsoft.com   
   
3. If you cannot access these URLs from a Web browser, your firewall may be blocking access to these sites. Change the settings on your firewall to enable access to each of these URLs.    

Frequently, outgoing traffic will have to use a proxy in order to reach these URLs. In order to instruct the OneNote Web App to use a proxy, use the following cmdlet for each site that the OneNote Web App is enabled:

```powershell
PS C:\> Set-SPOneNoteWebAppConfig -Site "http://localhost" -Proxy "http://myproxyURL"
```
**Note** You can check the current proxy settings by using the following cmdlet:

```powershell
PS C:\> $w = Get-SPOneNoteWebAppConfig -Site "http://localhost"

PS C:\> $w.Properties
```