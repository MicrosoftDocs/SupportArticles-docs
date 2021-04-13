---
title: Error (Can't connect. Please try again later) when searching people in OWA in Exchange Server 2019
description: Describes an issue in which you are unable to search people in OWA in Exchange Server 2019. Provides a solution.
author: Norman-sun
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

Install the language pack using the corresponding language .cab files from [Language Pack ISO for Windows 10](/windows-hardware/manufacture/desktop/add-language-packs-to-windows#get-language-resources-language-pack-iso-and-feature-on-demand-iso). For example, if you changed the language to French, you must add a French language pack.

1. Open Command-Line as administrator and run these commands:

    ```
    DISM/Online /Add-Package /PackagePath:"c:\temp\Microsoft-Windows-Client-Language-Pack_x64_fr-FR.cab"
    ```

    ```
    DISM/Online/Add-Capability/CapabilityName:Language.Basic~~~fr-FR~0.0.1.0
    ```

2. Check if these packages are installed:

    ```
    Get-WindowsPackage -Online -PackageName '*language*' | Format-List -Property @( 'ReleaseType', 'DisplayName', 'ProductName', 'CapabilityId', 'PackageName' )
    ```
