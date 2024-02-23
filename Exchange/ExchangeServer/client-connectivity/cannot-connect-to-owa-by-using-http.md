---
title: Cannot connect to Outlook Web App via HTTP protocol
description: Works around a problem in which users cannot connect to Outlook Web App by using the HTTP protocol after you apply Exchange Server 2010 SP2.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2010
search.appverid: MET150
ms.date: 01/24/2024
---
# Users can't connect to Outlook Web App by using the HTTP protocol in Exchange Server 2010

_Original KB number:_ &nbsp; 2748253

## Symptoms

After you apply Exchange Server 2010 Service Pack 2 (SP2), users can't connect to Outlook Web App by using the HTTP protocol. This problem occurs even if you disable the **Require secure channel (SSL)** option in the Outlook Web App virtual directory.

## Cause

This problem occurs because Exchange Server 2010 SP2 uses the HTTPS protocol to connect to Outlook Web App.

## Workaround

To work around this problem, follow these steps:

1. In the Client Access Server (CAS) server that hosts the Outlook Web App, open the Web.config file by using Notepad. By default, the Web.config file is installed in the following location:  
   C:\Program files\Microsoft\Exchange Server\V14\ClientAccess\OWA

2. Locate the following code:

    ```console
    <httpCookieshttpOnlyCookies="false" requireSSL="true" domain="" />
    ```

3. Change the value of the `requireSSL` attribute to **false**, as in the following example:

    ```console
    <httpCookieshttpOnlyCookies="false" requireSSL="false" domain="" />
    ```

4. Make sure that the new value takes effect. To do this, run the `iisreset /noforce` command to restart Internet Information Services (IIS).
