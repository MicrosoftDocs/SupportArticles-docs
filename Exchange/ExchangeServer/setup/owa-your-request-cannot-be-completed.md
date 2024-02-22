---
title: OWA error—Your request cannot be completed right now after updating to Exchange Server 2013 CU 11 or later
description: Solves an issue where you receive a (Request cannot be completed right now) error when you open, reply to, or forward items in Outlook Web App, or sign in Outlook Web App or select different folders.
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
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Error in Outlook Web App after an upgrade to Exchange Server 2013 CU 11 or later: Your request cannot be completed right now

_Original KB number:_ &nbsp;3191636

## Symptoms

In a Microsoft Exchange Server 2013 environment that has been upgraded to Cumulative Update (CU) 11 or later, you experience one or more of the following symptoms in Outlook Web App (OWA):

- You receive a **Request cannot be completed right now. Please try again later** error message when you try to open, reply to, or forward items in Outlook Web App.
- When you try to sign in to Outlook Web App or select different folders, you also meet this error.

Additionally, the following event is logged repeatedly in the Windows Application log:

```console
Time:     7/05/2016 2:20:24 PM
ID:       4999
Level:    Error
Source: MSExchange Common
Machine:  MBX1.contoso.com
Message:  Watson report about to be sent for process id: 10472, with parameters: E12IIS, c-RTL-AMD64, 15.00.1178.004, w3wp#MSExchangeOWAAppPool, m.exchange.services, M.E.S.C.T.IdConverter.ConvertId, System.MissingMethodException, a16f, 15.00.1104.003.
ErrorReportingEnabled: False
```

## Cause

When a cumulative update is applied, the setup bits for any previous cumulative update exist in the Exchange installation directory's Bin subdirectory. For example: in *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Setup*.

When you run the Setup process in this scenario, the SharedWebConfig.config file that's located in *C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess (Mailbox role)* or *C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy (Client Access role)* points to *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Setup*. These files aren't updated by the Setup process.

## Resolution

To resolve the issue, follow these steps to remove the files from *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Setup* and update the SharedWebConfig.config files to point to the correct locations:

1. At an elevated command prompt, run the following command to stop IIS services to allow access to the files:

    ```console
    iisreset /stop
    ```

1. Move the *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Setup* folder to another directory location outside of the Exchange installation path. For example, move it to *C:\TEMP\Setup*.
1. Make a backup copy of the SharedWebConfig.config file in both *C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess* and *C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy* in an alternative location.
1. At an elevated command prompt, run `cd %ExchangeInstallPath%\bin` to change to the correct directory. Then, run the following command to rebuild the SharedWebConfig.config file in *C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess*:

    ```console
    DependentAssemblyGenerator.exe -exchangePath "%ExchangeInstallPath%\bin" -exchangePath "%ExchangeInstallPath%\ClientAccess" -configFile "%ExchangeInstallPath%\ClientAccess\SharedWebConfig.config"
    ```

1. At elevated command prompt, run the following command to rebuild the SharedWebConfig.config file in *C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy*:

    ```console
    DependentAssemblyGenerator.exe -exchangePath "%ExchangeInstallPath%\bin" -exchangePath "%ExchangeInstallPath%\FrontEnd\HttpProxy" -configFile "%ExchangeInstallPath%\FrontEnd\HttpProxy\SharedWebConfig.config"
    ```

1. At an elevated command prompt, run the following command to restart IIS services:

    ```console
    iisreset /start
    ```
