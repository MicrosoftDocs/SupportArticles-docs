---
title: Can't connect. Please try again later when searching people in OWA in Exchange Server 2019
description: Describes an issue in which you are unable to search people in OWA in Exchange Server 2019. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with OWA
  - Exchange Server
  - CI 116313
  - CI 9823
  - CI 12201
  - CSSTroubleshoot
ms.reviewer: jcoiffin, v-six
appliesto: 
  - Exchange Server 2019
search.appverid: 
  - MET150
ms.date: 07/07/2026
---
# "Can't connect. Please try again later" error when searching people in OWA in Exchange Server 2019

## Summary

This article describes an issue in which users receive a "Can't connect. Please try again later" error when searching the global address list (GAL) in Outlook on the web in Exchange Server 2019. The issue occurs when Exchange Server is installed on Windows Server 2019 and the server's language and regional settings aren't configured for U.S. English, preventing the Advanced Query Syntax (AQS) component from functioning correctly. The article provides guidance for installing the required language pack and configuring the appropriate regional settings to restore people search functionality.

## Symptoms

With Microsoft Exchange Server 2019 installed on a Windows Server 2019 (Server Core), when trying to find a contact in the global address list (GAL) in Outlook on the web, you receive the following error message:

> Can't connect. Please try again later

## Cause

The default language and locale of Windows Server 2019 aren't US English. The Advanced Query Syntax (AQS) Windows module requires the installation of the corresponding language pack on the server.

## Resolution

Install the English language pack using the corresponding language .cab files from [Language Pack ISO for Windows Server](/windows-hardware/manufacture/desktop/add-language-packs-to-windows). Check if the package is installed by using the following steps:

1. From a Command prompt, run the following command:

    ```console
    intl.cpl
    ```

1. On the **Formats** tab, make sure that the format is set to **English (United States)**.

    :::image type="content" source="media/can't-connect-error-searching-people-owa/region-format.png" alt-text="Screenshot of the window for format settings.":::

1. On the **Administrative** tab, select **Copy settings** and make sure that the settings are also set to **English (United States)**.

    :::image type="content" source="media/can't-connect-error-searching-people-owa/region-settings.png" alt-text="Screenshot of the window for region settings.":::
