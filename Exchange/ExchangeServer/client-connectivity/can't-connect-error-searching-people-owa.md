---
title: Error (Can't connect. Please try again later) when searching people in OWA in Exchange Server 2019
description: Describes an issue in which you are unable to search people in OWA in Exchange Server 2019. Provides a solution.
author: simonxjx
ms.author: jcoiffin
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CI 116313
- CSSTroubleshoot
ms.reviewer: jcoiffin
appliesto:
- Exchange Server 2019
search.appverid: 
- MET150
---
# Error (Can't connect. Please try again later) when searching people in OWA in Exchange Server 2019

## Symptoms

With Microsoft Exchange Server 2019 installed on a Windows Server 2019 (Server Core), when trying to find a contact in the global address list (GAL) in Outlook on the web, you receive the following error message:

> Can't connect. Please try again later

## Cause

The default language and locale of Windows Server 2019 aren't US English. The Advanced Query Syntax (AQS) Windows module requires the installation of the corresponding language pack on the server.

## Resolution

Install the language pack using the corresponding language .cab files from [Language Pack ISO for Windows Server](/windows-hardware/manufacture/desktop/add-language-packs-to-windows#get-language-resources-language-pack-iso-and-feature-on-demand-iso). For example, if you changed the language to French, you must add a French language pack.

1. Open Command-Line as administrator and run these commands:

    ```
    intl.cpl
    ```

    
2. Check if Format is set to English (United States):

![image](https://user-images.githubusercontent.com/43539433/126612620-a0da1ade-dd30-4e4f-931d-3535fb525dff.png)


3. Select "Administrative" tab and click "Copy settings"

![image](https://user-images.githubusercontent.com/43539433/126612816-ad1c5ba6-323c-42b5-9ffd-6cd3798b898d.png)

4. "Apply" and Reboot server
